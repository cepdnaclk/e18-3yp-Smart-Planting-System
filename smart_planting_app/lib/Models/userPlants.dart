class UserPlants {
  int? plantID;
  String? plantTypeID;
  String? commonName;

  UserPlants({this.plantID, this.plantTypeID, this.commonName});

  UserPlants.fromJson(Map<String, dynamic> json) {
    plantID = json['plantID'];
    plantTypeID = json['plantTypeID'];
    commonName = json['commonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plantID'] = plantID;
    data['TypeID'] = plantTypeID;
    data['commonName'] = commonName;
    return data;
  }
}
