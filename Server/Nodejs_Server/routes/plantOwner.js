const router = require('express').Router();
const plantOwnerController = require('../controllers/plantOwner.controller');

router.post("/register", plantOwnerController.create);
router.delete("/:plantID",plantOwnerController.delete);

module.exports = router;