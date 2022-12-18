const express = require('express');
const plantDataController = require('../controllers/plantData.controller');
const router = express.Router();

router.get("/", plantDataController.view);

module.exports = router;