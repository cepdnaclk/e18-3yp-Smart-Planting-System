const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
    destination: function (req, file, callback) {
        callback(null, './uploads');
    },
    filename: function(req, file, callback) {
        callback(null, new Date().getTime() + path.extname(file.originalname));
    }
});

const fileFilter = (req, file, callback) => {
    if(file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
        callback(null, true);
    } else {
        callback(new Error('Unsupported file type.', false));
    }
}

const upload = multer({
    storage: storage,
    limits: {
        fileSize:1024*1024*2
    },
    fileFilter: fileFilter
})

module.exports = {
    upload: upload
}