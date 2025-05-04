import numpy as np
import matplotlib.pylab as plt


def generate_navigation_map(stars_df):
    # Plot Stars
    plt.figure(figsize=(12, 6))
    plt.scatter(stars_df['SHA_deg'], stars_df['Dec_deg'], color='white', edgecolor='black')

    # Annotate each star with name
    for _, row in stars_df.iterrows():
        # plt.text(row['SHA_deg'], row['Dec_deg'], row['Name'], fontsize=8, ha='right', color='yellow')
        plt.text(row['SHA_deg']+2, row['Dec_deg'], row['Name'], 
            fontsize=8, ha='left', va='bottom',
            bbox=dict(boxstyle="round,pad=0.2", fc="yellow", alpha=0.6, lw=0))

    # Plot declination variation curve
    x_vals = np.linspace(0, 360, 1000)
    y_vals = -23.44 * np.sin(np.radians(x_vals)) # Earth declination varies from -23.44° to +23.44° approx (obliquity of the ecliptic)
    plt.plot(x_vals, y_vals, linestyle='dashdot', color='cyan', label='Earth Declination Curve')

    # Axis settings
    plt.xlim(0, 360)
    plt.ylim(-90, 90)
    plt.xticks(range(0, 361, 30))
    plt.yticks(range(-90, 91, 30))

    plt.xlabel('Sidereal Hour Angle (°)')
    plt.ylabel('Declination (°)')
    plt.title('Navigational Star Chart')
    plt.grid(True, linestyle='--', alpha=0.5)
    plt.gca().set_facecolor('midnightblue')

    plt.tight_layout()
    plt.show()


def generate_prediction_map(ra, dec):
    # Plot
    plt.figure(figsize=(12, 6))
    plt.scatter(ra, dec, color='yellow')
    
    # Axis settings
    plt.xlim(0, 360)
    plt.ylim(-90, 90)
    plt.xticks(range(0, 361, 30))
    plt.yticks(range(-90, 91, 30))

    plt.xlabel('Sidereal Hour Angle (°)')
    plt.ylabel('Declination (°)')
    plt.title('Navigational Star Chart')
    plt.grid(True, linestyle='--', alpha=0.5)
    plt.gca().set_facecolor('midnightblue')

    plt.tight_layout()
    plt.show()
