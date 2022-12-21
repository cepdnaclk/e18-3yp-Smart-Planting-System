const router = require('express').Router();
const userController = require('../controllers/user.controller');

router.post("/register", userController.register);
router.get("/getUser", userController.getUserID);

module.exports = router;