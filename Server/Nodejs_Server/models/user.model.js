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

User.create = async (newUser, callback) => {

  var sqlQuery = "CALL AddUser(?,?,?,?,?);";
  
  const status = sql.query(sqlQuery, [newUser.userName, newUser.email, newUser.mobileNo, newUser.userPassword, newUser.joinDate], callback, function(err,result){
    if(result){
        callback(null,result);
    }else{
        this.callback(err,null);
    }    
  });
}

module.exports = User;
