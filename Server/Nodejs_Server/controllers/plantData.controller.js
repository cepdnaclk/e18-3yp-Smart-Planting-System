const PlantData = require('../models/plantData.model');

exports.view = async(req,res) => {
    res.send(PlantData.show);
}



