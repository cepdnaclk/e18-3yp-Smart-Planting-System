const sql = require("./db.js");

// user constructor
const HousePlant = function (plant) {
  this.plantTypeID = plant.plantTypeID;
  this.commonName = plant.commonName;
  this.scientificName = plant.scientificName,
  this.height = plant.height;
  this.habit = plant.habit;
  this.growth = plant.growth;
  this.shade = plant.shade;
  this.soil = plant.soil;
  this.soilMoisture = plant.soilMoisture;
  this.minTemp = plant.minTemp;
  this.maxTemp = plant.maxTemp;
  this.minPH = plant.minPH;
  this.maxPH= plant.maxPH;
  this.edible = plant.edible;
}

//Check the availability of the plant
HousePlant.checkPlant = async (plantTypeID) => {
	const row = await sql.query("SELECT * FROM plants_database_table WHERE plantTypeID = ?", [plantTypeID]);
	if(row.length > 0) {
		return true;
	}
	return false;
}

//Get desired plant conditions given the plantTypeID
HousePlant.show = async (data, callback) => {
	var sqlPlant = "CALL GetDesiredPlantConditions(?);";
	
	console.log(data.plantTypeID, "in plant data model");

	// Check whether plant exists
    const status = sql.query(sqlPlant, [data.plantTypeID], callback, function(err, result) {
		console.log(status);
		if (result) {
			callback(null, result);
		} else {
			this.callback(err, null);
		}
	})
}

//Get all the plantTypeIDs and commonNames
HousePlant.showAll = function(data,callback){
  var sqlData = "CALL GetHousePlants();"

  const status = sql.query(sqlData,callback,function(err,result){
      console.log(status);
      if(result){
          callback(null,result);
      }else{
          this.callback(err,null);
      }    
})
}
module.exports = HousePlant;
