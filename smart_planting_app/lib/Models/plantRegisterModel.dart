class PlantRegisterModel {
  String? plantID;
  String? userID;
  String? plantTypeID;
  String? addedDate;

  PlantRegisterModel(
      {this.plantID, this.userID, this.plantTypeID, this.addedDate});

  PlantRegisterModel.fromJson(Map<String, dynamic> json) {
    plantID = json['plantID'];
    userID = json['userID'];
    plantTypeID = json['plantTypeID'];
    addedDate = json['addedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plantID'] = plantID;
    data['userID'] = userID;
    data['plantTypeID'] = plantTypeID;
    data['addedDate'] = addedDate;
    return data;
  }
}
