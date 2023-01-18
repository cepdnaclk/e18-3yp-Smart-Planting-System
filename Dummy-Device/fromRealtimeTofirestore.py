'''
Get data from realtime database then send to fireStore
'''

import pyrebase
import time
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

''' firebaseConfig={"apiKey": "qSErU9t9a7O8Tj2vTJWPdatLBlbFJ58c7twgkIuh",
    "authDomain": "new-arduino-project-default-rtdb.asia-southeast1.firebasedatabase.app",
    "databaseURL": "https://smart-planting-system-b7c5e-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "projectId": "new-arduino-project",
    "storageBucket": "pyrebaserealtimedbdemo.appspot.com",
    "messagingSenderId": "843349173643",
    "appId": "1:843349173643:web:90ff345ff844aa89d5fb8e",
    "measurementId": "G-DT093HRL5R"} '''

firebaseConfig={"apiKey": "qSErU9t9a7O8Tj2vTJWPdatLBlbFJ58c7twgkIuh",
    "authDomain": "smart-planting-system-b7c5e-default-rtdb.asia-southeast1.firebasedatabase.app",
    "databaseURL": "https://smart-planting-system-b7c5e-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "projectId": "smart-planting-system-b7c5e",
    "storageBucket": "smart-planting-system-b7c5e.appspot.com"}

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
print("Read data from realtime db and send to firestore database")

# Update every 3 seconds
SLEEP_TIME = 10

# Do not change

# initializations 
cred = credentials.Certificate('smart-planting-system-b7c5e-firebase-adminsdk-hvco0-74098b389d.json')
firebase_admin.initialize_app(cred)
fdb = firestore.client()

# Do not change
# ---------------------------
while True:
    firebase=pyrebase.initialize_app(firebaseConfig)

    db=firebase.database()

    #Multi-location update data
    all_plants = db.child("plants").get()

    for users in all_plants.each():
        plant_ID = users.key()
        plant_Data = users.val()
        # print(plant_ID, plant_Data)
        doc_ref = fdb.collection('Plants_Data').document(plant_ID)
        doc_ref.set(plant_Data)
    
    time.sleep(SLEEP_TIME)

# ---------------------------