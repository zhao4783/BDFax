#include "dynthresh.h"

#ifdef LOG_APERTURES
#include <stdio.h>
#endif

#ifndef max
#define max(a,b)    (((a) > (b)) ? (a) : (b))
#endif

#ifndef min
#define min(a,b)    (((a) < (b)) ? (a) : (b))
#endif

#define PHOTOMETRIC_MINISWHITE 0
#define PHOTOMETRIC_MINISBLACK 1

static void normalize_gray(
	unsigned char * raster,
	int width,
	int height,
	int photometric
)
{
	unsigned char * endpoint = raster + width * height;

	/* compute histogram */
	int hist[256] = {0};
	{
		unsigned char * p0; for (p0 = raster; p0 < endpoint;)
		{
			++hist[*p0++];
		}
	}

	/* eliminate likely boundary anomolies from histogram */
	hist[0] = 0; hist[127] = 0; hist[128] = 0; hist[255] = 0;

	/* eliminate infrequent values from histogram */
	{
		int thresh = max(width * height / 10000, 2);
		{
			int * p1; for (p1 = hist; p1 <= (hist+255);)
			{
				if (*p1 < thresh)
					*p1++ = 0;
				else
					++p1;
			}
		}
	}

	{
		int mingray = 255; int maxgray = 0;

		/* find min & max gray */
		{
			int i; for (i = 0; i <= 255; ++i)
			{
				if (hist[i] != 0)
				{
					mingray = i;
					break;
				}
			}
		}
		{
			int i; for (i = 255; i >= 0; i--)
			{
				if (hist[i] != 0)
				{
					maxgray = i;
					break;
				}
			}
		}
		if (mingray >= maxgray)
		{
			mingray = 0;
			maxgray = 255;
		}
		else if (mingray == 1)
		{
			mingray = 0;
		}
		else if (maxgray == 254)
		{
			maxgray = 255;
		}

		if (mingray != 0 || maxgray != 255 || photometric == PHOTOMETRIC_MINISWHITE)
		{	/* apply min & max gray */
			int range = maxgray - mingray;
			if (photometric != PHOTOMETRIC_MINISWHITE)
			{	/* PHOTOMETRIC_MINISBLACK - don't invert */
				if (range != 255) /*- (range == 255 requires no action here) */
				{
					unsigned char * p0; for (p0 = raster; p0 < endpoint; ++p0)
					{
						*p0 = max(0, min(255, ((*p0 - mingray) * 255) / range));
					}
				}
			}
			else
			{	/* PHOTOMETRIC_MINISWHITE - invert */
				unsigned char * p0; for (p0 = raster; p0 < endpoint; ++p0)
				{
					*p0 = max(0, min(255, (255 - ((*p0 - mingray) * 255) / range)));
				}
			}
		}
	}
}

int xfactor[2][4]={ /* e: add 1  w: subtract 1 */
	{
		/* 0 0 n  */  0,
		/* 0 1 e  */  1,
		/* 0 2 s  */  0,
		/* 0 3 w  */ -1
	},
	{
		/* 1 0 ne */  1,
		/* 1 1 se */  1,
		/* 1 2 sw */ -1,
		/* 1 3 nw */ -1
	}
};

int yfactor[2][4]={ /* s: add 1  n: subtract 1 */
	{
		/* 0 0 n  */ -1,
		/* 0 1 e  */  0,
		/* 0 2 s  */  1,
		/* 0 3 w  */  0
	},
	{
		/* 1 0 ne */ -1,
		/* 1 1 se */  1,
		/* 1 2 sw */  1,
		/* 1 3 nw */ -1
	}
};

/*
				N
	NW					   NE
	· · · · · · · · · · · · ·
	· · · · · · 9 · · · · · ·
	· · 8 · · · 7 · · · 8 · ·
	· · · 6 · · 5 · · 6 · · ·
	· · · · 4 · 3 · 4 · · · ·
	· · · · · 2 1 2 · · · · ·
W	· 9 7 5 3 1 0 1 3 5 7 9 ·	E
	· · · · · 2 1 2 · · · · ·
	· · · · 4 · 3 · 4 · · · ·
	· · · 6 · · 5 · · 6 · · ·
	· · 8 · · · 7 · · · 8 · ·
	· · · · · · 9 · · · · · ·
	· · · · · · · · · · · · ·
	SW					   SE
				S
*/

