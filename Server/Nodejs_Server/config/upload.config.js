const dotenv = require('dotenv')

module.exports = {
    port: dotenv.config().parsed.API_PORT,
    serverUrl : dotenv.config().parsed.SERVER_URL,
    uploadDir : dotenv.config().parsed.UPLOAD_DIR
    
};