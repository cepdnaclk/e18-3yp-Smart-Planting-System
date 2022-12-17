const User = require('../models/user.model');

exports.register = async (req, res) => {

    const userName = req.body.userName;
    const email = req.body.email;
    const mobileNo = req.body.mobileNo;
    const joinDate = req.body.joinDate;
    const profileIMG = req.body.img;

    const user = new User({
        userName: userName,
        email: email,
        mobileNo: mobileNo,
        joinDate: joinDate,
        profileIMG: profileIMG
    });

    console.log(userName);

    // Create a new user
    const response = await User.create(user);

    if (response) {
        res.status(201).send('User added');
    } 
}