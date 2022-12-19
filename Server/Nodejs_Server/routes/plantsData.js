const router = require('express').Router();
const plantDataController = require('../controllers/plantData.controller');

router.get("/",plantDataController.all);
router.get("/:plantTypeID", plantDataController.show);


module.exports = router;