import cv2
import pandas as pd

import star_detect as sd
import star_map as sm


def test_detection():
    # image_path = "./images/centaurus_crux.png"
    # image_path = "./images/hubble.jpg"
    image_path = "./images/orion.jpg"
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

    blobs = sd.detect_stars(image)
    sd.show_detected_stars(image, blobs, block=True)
    

def test_map_gen():
    star_db = './stars/nav_stars.csv'
    stars_df = pd.read_csv(star_db)
    
    sm.generate_navigation_map(stars_df)
    
    
def test_photo():
    image_path = "./images/centaurus_crux.png"
    fov = 42.0
    
    center_ra = 203.241
    center_dec = -51.980
    
    
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    
    
    sm.generate_prediction_map(center_ra, center_dec, )

"""
========== TEST AREA ==========
"""

# test_detection()
# test_map_gen()
test_photo()
