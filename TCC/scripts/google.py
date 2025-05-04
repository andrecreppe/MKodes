"""
Star detection in Python often involves using image processing techniques and astronomical libraries. Here's an outline of the process, along with common libraries and methods:
Libraries:
- photutils: Specifically designed for astronomical image analysis, it provides tools for source detection, including star finding.
- astropy: Essential for handling FITS files (a standard format in astronomy) and performing astronomical calculations.
- opencv-python: Useful for general image processing tasks like noise reduction, thresholding, and contour detection, which can aid in star detection.
- scipy: Provides functions for fitting Gaussian distributions, which can be used to model the shape of stars.

Methods:
- DAOFIND Algorithm: Implemented in photutils, this algorithm searches for local density maxima in an image that resemble a 2D Gaussian kernel, effectively identifying star-like objects.
IRAF's starfind Algorithm: Also available in photutils, this algorithm is similar to DAOFIND but uses image moments to calculate object properties.
- Custom Kernel: photutils allows the use of custom kernels for source detection, providing flexibility beyond Gaussian shapes.
 -Blob Detection: Techniques like the Laplacian of Gaussian (LoG) or Difference of Gaussians (DoG) can be used to detect bright, circular objects like stars.
- Contour Analysis: After thresholding an image, finding and analyzing contours can help identify star-shaped objects. Features like area, perimeter, and roundness can be used to filter out non-star objects.

Process:
- Image Loading and Preprocessing:
    - Load the astronomical image (e.g., FITS file using astropy).
    - Convert the image to grayscale if necessary.
    - Apply noise reduction techniques (e.g., Gaussian blur).
    - Optionally, use thresholding to highlight bright objects.
- Star Detection:
    - Use photutils's DAOStarFinder or IRAFStarFinder to detect stars based on specified parameters like threshold, FWHM, and sharpness.
    - Alternatively, use blob detection or contour analysis methods from opencv-python.
- Filtering and Refinement:
    - Filter out false positives based on size, shape, or other criteria.
    - Optionally, fit Gaussian distributions to detected objects to refine their positions and properties.
- Output:
    - Obtain a list of detected stars with their coordinates and other relevant information.
"""

from astropy.io import fits
from photutils.detection import DAOStarFinder
from photutils.aperture import CircularAperture, aperture_photometry
import matplotlib.pyplot as plt
import numpy as np

# Load the FITS image
image_data = fits.getdata('your_image.fits')

# Detect stars using DAOStarFinder
finder = DAOStarFinder(fwhm=3.0, threshold=50)
sources = finder(image_data)

# Print the number of stars detected
print(f"Number of stars detected: {len(sources)}")

# Plot the image with detected stars
positions = np.transpose((sources['xcentroid'], sources['ycentroid']))
apertures = CircularAperture(positions, r=5)
plt.imshow(image_data, cmap='gray', origin='lower', vmin=np.percentile(image_data, 5), vmax=np.percentile(image_data, 95))
apertures.plot(color='#0547f9', lw=1.5)
plt.title('Detected Stars')
plt.show()

# Perform aperture photometry
phot_table = aperture_photometry(image_data, apertures)
print(phot_table)
