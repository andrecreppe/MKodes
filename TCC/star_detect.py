"""
Blob Detection
https://scikit-image.org/docs/stable/auto_examples/features_detection/plot_blob.html#sphx-glr-auto-examples-features-detection-plot-blob-py
"""

import cv2
import numpy as np
from skimage.feature import blob_log
import matplotlib.pyplot as plt


def detect_stars(image):
    # Pre-process the image
    blurred = cv2.GaussianBlur(image, (9, 9), 0)

    # Detect blobs (potential stars) using Laplacian of Gaussian (LoG)
    blobs = blob_log(blurred, min_sigma=1, max_sigma=5, num_sigma=10, threshold=0.05)
    
    return blobs


def show_detected_stars(image, blobs, block=False):
    # Compute radii in the 3rd column
    blobs[:, 2] = blobs[:, 2] * np.sqrt(2)

    # Show results
    fig, ax = plt.subplots(figsize=(10, 10))
    ax.imshow(image, cmap='gray')
    for y, x, r in blobs:
        c = plt.Circle((x, y), r, color='red', linewidth=1.5, fill=False)
        ax.add_patch(c)
    ax.set_axis_off()
    plt.title(f'Detected Stars: {len(blobs)}')
    plt.show(block=block)
