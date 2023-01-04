const User = require('../models/user.model');

exports.register = async (req, res) => {

    const userName = req.body.userName;
    const email = req.body.email;
    const mobileNo = req.body.mobileNo;
    const userPassword = req.body.userPassword;
    const joinDate = req.body.joinDate;
    const profileIMG = req.body.img;

    const user = new User({
        userName: userName,
        email: email,
        mobileNo: mobileNo,
        userPassword: userPassword,
        joinDate: joinDate,
        profileIMG: profileIMG
    });

    console.log(userName, "User controller");

    // Create a new user
    const resp = User.create(user, function(err, result) {
        if(resp === 2) {
            res.status(400).send('Query error!');
        }
        else {
            res.send(result[0]);
        }
    });

}

exports.getUserID = async(req, res) => {
    const userEmail = req.body.email;
    console.log(userEmail);

    const resp = User.getUserID(userEmail, function(err, result) {
        if(resp === 2) {
            res.status(400).send('Query error!');
        }
        else {
            res.send(result[0]);
        }
    });
}