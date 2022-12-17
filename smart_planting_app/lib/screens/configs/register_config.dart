import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_planting_app/AuthRepository/authRepo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final mobileNo = TextEditingController();


  void registerUser(String fullName, String email, String password, String mobileNo) async {
    String? error = await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: const Duration(seconds: 6),));
    }
  }
}