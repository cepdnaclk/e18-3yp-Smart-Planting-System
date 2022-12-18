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


module.exports = Plant;