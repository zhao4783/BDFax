#include <stdlib.h>
#include <string.h>

#include "dither.h"

/* ""DT" for DynamicThreshold or "FS" for Floyd-Steinberg */
const char * Method = "FS";

/* parameters for DynamicThreshold method */
int Sensitivity = -6; /*- -12 to 12 */
int Density = 0; /*- -12 to 12 */
int MinAperture = 4; /*- 3 to 255 */
int MaxAperture = 4; /*- 3 to 255 */
char ApShape[2] = "*"; /*- * + x | or - */

/* color weights for compresscontig and compresspalette */
#define	PCT(x) (((x)*255+127)/100)
int	RED = PCT(30);		/* 30% */
int	GREEN = PCT(59);	/* 59% */
int	BLUE = PCT(11);		/* 11% */

/* convert 24bit RGB (or 32bit RGBA) data into 8bit grayscale */
static void compresscontig(
	unsigned char * out,
	unsigned const char* rgb,
	int n,
	int samplesperpixel
/*  out - grayscale 8 bit output
	rgb - 24bit RGB or 32bit RGBA input
	samplesperpixel - 3 or 4
*/
){
	int v, red = RED, green = GREEN, blue = BLUE;

	while (n-- > 0)
	{
		v = red*(*rgb++);
		v += green*(*rgb++);
		v += blue*(*rgb++);
		*out++ = v>>8;
		if (samplesperpixel == 4)
			rgb++; /* skip alpha channel */
	}
}

/* convert rgb 8 bit data to 8bit grayscale data using palette */
static void compresspalette(
	unsigned char * out,
	unsigned const char * data,
	int width,
	int bpp,
	unsigned short * rmap,
	unsigned short * gmap,
	unsigned short * bmap
){
	int v, red = RED, green = GREEN, blue = BLUE;

	if (bpp == 4)
	{
		int j; 
		for (j = 0; j < width; ++j)
		{
			unsigned int ix = 
				(j % 2 == 0) ?
				(*data >> 4) :
				(*data++ & 0x0f);
			v = red*rmap[ix];
			v += green*gmap[ix];
			v += blue*bmap[ix];
			*out++ = v>>8;
		}
	}
	else
	{
		while (width-- > 0)
		{
			unsigned int ix = *data++;
			v = red*rmap[ix];
			v += green*gmap[ix];
			v += blue*bmap[ix];
			*out++ = v>>8;
		}
	}
}

/* determine whether colormap is 8 bit or 16 bit (16 bit if has a value > 256 */
static int checkcmap(
	int n,
	unsigned short * r,
	unsigned short * g,
	unsigned short * b
){
	while (n-- > 0)
		if (*r++ >= 256 || *g++ >= 256 || *b++ >= 256)
		{
			return (16);
		}
	/* assume 8 bit color map */
	return (8);
}

/*
 * Floyd-Steinberg Dithering
 *
 * (http://www.visgraf.impa.br/Courses/ip00/proj/Dithering1/floyd_steinberg_dithering.html)
 *
 */
