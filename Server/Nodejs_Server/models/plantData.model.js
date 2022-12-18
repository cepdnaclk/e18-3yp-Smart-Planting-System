const sql = require("./db.js");

// user constructor
const Data = function (data) {
  this.plantTypeID = data.plantTypeID;
  this.commonName = data.scientificName;
  this.height = data.height;
  this.habit = data.habit;
  this.growth = data.growth;
  this.shade = data.shade;
  this.soil = data.soil;
  this.soilMoisture = data.soilMoisture;
  this.minTemp = data.minTemp;
  this.maxTemp = data.maxTemp;
  this.minPH = data.minPH;
  this.maxPH= data.maxPH;
  this.edible = data.edible;
}

Data.show = function( ){
    var sqlmachines = "SELECT plantTypeID,commonName FROM plants_database_table;"

    sql.query(sqlmachines,function(err,result){
        if(err){
            throw err;
        }

        return(result);
	})
}

module.exports = Data;