/*
	p=center point of aperture  i=distance 0, 1, 2, ...
	points in above picture are numbered (i)
	xfactor[j][d], yfactor[j][d] give ap offset from p in raster
	where j = 0, 1; d = 0, 1, 2, 3;
	if j=0, direction is n, e, s, w
	if j=1, direction is ne, se, sw, nw
*/

/* ap is aperture point */
/* p is center point of aperture */
/* i is distance as indicated in in above picture */
#ifdef USE_FUNCTIONS
static unsigned char * ap(unsigned char *p, int i, int j, int n, int width) { return ((p) + (use_x != 0) * ((xfactor[(j)][(n)]) * (i)) + (use_y != 0) * ((yfactor[(j)][(n)]) * ((i) * (width)))); }
static void X(int A, int * p_mingray, int * p_maxgray) { if ((A) > *p_maxgray) *p_maxgray = (A); if ((A) < *p_mingray) *p_mingray = (A); }
static void XX(unsigned char * raster, unsigned char * p1, unsigned char * endpoint, int * p_mingray, int * p_maxgray) { if ((p1 >= raster) && (p1 < endpoint)) { X(*p1, p_mingray, p_maxgray); } }
#else /* The macros for these actions are MUCH more efficient than the functions in the debug build. */
#define ap(p, i, j, n, width, use_x, use_y) ((p) + (use_x != 0) * ((xfactor[(j)][(n)]) * (i)) + (use_y != 0) * ((yfactor[(j)][(n)]) * ((i) * (width))))
#define X(A, p_mingray, p_maxgray) { if ((A) > *p_maxgray) *p_maxgray = (A); if ((A) < *p_mingray) *p_mingray = (A); }
#define XX(raster, p1, endpoint, p_mingray, p_maxgray) { if ((p1 >= raster) && (p1 < endpoint)) { X(*p1, p_mingray, p_maxgray); } }
#endif

static void dynap(
	int black, /*- 0 or 255 */
	int apshape,
	unsigned char * p0,
	unsigned char * raster, unsigned char * endpoint,
	int width, int height, 
	int minaperture, int maxaperture,
	int density, int sensitivity,
#ifdef LOG_APERTURES
	int * apertures,
#endif
	int current_x, int current_y,
	unsigned char * outbytes
){
	int background = 1;

	int mingray = *p0;
	int maxgray = *p0;

	int use_x = (apshape != '|');
	int use_y = (apshape != '-');

	int i, j;
	{
		for (
			i = 1, j = ((apshape == 'x') ? (1) : (0));
			i <= minaperture;
			(
				apshape != '*') ?
				(++i) :
				((j > 0) ? (j = 0, ++i) : (++j)
			)
		)
		{							
			int n;  for (n = 0; n <= 3; ++n)
			{
				unsigned char * p1 = ap(p0, i, j, n, width, use_x, use_y); XX(raster, p1, endpoint, &mingray, &maxgray);
			}
		}
	}

	--i;

	/* detect background by insufficient contrast */
	if ((maxgray - mingray) < sensitivity)
	{	/* no contrast - expand aperture */
		j = 0;
		if (i % 2 == 0)
		{	/* even aperture - start with j=1 if using x or * */
			if (apshape != '+')
			{
				j = 1;
			}
		}
		for (
			;
			i <= maxaperture;
			(
				(apshape != '+') ?
				(
					((j > 0) ? (j = 0, ++i) : (++j))
				) :
				(
					++i
				)
			)
		)
		{
			{
				int n;  for (n = 0; n <= 3; ++n)
				{
					unsigned char * p1 = ap(p0, i, j, n, width, use_x, use_y); XX(raster, p1, endpoint, &mingray, &maxgray);
				}
			}

			if ((maxgray - mingray) >= sensitivity)
			{	/* found large enough aperture - use it */
				background = 0;
#ifdef LOG_APERTURES
				++apertures[i]; /*- aperture usage log */
#endif
				break;
			}
		}
	}
	else
	{	/* have some contrast - use local threshold */
		background = 0;
#ifdef LOG_APERTURES
		++apertures[i]; /*- aperture usage log */
#endif
	}

#ifdef LOG_APERTURES
	if (background)
	{
		++apertures[maxaperture+1]; /*- aperture usage log */
	}
#endif

	if (!background)
	{
		if ((current_x > i && current_x < (width-i) && current_y > i && current_y < (height-i)))
		{	/* have some contrast in aperture - use local threshold */
			int thresh = ((maxgray * density) + (mingray * (32-density))) / 32;
			if (*p0 <= thresh)
			{
				outbytes[current_y * width + current_x] = black;
			}
		}
	}
}

