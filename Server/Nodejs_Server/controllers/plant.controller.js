const Plant = require('../models/plant.model');

//Create a new user
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

//Show the last data of the plnat_status table given the plantID
exports.show = async(req,res) => {
    var data = req.params;

    const PlantExists = await (Plant.checkPlant)(req.params.plantID);

    // if plant exists
    if(PlantExists) {
        console.log(req.params.plantID);
        
        const resp = Plant.showData(data, function(err, result) {
            if(resp === 2) {
                res.status(400).send('Query error!');
            }
            else {
                res.send(result);
            }
        });
        return;
    }
    else {
        // create a json response
        res.status(404).json({
            success: false,
            status: 404,
            message: "Plant does not exists"
        });
        return;
    }

}

