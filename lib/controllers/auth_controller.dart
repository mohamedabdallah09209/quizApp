import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizquiz/firebase_ref/references.dart';
import 'package:quizquiz/screens/home/home_screen.dart';
import 'package:quizquiz/screens/login/login_screen.dart';
import 'package:quizquiz/widgets/dialogs/dialog_widget.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStreamChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 3));
    _auth = FirebaseAuth.instance;
    _authStreamChanges = _auth.authStateChanges();
    _authStreamChanges.listen(
      (User? user) {
        _user.value = user;
      },
    );
    navigateToIntroduction();
  }

  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        final authAccount = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: authAccount.idToken,
          accessToken: authAccount.accessToken,
        );
        await _auth.signInWithCredential(credential);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (error) {
      if (kDebugMode) {
        print("ppppppppppppppppppppppppppppppppppppppppppppppp");
        print(error);
      }
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {

    userRef.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl,
    });
  }

  Future<void> signOut() async {
    if (kDebugMode) {
      print('Sign Out');
    }
    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
      }
    }
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs().questionStartDialog(
          onTap: () {
        Get.back();
        navigateToLoginPage();
      }),
      barrierDismissible: false,
    );
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }
}