#define densityNOMINAL 16
#define densityMIN (densityNOMINAL - densityRANGE)
#define densityMAX (densityNOMINAL + densityRANGE)
#define sensitivityNOMINAL 17
#define sensitivityMIN (sensitivityNOMINAL - sensitivityRANGE)
#define sensitivityMAX (sensitivityNOMINAL + sensitivityRANGE)

int dynthresh(
	unsigned char * raster,
	unsigned char * outbytes,
	int width, int height, int photometric,
	int density/*=0*/,
	int sensitivity/*=-6*/,
	int minaperture/*=4*/,
	int maxaperture/*=4*/,
	int apshape/*='*'*/
){
#ifdef LOG_APERTURES
	int apertures[MAXAPERTURE+2] = {0}; /*- aperture usage log */
#endif

	int black = ((photometric == PHOTOMETRIC_MINISBLACK) ? (0) : (255));

	/* initialize aperture pointer */
	unsigned char * p0 = raster;

	/* validate aperture */
	if (maxaperture < 3)
	{
		maxaperture = MINAPERTURE;
	}
	if (maxaperture > MAXAPERTURE)
	{
		maxaperture = MAXAPERTURE;
	}
	if (minaperture > maxaperture)
	{
		minaperture = maxaperture;
	}

	/* change input density and sensitivity to thier internal form */
	density = density + densityNOMINAL;
	sensitivity = sensitivity + sensitivityNOMINAL;
	sensitivity = 2 * ((2 * sensitivityNOMINAL) - sensitivity);

	normalize_gray(raster, width, height, photometric);
	photometric = PHOTOMETRIC_MINISBLACK;

	/* scan raster */
	{
		int w1 = width-1;
		unsigned char * endpoint = raster + width * height;
		int s1 = (255 - (sensitivity/2));
#if WRITE_BLACK
		int s2 = (      (sensitivity/2));
#endif
		{
			int current_x; int current_y; for (
				current_x = 0,  current_y = 0;
				p0 < endpoint;
				((current_x < w1) ? (++current_x) : (++current_y, current_x = 0))
			)
			{
				/* each  point is white, black, or gray */
				if ((*p0) > (s1))
				{ /* white - do nothing - outbit is already white */
#ifdef LOG_APERTURES
					++apertures[0]; /*- aperture usage log (white) */
#endif
				}
#if WRITE_BLACK
				else if ((*p0) < (s2))
				{ /* black - write a pixel */
					outbits[current_y * width + current_x] = black;
#ifdef LOG_APERTURES
					++apertures[1]; /*- aperture usage log (black) */
#endif
				}
#endif
				else
				{	/* gray - apply dynamic threshold */

					dynap(
						black,
						apshape,
						p0,
						raster, endpoint,
						width, height, 
						minaperture, maxaperture,
						density, sensitivity,
#ifdef LOG_APERTURES
						apertures,
#endif
						current_x, current_y,
						outbytes
					);
				}

				/* increment the aperture */
				++p0;
			}
		}

#ifdef LOG_APERTURES
		{	/* aperture usage log */
			unsigned atot = 0;
			{
				fprintf(stderr, "static white used %d times\n", apertures[0]); atot += apertures[0];
#if WRITE_BLACK
				fprintf(stderr, "static black used %d times\n", apertures[1]); atot += apertures[1];
#endif
				{
					int i; for (i = minaperture; i <= (maxaperture); ++i)
					{
						fprintf(stderr, "dynamic aperture %d used %d times\n", i, apertures[i]); atot += apertures[i];
					}
				}
				fprintf(stderr, "background used %d times\n", apertures[maxaperture+1]); atot += apertures[maxaperture+1];
			}
			fprintf(stderr, "total %d\n", atot);
		}
#endif
	}

	return 0;
}
