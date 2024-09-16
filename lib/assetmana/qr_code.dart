import 'dart:io';
import 'package:asset_management/app_theme.dart';
import 'package:asset_management/assetmana/controllers/app_controller.dart';
import 'package:asset_management/assetmana/ui_view/text_decoration.dart';
import 'package:asset_management/web_view.dart';
import 'package:asset_management/login/repository/model/login_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

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

class QRCodeScreen extends StatefulWidget {
  @override
  String data;

  QRCodeScreen(this.data,{super.key});

  State<QRCodeScreen> createState() => _QRCodeScreenScreenState();
}

class _QRCodeScreenScreenState extends State<QRCodeScreen> {
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
    String data="https://tsetvedqyp.in/assetmanagement/viewitems=$widget.data";
    return Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              "Qr Code",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            // Text("Complete Profile"),
          ),
          body: SingleChildScrollView(
            // padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                // TextField(
                //   onChanged: (val) => setState(() => data = val),
                //   decoration: const InputDecoration(
                //     labelText: 'Type your data',
                //   ),
                // ),
                const SizedBox(height: 30),
                QrImageView(
                  data: data,
                  size: 280,
                  //You can use include embeddedImageStyle Property if you wanna embed an image from your Asset folder
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(
                      100,
                      100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
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


}