static int threshold = 128;
static void FSDitherLeftToRight(
	short * thisptr,
	short * nextptr,
	unsigned char * outptr,
	int width,
	int lastline
){
	int bit = 0x80;

	{
		int j; for (j = 0; j < width; ++j)
		{
			int lastpixel = (j == width-1);
			int firstpixel = (j == 0);

			{
				int v = *thisptr++;
				if (v < 0)
					v = 0;
				else if (v > 255)
					v = 255;
				if (v > threshold)
				{
					*outptr |= bit; /*- set a white bit */
					v -= 255;
				}

				/* go to next left to right pixel in output */
				{
					bit >>= 1;
					if (bit == 0)
					{
						outptr++;
						bit = 0x80;
					}
				}

				if (!lastpixel)
				{
					thisptr[0] += v*7/16;
				}

				if (!lastline)
				{
					if (!firstpixel)
					{
						nextptr[-1] += v*3/16;
					}

					*nextptr++ += v*5/16;

					if (!lastpixel)
					{
						nextptr[0] += v/16;
					}
				}
			}
		}
	}
}
static void FSDitherRightToLeft(
	short * thisptr,
	short * nextptr,
	unsigned char * outptr,
	int width,
	int lastline,
	unsigned char * outline,
	int outlinesize
){
	int bit = 0x1;

	thisptr += (width-1);
	nextptr += (width-1);
	outptr += (outlinesize-1);

	{
		int j; for (j = width-1; j >= 0; --j)
		{
			int lastpixel = (j == 0);
			int firstpixel = (j == width-1);

			{
				int v = *thisptr--;
				if (v < 0)
					v = 0;
				else if (v > 255)
					v = 255;
				if (v > threshold)
				{
					*outptr |= bit; /*- set a white bit */
					v -= 255;
				}

				/* go to next right to left pixel in output */
				{
					bit <<= 1;
					if (bit > 0x80)
					{
						outptr--;
						bit = 0x1;
					}
				}

				if (!lastpixel)
				{
					thisptr[0] += v*7/16;
				}

				if (!lastline)
				{
					if (!firstpixel)
					{
						nextptr[1] += v*3/16;
					}

					*nextptr-- += v*5/16;

					if (!lastpixel)
					{
						nextptr[0] += v/16;
					}
				}
			}
		}
	}

	/* align the right-to-left output to start at byte border */
	{
		int off = 8 * outlinesize - width;
		if (off > 0)
		{
			int k; for (k = 0; k < outlinesize; k++)
			{
				outline[k] <<= off;
				if (k < outlinesize-1)
				{
					outline[k] |= (outline[k+1] >> (8-off));
				}
			}
		}
	}
}
static void FloydSteinberg(
	unsigned char * graybuffer,
		/*- input image data, width * height bytes */
	int width,
		/*- pixels per scanline */
	int height,
		/*- scanlines */
	unsigned char * outbuffer,
		/*- output buffer, outlinesize * height bytes */
	int outlinesize,
		/*- bytes (large enough to accomodate width bits) */
	int photometric
		/*- desired output photometric value, PHOTOMETRIC_MINISWHITE (0) or PHOTOMETRIC_MINISBLACK (1) */
){
	int imax = height; /*- i is one-based */

	/* get work buffers */
	unsigned char * inputline = (unsigned char *) malloc(width);
	unsigned char * outline = (unsigned char *) malloc(outlinesize);
	short * thisline = (short *) malloc(width * sizeof (short));
	short * nextline = (short *) malloc(width * sizeof (short));

	/* erase passed-in output buffer (working in PHOTOMETRIC_MINISBLACK; will set 1s in white bits */
	memset(outbuffer, 0, outlinesize*height);

#if 0
	// create debugging pattern
	{
		int patern = 2;
		{
			int i; for (i = 0; i < height; i++)
			{
				int j; for (j = 0; j < width; j++)
				{
					switch (pattern)
					{
					case 1:
						graybuffer[i*width + j] = (j % 255);
						break;
					case 2:
						graybuffer[i*width + j] = (j % 7 == 0 || (j-1) % 7 == 0 || (j-2) % 7 == 0) ? 255 : 0;
						break;
					case 3:
						graybuffer[i*width + j] = ((j%2==0 && i%2==0) || (j%2==1 && i%2==1)) ? 255 : 0;
						break;
					}
				}
			}
		}
	}
#endif

	/* copy first scanline to inputline work buffer */
	memcpy(inputline, graybuffer, width);

	/* copy first scanline to nextline work buffer */
	{
		unsigned char * inptr  = inputline;
		short * nextptr = nextline;

		{
			int j; for (j = 0; j < width; ++j)
			{
				*nextptr++ = *inptr++;
			}
		}
	}

	/* process all of the scanlines */
	{
		int i; for (i = 1; i <= height; ++i)
		{
			int lastline = (i == imax);

			/* swap thisline and nextline work buffers */
			{
				short * tmpptr = thisline;
				thisline = nextline;
				nextline = tmpptr;
			}

			/* copy next scanline, if any, into inputline work buffer */
			{
				if (!lastline)
				{
					memcpy(inputline, graybuffer+i*width, width);
				}
			}

			/* copy next scanline to nextline work buffer */
			{
				unsigned char * inptr = inputline;
				short * nextptr = nextline;
				{
					int j; for (j = 0; j < width; ++j)
					{
						*nextptr++ = *inptr++;
					}
				}
			}

			/* clear outline work buffer */
			memset(outline, 0, outlinesize);

			/* dither a scanline into the outline work buffer */
			{
				short * thisptr = thisline;
				short * nextptr = nextline;
				unsigned char * outptr = outline;

				/* alternate going left-to-right and right-to-left (try to minimize artifcats) */
				if (i % 2 == 1)
				{
					FSDitherLeftToRight(
						thisptr,
						nextptr,
						outptr,
						width,
						lastline
					);
				}
				else
				{
					FSDitherRightToLeft(
						thisptr,
						nextptr,
						outptr,
						width,
						lastline,
						outline,
						outlinesize
					);
				}
			}

			/* copy outline work buffer into outbuffer (note that i is 1-based) */
			{
				memcpy(outbuffer + (i-1)*outlinesize, outline, outlinesize);
			}
		}
	}

	/* invert bits if output is PHOTOMETRIC_MINISWHITE */
	if (photometric == PHOTOMETRIC_MINISWHITE)
	{
		int i; for (i = 0; i < outlinesize*height; i++)
		{
			outbuffer[i] ^= 255;
		}
	}

	free(inputline);
	free(thisline);
	free(nextline);
	free(outline);
}

