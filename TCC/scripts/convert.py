from astropy.coordinates import SkyCoord
import astropy.units as u

ra = "02h 58m 15.6764s"
dec = "−40° 18′ 16.839″"

center = SkyCoord(f'{ra} {dec}', unit=(u.hourangle, u.deg)) \
        # .to_string('decimal') \
        # .split(' ')
        
print(center)