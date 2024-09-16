import 'dart:io';
import 'package:asset_management/app_theme.dart';
import 'package:asset_management/assetmana/controllers/app_controller.dart';
import 'package:asset_management/assetmana/ui_view/text_decoration.dart';
import 'package:asset_management/web_view.dart';
import 'package:asset_management/login/repository/model/login_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:asset_management/dashboard/repository/dashboard_controller.dart';
import 'package:asset_management/helper/back_screen.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:get/get.dart';
import '../helper/widgets/Dialogs.dart';
import '../helper/widgets/text_styles.dart';
import 'data/local/app_shared_prefs.dart';
import 'data/local/preference_keys.dart';
import 'package:asset_management/assetmana/utility/app_utility.dart';

import 'home/home_bottom_menu.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  AppController appController = Get.find();
  LoginData? login_user; // = LoginData();
  bool agree = false;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              "Complete Profile",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            // Text("Complete Profile"),
          ),
          body: Container(margin: EdgeInsets.all(12), child: buildProfileUI()),
        ));
  }

  Widget buildProfileUI() {
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 13.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return SingleChildScrollView(
        child: FutureBuilder(
            future: _getLoginUser(),
            builder: (context, AsyncSnapshot<LoginData?> loginData) {
              login_user = loginData.data!;
              return Column(
                children: [
                  _getLabel('Full Name : '),
                  TextField(
                    style: TSB.regularSmall(),
                    controller: TextEditingController(text: login_user?.name),
                    onChanged: (s) => login_user?.name = s.trim(),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Your Full Name'),
                  ),
                  _getLabel('Mobile Number : '),
                  TextField(
                    style: TSB.regularSmall(),
                    controller: TextEditingController(text: login_user?.mobile),
                    onChanged: (s) => login_user?.mobile = s.trim(),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Your MobileNumber'),
                  ),
                  _getLabel('Email Id : '),
                  TextField(
                    enabled: false,
                    style: TSB.regularSmall(),
                    controller: TextEditingController(text: login_user?.email),
                    onChanged: (s) => login_user?.email = s.trim(),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Your Email Id'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 12),
                    child: Row(
                      children: [
                        Material(
                          child: Checkbox(
                            value: agree,
                            onChanged: (value) {
                              setState(() {
                                agree = value ?? false;
                              });
                            },
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            // margin: EdgeInsets.only(top: 16,bottom: 12),
                            child: Column(children: [
                              RichText(
                                text: TextSpan(
                                  style: defaultStyle,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text:
                                            'By clicking Continue, you agree to our '),
                                    TextSpan(
                                        text: 'Terms of Service',
                                        style: linkStyle,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(AppWebView(typewebview: 3));
                                          }),
                                    const TextSpan(
                                        text: ' and that you have read our '),
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: linkStyle,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(AppWebView(typewebview: 2));
                                          }),
                                  ],
                                ),
                              ),
                            ]))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff132137),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff132137),
                          ),
                          onPressed: _onContinueClick,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.arrow_forward_rounded,
                                  color: Colors.white),
                            ],
                          ),
                        )
                    ),
                  )
                ],
              );
            }));
  }

  Future<LoginData?> _getLoginUser() async {
    print("Ayyyaaaaaaa");
    if (login_user == null) {
      login_user = LoginData();
      print("Ayyyaaaaaaawww");

      String? userString =
          await AppSharedPrefs.get().getValue(PreferenceKeys.USER_DATA);
      Map<String, dynamic> userMap = json.decode(userString!);

      login_user = LoginData.fromJson(userMap);
      print(login_user);
      print(login_user?.name);
      print(login_user?.email);
      return LoginData.fromJson(userMap);
    } else {
      return login_user;
    }
  }

  _getLabel(String title) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          children: [
            Text(
              title,
              style: TSB.boldMedium(textColor: Color(0xff666666)),
            ),
            Text(
              '*',
              style: TSB.boldMedium(textColor: Colors.red),
            ),
            // style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Color(0xff666666)),
          ],
        ));
  }

  _onContinueClick() async {
    if (login_user?.name == null || login_user?.name == "") {
      Constant.showToast("Please Enter Your Full Name");
      return;
    }
    if (!AppUtility.isValidName(login_user?.name)) {
      Constant.showToast("Please Enter Valid Full Name");
      return;
    }

    if (login_user?.mobile == null || login_user?.mobile == "") {
      Constant.showToast("Please Enter Your Mobile Number");
      return;
    }

    if (!AppUtility.isValidPhoneNumber(login_user?.mobile)) {
      Constant.showToast("Please Enter Valid Mobile Number");
      return;
    }
    if (login_user?.email == null || login_user?.email == "") {
      Constant.showToast("Please Enter Your Email Id");
      return;
    }
    if (!AppUtility.isEmailValid(login_user?.email)) {
      Constant.showToast("Please Enter Valid Email Id");
      return;
    }
    if (!agree) {
      Constant.showToast("Please accept terms and conditions");
      return;
    }
    if (kDebugMode) {
      print(login_user);
    }
    Dialogs.showLoadingDialog(context, _keyLoader);
    LoginResponse response = await appController.updateProfile(login_user!);

    if (response.success! && response.data!=null) {
      var loginUserString = json.encode(response.data?.toJson());
      await AppSharedPrefs.get()
          .addValue(PreferenceKeys.USER_DATA, loginUserString);
      //close the dialoge
      Navigator.of(context, rootNavigator: true).pop();
       Get.offAll(HomeBottomMenu(),
           transition: Transition.rightToLeft,
           duration: const Duration(seconds: 0));
    } else {
      //close the dialoge
      Navigator.of(context, rootNavigator: true).pop();
      Constant.showToast(response.message);
    }
  }
}
