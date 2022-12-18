const Plant = require('../models/plant.model');

exports.register = async (req, res) => {

    const plantID = req.body.plantID;
    const readTime = req.body.readTime;
    const temperature = req.body.temperature;
    const soilMoisture = req.body.soilMoisture;
    const waterLevel = req.body.waterLevel;
    const lightIntensity = req.body.lightIntensity;

    const plant = new User({
        plantID: plantID,
        readTime: readTime,
        temperature: temperature,
        soilMoisture: soilMoisture,
        waterLevel: waterLevel,
        lightIntensity: lightIntensity
    });

    console.log(plantID);

    // Create a new user
    const response = await Plant.create(plant);

    if (response) {
        res.status(201).send('Plant data added');
    } 
}