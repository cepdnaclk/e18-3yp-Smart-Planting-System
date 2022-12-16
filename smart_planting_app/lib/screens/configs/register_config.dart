import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_planting_app/AuthRepository/authRepo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final mobileNo = TextEditingController();


  void registerUser(String fullName, String email, String password, String mobileNo) {
    String? error = AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }
}