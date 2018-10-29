#if !defined(__DITHER_H__)
#define __DITHER_H__

/* implicit parameter for fsdither */
/* ""DT" for DynamicThreshold or "FS" for Floyd-Steinberg */
extern const char * Method/* = "FS"*/;

/* parameters for DynamicThreshold method */
extern int Sensitivity/* = -6*/; /*- -12 to 12 */
extern int Density/* = 0*/; /*- -12 to 12 */
extern int MinAperture/* = 4*/; /*- 3 to 255 */
extern int MaxAperture/* = 4*/; /*- 3 to 255 */
extern char ApShape[2]/* = "*"*/; /*- * + x | or - */

#define PHOTOMETRIC_MINISWHITE 0
#define PHOTOMETRIC_MINISBLACK 1

/* 
 * Color to Monochrome
 *
 * inbuffer - 24 bit per pixel rgb-encoded input image
 * outbuffer - 1 bit per pixed monochrome output image
 * imagewidth, imagelength - size of the image in pixels
 * spp - samples per pixel 1, 3 or 4
 * bpp - bits per pixel 4 or 8
 *
 * NOTE: since output will be most likely written to a
 * group 3 or group 4 encoded TIFF file we invert the
 * image because PHOTOMETRIC_MINISWHITE is the desired
 * photometric setting since there are apps that don't
 * support PHOTOMETRIC_MINISBLACK.
 *
 */
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
);

#define fsdither(\
	inbuffer, width, height, spp, bpp,\
	outbuffer, outlinesize,\
	numcolors, rmap, gmap, bmap,\
	invert\
)\
ColorToMonochrome(\
	inbuffer, width, height, spp, bpp,\
	outbuffer, outlinesize,\
	numcolors, rmap, gmap, bmap,\
	!(invert),\
	Method,\
	Sensitivity, Density,\
	MinAperture, MaxAperture,\
	ApShape\
)

#endif // __DITHER_H__

