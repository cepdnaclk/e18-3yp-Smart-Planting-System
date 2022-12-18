const sql = require("./db.js");

// user constructor
const User = function (user) {
  this.userName = user.userName;
  this.email = user.email;
  this.mobileNo = user.mobileNo;
  this.userPassword = user.userPassword;
  this.joinDate = user.joinDate;
  // this.profileImg = user.img;
  this.profileImg = null;
}

// User.create = async (newUser) => {
//   let sqlQuery = "CALL AddUser(?,?,?,?,?)"
// }

User.create = async(newUser) => {
  await sql.query("CALL AddUser(?,?,?,?,?)", [newUser.userName, newUser.email, newUser.mobileNo, newUser.password, newUser.joinDate]);
  return true;
}

module.exports = User;