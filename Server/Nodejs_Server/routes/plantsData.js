const router = require('express').Router();
const plantDataController = require('../controllers/plantData.controller');

router.get("/:plantTypeID", plantDataController.show);

module.exports = router;