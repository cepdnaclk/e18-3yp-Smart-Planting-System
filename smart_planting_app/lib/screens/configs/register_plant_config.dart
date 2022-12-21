import 'package:get/get.dart';
import 'package:smart_planting_app/Models/plantRegisterModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as cnv;

class RegisterAPlant extends GetxController {
  static RegisterAPlant get instance => Get.find();

  Future<String?> registerPlantAPI(String cPlantID, String cUserID, String cPlantTypeID, String cAddedDate) async {
    print("plant reg called");

    PlantRegisterModel newPlant = PlantRegisterModel(plantID: cPlantID, userID: cUserID, plantTypeID: cPlantTypeID, addedDate: cAddedDate);
    http.Response res;
    // print(name);
    try {
      res = await http.post(Uri.parse("http://3.111.170.113:8000/api/plantOwner/register"),headers: {
        'Content-Type': "application/json"
      }, body: json.encode(newPlant.toJson()));

      dynamic body = cnv.jsonDecode(res.body);

      print('Done registration');
      print(body['message']);
      print(body['success']);

      //to do : return the user ID extracted from response body
      return body['message'];
    } catch (e) {
      // return 'Unknown error has occurred';
      return e.toString();
    }

  }
}