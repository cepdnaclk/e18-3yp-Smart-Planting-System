import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_planting_app/Models/userRegResponse.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/landing.dart';
import 'package:smart_planting_app/CustomExceptions/SignUpEmailPassword_failure.dart';
import 'package:smart_planting_app/Models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as cnv;

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const landingScreen()) : Get.offAll(() => const homeScreen());
  }

  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const homeScreen()) : Get.to(() => const landingScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // firebaseUser.value != null ? Get.offAll(() => const homeScreen()) : Get.to(() => const landingScreen());
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();

    /*if(res.statusCode == 200) {
      return 'OK';
    } else {
      Get.showSnackbar(const GetSnackBar(message: 'An error has occurred', duration: Duration(seconds: 6),));
      return '';
    }*/

  }


