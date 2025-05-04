import cv2
import numpy as np
import matplotlib.pyplot as plt
from skimage.feature import blob_log
import pandas as pd

def load_nav_stars(csv_path):
    return pd.read_csv(csv_path)

def detect_stars(image_path, min_sigma=1, max_sigma=5, num_sigma=10, threshold=0.05):
    # image = cv2.imread(image_path)
    # gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # gray = cv2.equalizeHist(gray)
    # norm_image = gray / 255.0
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    blurred = cv2.GaussianBlur(image, (9, 9), 0)

    blobs = blob_log(blurred, min_sigma=min_sigma, max_sigma=max_sigma,
                     num_sigma=num_sigma, threshold=threshold)
    blobs[:, 2] = blobs[:, 2] * np.sqrt(2)
    return image, blobs

def gnomonic_projection(ra_deg, dec_deg, ra0_deg, dec0_deg, image_shape, fov_deg):
    """Project RA/Dec (deg) into pixel coordinates using gnomonic projection"""
    ra = np.radians(ra_deg)
    dec = np.radians(dec_deg)
    ra0 = np.radians(ra0_deg)
    dec0 = np.radians(dec0_deg)
    
    cos_c = np.sin(dec0)*np.sin(dec) + np.cos(dec0)*np.cos(dec)*np.cos(ra - ra0)
    x = (np.cos(dec) * np.sin(ra - ra0)) / cos_c
    y = (np.cos(dec0)*np.sin(dec) - np.sin(dec0)*np.cos(dec)*np.cos(ra - ra0)) / cos_c

    # Convert to pixels
    fov_rad = np.radians(fov_deg)
    scale = image_shape[1] / (2 * np.tan(fov_rad / 2))  # pixels per radian
    px = image_shape[1] / 2 + x * scale
    py = image_shape[0] / 2 - y * scale

    return np.vstack([px, py]).T

def plot_detections(image, blobs, matched_names=None):
    fig, ax = plt.subplots(figsize=(10, 10))
    ax.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    for i, blob in enumerate(blobs):
        y, x, r = blob
        c = plt.Circle((x, y), r, color='lime', linewidth=1.5, fill=False)
        ax.add_patch(c)
        if matched_names and matched_names[i]:
            ax.text(x+3, y-3, matched_names[i], color='yellow', fontsize=8)

    ax.set_title(f"{len([n for n in matched_names if n])} navigation stars matched")
    ax.axis('off')
    plt.show()

def project_nav_stars(nav_stars, ra0, dec0, image_shape, fov_deg):
    coords = gnomonic_projection(nav_stars['SHA_deg'].values,
                                 nav_stars['Dec_deg'].values,
                                 ra0, dec0, image_shape, fov_deg)
    return coords

def match_stars(detected_blobs, projected_coords, image_size, max_dist_px=10):
    matched_names = [None] * len(detected_blobs)
    for i, blob in enumerate(detected_blobs):
        y, x, _ = blob
        dists = np.linalg.norm(projected_coords - np.array([x, y]), axis=1)
        min_idx = np.argmin(dists)
        if dists[min_idx] < max_dist_px:
            matched_names[i] = nav_stars.iloc[min_idx]['Name']
    return matched_names

# === Main ===
image_path = './images/centaurus_crux.png'
csv_path = './stars/nav_stars.csv'

ra0_deg = 203.241
dec0_deg = -51.980
fov_deg = 42.2  # degrees

# Step 1: Load catalog and detect stars
nav_stars = load_nav_stars(csv_path)
image, blobs = detect_stars(image_path)

# Step 2: Simulate projection of catalog stars to image plane
projected_coords = project_nav_stars(nav_stars, ra0_deg, dec0_deg, image.shape[:2], fov_deg)

# Step 3: Match detected blobs to known stars
matched = match_stars(blobs, projected_coords, image.shape[:2])

# Step 4: Plot results
plot_detections(image, blobs, matched)
