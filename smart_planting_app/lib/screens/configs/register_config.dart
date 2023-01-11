import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_planting_app/AuthRepository/authRepo.dart';
import 'package:http/http.dart' as http;
import 'package:smart_planting_app/Models/userModel.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final mobileNo = TextEditingController();


  void registerUser(String fullName, String email, String password, String mobileNo) async {
    //String? newError = await AuthenticationRepository.instance.registerUserAPI(fullName, email, password, mobileNo);
    String? error = await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
    // if(newError != null) {
    //   Get.showSnackbar(GetSnackBar(message: newError.toString(), duration: const Duration(seconds: 6),));
    // }
  }

}