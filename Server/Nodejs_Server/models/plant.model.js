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
Plant.checkPlant = async (plantID) => {
	const row = await sql.query("SELECT * FROM plants_status_table WHERE plantID = ?", [plantID]);
	if(row.length > 0) {
		return true;
	}
	return false;
}

//Show the last data of the plant_status table given the plantID
Plant.showData = async(data,callback) => {
  var sqlData = "CALL GetPlantStatusLast(?);";
	
	console.log(data.plantID, "in plant data model");

    const status = sql.query(sqlData, [data.plantID], callback, function(err, result) {
		console.log(status);
		if (result) {
			callback(null, result);
		} else {
			this.callback(err, null);
		}
	})
}

module.exports = Plant;
