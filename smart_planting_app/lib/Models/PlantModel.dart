class PlantModel {
<<<<<<< HEAD
  String? plantTypeID;
  String? commonName;
=======
  final String commonName;
  final String plantTypeID;

>>>>>>> 32229998d6cacc3155741abe63a9766d4cd3f426

  PlantModel({required this.plantTypeID, required this.commonName});

  static PlantModel fromJson(Map<String, dynamic> json)=> PlantModel(
      plantTypeID: json['plantTypeID'],
      commonName: json['commonName']);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plantTypeID'] = this.plantTypeID;
    data['commonName'] = this.commonName;
    return data;
  }
}
