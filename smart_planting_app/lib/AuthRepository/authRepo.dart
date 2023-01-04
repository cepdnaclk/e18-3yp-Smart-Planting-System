import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/landing.dart';
import 'package:smart_planting_app/CustomExceptions/SignUpEmailPassword_failure.dart';
import 'package:smart_planting_app/Models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as cnv;
import 'package:smart_planting_app/Storage/SecureStorageData.dart';

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


  Future<String?> registerUserAPI(String name, String email, String password, String mobileNo) async {
    print("register called");

    UserModel newUser = UserModel(userName: name, email: email, userPassword: password, mobileNo: mobileNo);
    http.Response res;
    // print(name);
    try {
      res = await http.post(Uri.parse("http://3.111.170.113:8000/api/user/register"),headers: {
        'Content-Type': "application/json"
      }, body: json.encode(newUser.toJson()));

      dynamic body = cnv.jsonDecode(res.body);

      print('Done registration');
      print(body[0]['userID']);

      await SecureStorageData.setUserID(body[0]['userID'].toString());
      await SecureStorageData.setUserName(name);
      return 'Login successful';
      //to do : return the user ID extracted from response body


    } catch (e) {
      // return 'Unknown error has occurred';
      return e.toString();
    }

  }

  Future<String?> loginUserAPI(String email, String password) async {
    print("register called");

    UserModel newUser = UserModel(email: email, userPassword: password);
    http.Response res;
    // print(name);
    try {
      res = await http.post(Uri.parse("http://3.111.170.113:8000/api/user/register"),headers: {
        'Content-Type': "application/json"
      }, body: json.encode(newUser.toJson()));

      dynamic body = cnv.jsonDecode(res.body);

      print('Done registration');
      print(body[0]['userID']);

      await SecureStorageData.setUserID(body[0]['userID'].toString());
      return 'Login successful';
      //to do : return the user ID extracted from response body


    } catch (e) {
      // return 'Unknown error has occurred';
      return e.toString();
    }

  }
}


