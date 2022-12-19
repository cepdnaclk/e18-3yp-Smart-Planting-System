const sql = require("./db.js");

// user constructor
const PlantOwner = function (owner) {
	this.plantID = owner.plantID;
	this.userID = owner.userID;
	this.plantTypeID = owner.plantTypeID;
	this.addedDate = owner.addedDate;
}

// Check if the plant already owned by selected owner
PlantOwner.checkPlant = async (owner) => {
	const row = sql.query("SELECT * FROM plant_owner_table WHERE plant_owner_table.plantID = ?;", [owner.plantID]);
	if(row.length > 0) {
		return true;
	} else {
		return false;
	}
}

PlantOwner.create = async (newPlant, callback) => {
	// Add new plant to user
	var newPlantSql = "CALL AddPlantUserFromID(?, ?, ?, ?);";

	// Reading row
    const row = sql.query(newPlantSql, [newPlant.plantID, newPlant.userID, newPlant.plantTypeID, newPlant.addedDate], callback, function (err, result) {
		if (result) {
			callback(null, result);
		} else {
			this.callback(err, null);
		}
	})
	return 0;
}

PlantOwner.delete = function(data,callback){
    var sqlDel = "DELETE FROM plant_owner_table WHERE plantID = ?;"

    // check whether empID exists in the employees table
    const status = sql.query(sqlDel,data.plantID,callback,function(err,result){
        console.log(status);
        if(result){
            callback(null,result);
        }else{
            this.callback(err,null);
        }    
	})
}

module.exports = PlantOwner;