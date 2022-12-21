class AppUser{
  final String imagePath;
  late final String name;
  final String email;
  final String mobileNo;
  late final String about;

  AppUser({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.about,
});
  toJson(){
   return {
     "Username": name,
     "Email": email,
     "MobileNo": mobileNo,
     "JoinDate": DateTime.now(),
     "About": about,
  };
}

}

