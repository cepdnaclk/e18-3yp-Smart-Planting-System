import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/landing.dart';
import 'package:smart_planting_app/CustomExceptions/SignUpEmailPassword_failure.dart';

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

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const homeScreen()) : Get.to(() => const landingScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print(ex.message);
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print(ex.message);
    }
  }

  Future<void> logout() async => await _auth.signOut();
}

