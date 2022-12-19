const HousePlant = require('../models/plantData.model');

//Get desired plant conditions given the plantTypeID
exports.show = async(req,res) => {
    var data = req.params;

    const HousePlantExists = await (HousePlant.checkPlant)(req.params.plantTypeID);

    // if plant exists
    if(HousePlantExists) {
        console.log(req.params.plantTypeID);
        
        const resp = HousePlant.show(data, function(err, result) {
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

//Get all the plantTypeIDs and commonNames
exports.all = async (req, res) => {
    var data = req.body;
    
    const resp = HousePlant.showAll(data, function(err,result){
        // console.log(result);
        //console.log(err);

        if(resp === 2){
            res.status(400).send('Query error!');
        }else{
            res.send(result);
        }

    });
}