// import packages
const mysql = require("mysql");
const util = require('util')
const config = require('../config/config');

// create a connection to the database
const db = mysql.createConnection(config);

// connect to the database
db.connect((err) => {
    if (err) {
        console.log(err);
    } else {
        console.log('Connected to the database');
    }
}
);

db.query = util.promisify(db.query);

module.exports = db;