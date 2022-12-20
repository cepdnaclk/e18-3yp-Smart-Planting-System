const config = require('../config/upload.config');

function upload(req, res) {
    if(req.file.filename) {
        res.status(201).json({
            message: "Image upload successfully",
            url: "http://" + config.serverUrl + ":" + config.port + config.uploadDir + req.file.filename
        })
    } else {
        res.status(500).json({
            message: "Something went wrong"
        })
    }
}

module.exports = {
    upload: upload
}