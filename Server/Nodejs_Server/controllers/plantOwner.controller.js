const PlantOwnership = require('../models/plantOwner.model');
const User = require('../models/user.model');

exports.create = async (req, res) => {
    const plantID = req.body.plantID;
    const userID = req.body.userID;
    const plantTypeID = req.body.plantTypeID;
    const addedDate = req.body.addedDate;

    const plantOwner = new PlantOwnership({
        plantID: plantID,
        userID: userID,
        plantTypeID: plantTypeID,
        addedDate: addedDate,
    });

    // Check is the user in the system
    const userExists = await User.checkUser(plantOwner.userID);
    // Check is the new plant already used by requested user
    const plantExists = await PlantOwnership.checkPlant(plantOwner);

    if(!userExists) {
        // create a json response
        res.status(404).json({
            success: false,
            status: 404,
            message: "User does not exists"
        });

        return;
    }
    if(!plantExists) {
        // Add a new plant to an user
        const response = PlantOwnership.create(plantOwner, function(err, result) {
            if(response === 2) {
                res.status(400).send('Query error!');
            }
            else {
                res.status(200).json({
                    "success": true,
                    "status": 200,
                    "message": "Plant added to user successfully."
                });
            }
        });
        return;
    } else {
        // create a json response
        res.status(404).json({
            success: false,
            status: 404,
            message: "Plant already in use."
        });

        return;
    }
    
}

exports.delete = async (req, res) => {
    var data =  req.params;

    // Check is the user in the system
    const userExists = await User.checkUser(plantOwner.userID);
    // Check is the new plant already used by requested user
    const plantExists = await PlantOwnership.checkPlant(plantOwner);

    if(!userExists) {
        // create a json response
        res.status(404).json({
            success: false,
            status: 404,
            message: "User does not exists"
        });

        return;
    }
    // if mold exists
    if (plantExists) {
        console.log("Deleting Plant")
        
        const resp = PlantOwnership.delete(data, function(err,result){
            console.log(result);

            if(resp === 2){
                res.status(400).send('Query error!');
            }else{
                res.send(result);
            }

        });
        return;
    }else{
        // create a json response
        res.status(404).json({
            success: false,
            status: 404,
            message: "Plant does not exist"
        });

        return;
    }
}

exports.getPlantsOfUser = async (req, res) => {
    const getUserID = req.params.userID;

    console.log(getUserID);

    const userExists = await User.checkUser(getUserID);
    if(!userExists) {
        // create a json response
        res.status(404).json({
            success: false,
            status: 404,
            message: "User does not exists"
        });

        return;
    }
    if(userExists) {
        const plants = PlantOwnership.getPlantsOfUser(getUserID, function(err, result) {
            if(plants === 2){
                res.status(400).send('Query error!');
            }else{
                res.send(result[0]);
            }
    
        });
    } else {
        res.status(200).json({
            success: false,
            status: 404,
            message: "No plants are exist"
        });
        return;
    }

}