#ifndef __DYNTHRESH_H_
#define __DYNTHRESH_H_

/* available aperture slider range is 3 to 255 */
#define MINAPERTURE 3
#define MAXAPERTURE 255

/* density and sensitivity slider range is -12 to +12 */
#define densityRANGE 12
#define sensitivityRANGE 12

#define PHOTOMETRIC_MINISWHITE 0
#define PHOTOMETRIC_MINISBLACK 1

/* NOTE Comments below suggest default values. */
int dynthresh(
	unsigned char * raster, /*- the input */
	unsigned char * outbytes, /*- the output NOTE Caller must initiallize this buffer to all white! */
	int width, int height, int photometric, /*- input and output characteristics */
	int density/*=0*/,
	int sensitivity/*=-6*/,
	int minaperture/*=4*/,
	int maxaperture/*=4*/,
	int apshape/*='*'*/
);

/*

Method of Extracting Bitonal Patterns from Grayscale Digitized Images

by Roy Lomicka, February 1992

Background of the Method

On February 13, 1992, using Adobe Photoshop on an Apple Macintosh personal
computer, I observed the effect of using different static thresholds when
converting grayscale images to bitonal form. The effect was that if the
threshold was set to a value between the dark and light values, then a
bitonal image could be produced which faithfully reproduced patterns I
observed in the grayscale image. Upon observing that different threshold
values worked well in different parts of the image, I conceived of the
idea of dynamically setting the threshold for each pixel as a function of
values of nearby pixels. Since the size of the interesting features in my
sample image was relatively constant at about 12 pixels, I felt that good
results might be obtained for extracting those features as bitonal patterns
by using a fixed size aperture of approximately the same size. After first
working with the fixed aperture size, I decided to make the size of the
aperture adaptive. The adaptive aperture is designed such that areas of
high contrast are viewed through a small aperture, and areas of low contrast
are viewed with a larger aperture. With this enhanced method, I observed
improvement in efficiency of execution and in accuracy of output.

The Method

An array of grayscale image data samples is processed in a manner that
preserves relative lightness and darkness in local areas while reducing
the grayscale range to the minimum: black and white. The key to successful
processing is making the correct decision in areas having little contrast.

Each grayscale sample is evaluated relative to nearby samples. If the sample
is determined to represent relative darkness, then the corresponding point
in the output is set to the color black. All other output points remain white,
or un-inked, which is the initial state of the output array. The essence of
the method is the technique used for determining relative darkness. There are
four parameters available to influence the decision: /density/, /sensitivity/,
and /aperturesize /, and /aperture shape/.

/density/ In the case where sufficient contrast is detected to make a
decision, a density parameter biases the decision toward black (high density)
or toward white (low density).

/sensitivity/ A sensitivity parameter determines the amount of contrast
that is considered sufficient for the dynamic threshold process to operate.
With high sensitivity, very small amounts of contrast will suffice, resulting
in an output image that will highlight small contrast variations. With low
sensitivity, larger contrast variations are required before an adaptive
threshold is set.

/aperture size/ It is necessary to choose the size of the local area. A
minimum aperture is chosen and points within it are evaluated for contrast.
If sufficient contrast is seen within the aperture, then a decision is made,
otherwise the aperture is enlarged and the decision process is attempted
again. If iterating to an arbitrarily large aperture size still does not
yield sufficient contrast, then the point is output as a white spot. The
minimum and maximum aperture sizes are parameters to the process, and may be
chosen with knowledge of the information being processed.

Aperture shape is a set of points extending radially from the point for which
a threshold is being established. The caller chooses among five aperture
shapes, denoted as vbar(|), minus(-), plus(+), x(x), and star(*). Plus and x
each use four radial sets of points. Vbar and minus each use two. Star uses
eight.

*/

#endif
