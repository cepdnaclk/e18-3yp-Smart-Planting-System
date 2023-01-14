class PlantModel {
  String? plantTypeID;
  String? commonName;

  PlantModel({this.plantTypeID, this.commonName});

  PlantModel.fromJson(Map<String, dynamic> json) {
    plantTypeID = json['plantTypeID'];
    commonName = json['commonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plantTypeID'] = this.plantTypeID;
    data['commonName'] = this.commonName;
    return data;
  }
}
