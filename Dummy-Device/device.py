'''
Send data to firestore database
'''
# firebase-admin
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from datetime import datetime
import time
import random


import firebase_admin
from firebase_admin import credentials


# ------ Important ------
# This won't run on python 3.10 or above. Run in python 3.9 or below
# pip install pyrebase

# Change deviceID, and sleep time as your preference
DEVICE_ID = 1
SLEEP_TIME = 1      # minutes

# initializations 
cred = credentials.Certificate('smart-planting-system-b7c5e-firebase-adminsdk-hvco0-74098b389d.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

# Reference
# LightIntensity: F = full shade S = semi-shade N = no shade
# Soil Moisture: D = dry M = Moist We = wet Wa = water
# Water level:  level 3 -------- OK
#               level 2 -------- OK
#               level 1 -------- Low water warning
#               level 0 -------- Do not turn on pump!!

lightList = ['F', 'S', 'N']
moistureList = ['D', 'M', 'We', 'Wa']
waterList = ['level 3', 'level 2', 'level 1', 'level 0']

# Print
print("Sending data to firestore database")

# Get user inputs for device ID and sleep time
DEVICE_ID = input("Enter Device ID: ")
SLEEP_TIME = int(input("Enter a time interval(minutes): "))

if(SLEEP_TIME < 1):
    SLEEP_TIME = 1

# Do not change
# ---------------------------
while True:
    DateTime = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
    LightIntensity = random.choice(lightList)
    SoilMoisture = random.choice(moistureList)
    Temperature = round(random.uniform(8.5, 40.9), 1)
    WaterLevel = random.choice(waterList)

    print(DateTime)

    doc_ref = db.collection('Plants_Data').document(DEVICE_ID)

    #Multi-location update data
    doc_ref.set({"DateTime":DateTime, "LightIntensity" : LightIntensity, "SoilMoisture": SoilMoisture, "Temperature":Temperature, "WaterLevel": WaterLevel})
    # print(Temperature)
    # Sleep time
    time.sleep(SLEEP_TIME * 30)

# ---------------------------