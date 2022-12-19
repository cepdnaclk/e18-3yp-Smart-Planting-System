const sql = require("./db.js");

// user constructor
const Plant = function (plant) {
  this.plantID = plant.plantID;
  this.readTime = plant.readTime;
  this.temperature = plant.temperature;
  this.soilMoisture = plant.soilMoisture;
  this.waterLevel = plant.waterLevel;
  this.lightIntensity = plant.lightIntensity;
}

Plant.create = async(newPlant) => {
  await sql.query("INSERT INTO plant_status_table SET ?",newPlant);
  return true;
}

//Check the availabitity of the plant
Plant.checkPlant = async (plantTypeID) => {
	const row = await sql.query("SELECT * FROM plants_database_table WHERE plantTypeID = ?", [plantTypeID]);
	if(row.length > 0) {
		return true;
	}
	return false;
}

//Show the last data of the plnat_status table given the plantTypeID
Plant.showData = async(data,callback) => {
  var sqlData = "CALL GetPlantStatusLast(?);";
	
	console.log(data.plantTypeID, "in plant data model");

	// Check whether plant exists
    const status = sql.query(sqlData, [data.plantTypeID], callback, function(err, result) {
		console.log(status);
		if (result) {
			callback(null, result);
		} else {
			this.callback(err, null);
		}
	})
}

module.exports = Plant;
