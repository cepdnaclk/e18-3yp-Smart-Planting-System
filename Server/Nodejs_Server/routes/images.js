const router = require('express').Router();
const imageController = require('../controllers/image.controller');
const imageUploader = require('../helpers/image.uploader');

router.post('/uploads', imageUploader.upload.single('image'), imageController.upload);

module.exports = router;