static void ColorToGray(
	unsigned char * inbuffer,
		/*- input image; gray, rgb, or rgba; direct or palette */
	int width,
		/*- width of the image in pixels */
	int height,
		/*- height of the image in pixels */
	int spp,
		/*- samples per pixel (1, 3 or 4) */
	int bpp,
		/*- bits per pixel (4 or 8) */
	unsigned char * graybuffer,
		/*- output buffer, size width*height */
	unsigned short * rmap, unsigned short * gmap, unsigned short * bmap
		/*- color maps; NULL if color is direct */
){
	{
		int i; for (i = 0; i < height; i++)
		{
			if (spp > 1)
			{	/* have separate rgb values */
				compresscontig(graybuffer + i*width, inbuffer + i*width*spp, width, spp);
			}
			else if (rmap && gmap && bmap)
			{	/* one sample per pixel and have palette - convert to grayscale */
				if (bpp == 4)
				{
					compresspalette(graybuffer + i*width, inbuffer + i*((width + 1)/2), width, bpp, rmap, gmap, bmap);
				}
				else
				{
					compresspalette(graybuffer + i*width, inbuffer + i*width, width, bpp, rmap, gmap, bmap);
				}
			}
			else
			{	/* already grayscale - just copy */
				switch (bpp)
				{
				case 4:
					{
						int j; for (j = 0; j < width; ++j)
						{
							unsigned char val = (
								(j % 2 == 0) ?
								(inbuffer[i*width/2 + j/2] >> 4) :
								(inbuffer[i*width/2 + j/2] & 0x0f)
							);
							graybuffer[i*width + j] = val << 4;
						}
					}
					break;
				default:
					memcpy(graybuffer + i*width, inbuffer + i*width, width);
					break;
				}
			}
		}
	}
}

/*
 * Dynamic Threshold
 */
