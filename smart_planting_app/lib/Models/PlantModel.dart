class PlantModel {
  // String? plantTypeID;
  // String? commonName;
  final String commonName;
  final String plantTypeID;

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
