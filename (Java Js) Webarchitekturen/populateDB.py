
import psycopg2
from datetime import datetime, timedelta



# Database connection parameters
# local
'''
db_params = {
    'dbname': 'waiTest',  # Replace with your database name
    'user': 'user',         # Replace with your database user
    'password': 'waiwai',     # Replace with your database password
    'host': 'localhost',
    'port': '5433'
}
'''
# Toni DB
db_params = {
    'dbname': 'n2112209_WAITDB',
    'user': 'n2112209',
    'password': '123456qwertz',
    'host': 'db.inftech.hs-mannheim.de',
    'port': '5432'
}


# Define locations
locations = ['Frankfurt', 'Bremen', 'Heppenheim', 'Berlin', 'München']

# Paths for images and icons
image_path = 'images/sample_image.jpg'
icon_path = 'icons/sample_icon.jpg'

# Time range: from 2 weeks ago to now
start_time = datetime.now() - timedelta(weeks=2)
end_time = datetime.now()
interval = timedelta(minutes=5)

try:
    # Connect to the database
    conn = psycopg2.connect(**db_params)
    cursor = conn.cursor()

    # Insert locations
    location_ids = []
    for location in locations:
        cursor.execute("""
            INSERT INTO Locations (Location_Name)
            VALUES (%s) RETURNING ID;
        """, (location,))
        result = cursor.fetchone()
        if result:
            location_ids.append(result[0])
        else:
            cursor.execute("SELECT ID FROM Locations WHERE Location_Name = %s;", (location,))
            location_ids.append(cursor.fetchone()[0])

    # Insert cameras (3 per location)
    camera_ids = []
    for location_id in location_ids:
        for i in range(1, 4):
            camera_name = f"Camera_{location_id}_{i}"
            cursor.execute("""
                INSERT INTO Cameras (Name, Description, URL, Status, Location_ID)
                VALUES (%s, %s, %s, %s, %s) RETURNING ID;
            """, (camera_name, f"Description for {camera_name}", f"http://camera_{location_id}_{i}.com", 'Active', location_id))
            result = cursor.fetchone()
            if result:
                camera_ids.append(result[0])
            else:
                cursor.execute("SELECT ID FROM Cameras WHERE Name = %s;", (camera_name,))
                camera_ids.append(cursor.fetchone()[0])
    print("Cameras created")

    # Insert images for each camera at 5-minute intervals with timestamp
    total_intervals = int((end_time - start_time).total_seconds() / (5 * 60))
    for camera_id in camera_ids:
        print(f"Adding images to camera {camera_id}")
        current_time = start_time
        for _ in range(total_intervals + 1):
            cursor.execute("""
                INSERT INTO Images (File_Path, Icon_Path, Camera_ID, Capture_Time)
                VALUES (%s, %s, %s, %s);
            """, (image_path, icon_path, camera_id, current_time))
            current_time += interval

    # Commit the transaction
    conn.commit()
    print("Test data inserted successfully.")

except Exception as e:
    print(f"An error occurred: {e}")
    conn.rollback()

finally:
    cursor.close()
    conn.close()