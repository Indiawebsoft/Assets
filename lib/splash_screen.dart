import 'dart:async';
import 'dart:convert';
import 'package:asset_management/assetmana/complete_profile.dart';
import 'package:asset_management/assetmana/controllers/app_controller.dart';
import 'package:asset_management/assetmana/data/local/preference_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'assetmana/data/local/app_shared_prefs.dart';
import 'assetmana/home/home_bottom_menu.dart';
import 'dashboard/repository/dashboard_controller.dart';
import 'helper/constant.dart';
import 'helper/size_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login/repository/model/login_response.dart';
import 'package:asset_management/helper/widgets/Dialogs.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final appController = Get.put(AppController());

  // final loginController = Get.put(LoginController());
  final dashboardController = Get.put(DashboardController());
  late SharedPreferences sharedPreferences;
  var isShowLoginBtn = false;
  bool _isLoggedIn = false;

  // late GoogleSignInAccount _userObj;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
          alignment: Alignment.center,
          child: Container(
            // width: 200,
            height: 300,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "images/aslogo.jpeg",
                      height: 250,
                    ),
                  ),
                  if (isShowLoginBtn)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // background (button) color
                          foregroundColor: Colors.white, // foreground (text) color
                        ),
                        onPressed: () async {
                          User? user = await _handleSignIn();
                          if (user != null) {
                            if (kDebugMode) {
                              print('Successfully signed in: ${user.email}');
                            }
                            Dialogs.showLoadingDialog(context, _keyLoader);

                            _userLogin(context, user.displayName!, user.email!,
                                user.uid, 'Google');
                          } else {
                            if (kDebugMode) {
                              print('Sign-in failed.');
                            }
                          }
                        },
                        child: const Text('Sign In with Google'),
                      ),
                    ),
                ]),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    //   // Add the code to update the token
    // }).onError((err) {
    //   FirebaseMessaging.instance.getToken().then((value) {
    //     // Add the code to add the toke to the backend
    //   });
    // });


    getHomeData();
  }

  Future<void> getHomeData() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      AppSharedPrefs.get()
          .getValue(PreferenceKeys.USER_ID)
          .then((userid) async {
        // userid='9';
        if (userid != null) {
          _isLoggedIn = true;
          _nextPage(2);
          Get.offAll(HomeBottomMenu(),
              transition: Transition.zoom,
              duration: const Duration(seconds: 0));
        } else {
          _isLoggedIn = false;
          setState(() {
            isShowLoginBtn = true;
          });
        }
      });
    });
  }

  _userLogin(BuildContext context, String name, String email, String uid,
      String loginBy) async {
    LoginResponse loginResponse = await appController.userRegistration(
        name, email, '1', loginBy, uid, '', '');
    if (loginResponse.success!) {
      await AppSharedPrefs.get()
          .addValue(PreferenceKeys.USER_ID, loginResponse.data?.id);
      var loginUserString = json.encode(loginResponse.data?.toJson());
      await AppSharedPrefs.get()
          .addValue(PreferenceKeys.USER_DATA, loginUserString);
      Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
      if (!_isLoggedIn) {
        _nextPage(1);
      } else {
        _nextPage(2);
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
      Constant.showToast("Server error occurred, Please try later");
    }
  }

  _nextPage(int type) {
    if (type == 1) {
      Get.offAll(CompleteProfileScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(seconds: 0));
    } else {
      Get.offAll(HomeBottomMenu(),
          transition: Transition.zoom, duration: const Duration(seconds: 0));
    }
  }

}
