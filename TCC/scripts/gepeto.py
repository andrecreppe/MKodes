import cv2
import numpy as np
import pandas as pd
from astropy.coordinates import SkyCoord
import astropy.units as u
import matplotlib.pyplot as plt

import star_detect as sd


image_path = "./images/orion.jpg"
# image_position = '05 32 43.836 -00 19 09.113' # RA/Dec (hourangle/deg)
image_position = '18 04 00 -07 00 00' # betlegeuse
fov_deg = 28.0  # Field of view in degrees

# image_path = "./images/centaurus_crux.png"
# image_position = '13 32 57.75 -51 58 47.203' # RA/Dec (hourangle/deg)
# fov_deg = 42.4  # Field of view in degrees

star_db = "navigation_stars.csv"
# star_db = "constellations.csv"

# -----------------------------

# Convert pixel coordinates to angular offsets
def pixel_to_angle(x, y, img_shape, fov_deg):
    h, w = img_shape
    fov_rad = np.deg2rad(fov_deg)
    px_per_rad = w / fov_rad
    center_x, center_y = w / 2, h / 2
    delta_x = (x - center_x) / px_per_rad
    delta_y = -(y - center_y) / px_per_rad  # y-axis inverted
    return delta_x, delta_y  # In radians

# Load the image
image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

# Detect stars using blob detection
blobs_sigma = sd.detect_stars(image)
sd.show_detected_stars(image=image, blobs=blobs_sigma)

blobs = blobs_sigma[:, :2]

# Load navigational stars catalog
stars_df = pd.read_csv(star_db)
catalog = SkyCoord(ra=stars_df['SHA_deg'].values * u.deg,
                   dec=stars_df['Dec_deg'].values * u.deg)
# catalog = SkyCoord(stars_df['Right Ascension'].values + ' ' + stars_df['Declination'].values,
#                    unit=(u.hourangle, u.deg))

# Assume known image center RA/Dec (e.g., from metadata or estimation)
center = SkyCoord(image_position, unit=(u.hourangle, u.deg)) \
        .to_string('decimal') \
        .split(' ')

center_ra = float(center[0])
center_dec = float(center[1])

# Match detected stars to navigational stars
matched_stars = []
for x, y in blobs:
    delta_x, delta_y = pixel_to_angle(x, y, image.shape, fov_deg)
    ra_est = center_ra + np.rad2deg(delta_x)
    dec_est = center_dec + np.rad2deg(delta_y)
    detected_coord = SkyCoord(ra=ra_est * u.deg, dec=dec_est * u.deg)
    idx, sep2d, _ = detected_coord.match_to_catalog_sky(catalog)
    if sep2d < 6.0 * u.deg:  # Matching tolerance
        matched_star = stars_df.iloc[idx]
        matched_stars.append((x, y, matched_star['Name'], sep2d.deg))

# Display results
fig, ax = plt.subplots(figsize=(10, 10))
ax.imshow(image, cmap='gray')
for x, y, name, sep in matched_stars:
    ax.plot(x, y, 'ro', markersize=5)
    # ax.text(x + 5, y + 5, f"{name} ({sep:.2f}°)", color='red', fontsize=8)
    ax.text(x + 5, y + 5, f"{name} ({sep[0]:.2f}°)", color='red', fontsize=8)
ax.set_axis_off()
plt.title(f'Matched Navigational Stars: {len(matched_stars)}')
plt.show()