#include "dynthresh.h"
static void DynamicThreshold(
	unsigned char * graybuffer,
		/*- input image data, width * height bytes */
	int width,
		/*- pixels per scanline */
	int height,
		/*- scanlines */
	unsigned char * outbuffer,
		/*- output buffer, outlinesize * height bytes */
	int outlinesize,
		/*- bytes (large enough to accomodate width bits) */
	int photometric,
		/*- desired output photometric value, PHOTOMETRIC_MINISWHITE (0) or PHOTOMETRIC_MINISBLACK (1)  */
	/* parameters for DynamicThreshold method */
	int sensitivity/* = -6*/, /*- -12 to 12 */
	int density/* = 0*/, /*- -12 to 12 */
	int minaperture/* = 4*/, /*- 3 to 255 */
	int maxaperture/* = 4*/, /*- 3 to 255 */
	const char * apshape/* = "*"*/ /*- * + x | or - */
){
	unsigned char * dtoutbuffer = (unsigned char *) malloc(width * height);
	memset(dtoutbuffer, 255, width * height);
	dynthresh(graybuffer, dtoutbuffer, width, height, PHOTOMETRIC_MINISBLACK, density, sensitivity, minaperture, maxaperture, (int)apshape);
	FloydSteinberg(dtoutbuffer, width, height, outbuffer, outlinesize, photometric);
}

void ColorToMonochrome(
	unsigned char * inbuffer,
		/*- input image; gray, rgb, or rgba; direct or palette */
	int width,
		/*- width of the image in pixels */
	int height,
		/*- height of the image in pixels */
	int spp,
		/*- samples per pixel (1, 3 or 4) */
	int bpp,
		/*- bits per pixel (4 or 8) */
	unsigned char * outbuffer,
		/*- output monochrome buffer, packed one-bit per pixel, size outlinesize*height */
	int outlinesize,
		/*- size in bytes of a scanline in the output buffer */
	int numcolors,
		/*- number of colors in the following palettes */
	unsigned short * rmap, unsigned short * gmap, unsigned short * bmap,
		/*- color maps; NULL if color is direct */
	int photometric,
		/*- desired output photometric value, PHOTOMETRIC_MINISWHITE (0) or PHOTOMETRIC_MINISBLACK (1) */
	const char * method,
		/*- "DT" or "FS" */
	/* parameters for DynamicThreshold method */
	int sensitivity/* = -6*/, /*- -12 to 12 */
	int density/* = 0*/, /*- -12 to 12 */
	int minaperture/* = 4*/, /*- 3 to 255 */
	int maxaperture/* = 4*/, /*- 3 to 255 */
	const char * apshape/* = "*"*/ /*- * + x | or - */
){
	/* first convert to grayscale */
	unsigned char * graybuffer = NULL;
	if ((spp > 1) || (rmap && gmap && bmap))
	{
		graybuffer = (unsigned char *) malloc(width * height);

		if (rmap && gmap && bmap)
		{
			/*
			* Convert 16-bit colormap to 8-bit (unless it looks
			* like an old-style 8-bit colormap).
			*/
			if (checkcmap(numcolors, rmap, gmap, bmap) == 16)
			{
				int i;
#define	CVT(x) (((x) * 255L) / ((1L<<16)-1))
				for (i = numcolors-1; i >= 0; i--)
				{
					rmap[i] = CVT(rmap[i]);
					gmap[i] = CVT(gmap[i]);
					bmap[i] = CVT(bmap[i]);
					//printf("%d (%d, %d, %d)\n", i, rmap[i], gmap[i], bmap[i]);
				}
#undef CVT
			}
		}

		/* convert to grayscale */
		ColorToGray(
			inbuffer, width, height, spp, bpp,
			graybuffer,
			rmap, gmap, bmap
		);
	}
	else
	{
		graybuffer = inbuffer;
	}

	if (strcmp(method, "DT") == 0)
	{
		DynamicThreshold(
			graybuffer, width, height,
			outbuffer, outlinesize,
			photometric,
			sensitivity, density,
			minaperture, maxaperture, apshape
		);
	}
	else
	{
		FloydSteinberg(
			graybuffer, width, height,
			outbuffer, outlinesize,
			photometric
		);
	}

	if ((spp > 1) || (rmap && gmap && bmap))
	{
		free(graybuffer);
	}
}

