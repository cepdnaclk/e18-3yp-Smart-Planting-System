const express = require('express');
const plantController = require('../controllers/plant.controller');
const router = express.Router();

router.post("/", plantController.register);
router.get("/:plantID", plantController.show);

module.exports = router;
