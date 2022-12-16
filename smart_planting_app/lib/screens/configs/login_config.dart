import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_planting_app/AuthRepository/authRepo.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();


  Future<void> logInUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance.loginWithEmailAndPassword(email, password);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: const Duration(seconds: 6),));
    }
  }
}