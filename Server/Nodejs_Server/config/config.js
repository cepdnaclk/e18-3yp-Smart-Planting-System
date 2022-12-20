const dotenv = require('dotenv')

module.exports = {
    host: dotenv.config().parsed.DB_HOST,
    user: dotenv.config().parsed.DB_USER,
    password: dotenv.config().parsed.DB_PASSWORD,
    database: dotenv.config().parsed.DB_NAME
    
};

/*module.exports = {
    host: 'localhost',
    user: 'root',
    // password: dotenv.config().parsed.DB_PASSWORD,
    password: '',
    database: 'smart_planting_system'
};*/
