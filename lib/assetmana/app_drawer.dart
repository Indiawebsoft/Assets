import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asset_management/dashboard/repository/dashboard_controller.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:asset_management/web_view.dart';
import 'package:asset_management/login/repository/model/login_response.dart';
import 'package:asset_management/login/ui/login_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asset_management/helper/constant.dart';

import 'controllers/app_controller.dart';
import 'data/local/app_shared_prefs.dart';
import 'data/local/preference_keys.dart';

class AppDrawer extends StatefulWidget {

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final appController = Get.put(AppController());
  late SharedPreferences sharedPreferences;
  String id = "1";
  bool useriD = false;
  LoginData? login_user; // = LoginData();


  @override
  void initState() {

    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
         SizedBox(
        height: 155.0,
        child:  DrawerHeader(
            decoration:
            BoxDecoration(color: Colors.lightBlueAccent.withOpacity(.06)),
            child: FutureBuilder(
            future: _getLoginUser(),
    builder: (context, AsyncSnapshot<LoginData?> loginData) {
    login_user = loginData.data!;
    return FutureBuilder(
                future: appController.getProfile2(
                    login_user!.id),
                builder: (context, AsyncSnapshot<LoginResponse> snapshot) {
                  if (snapshot.hasData) {
                    LoginData loginData = snapshot.data!.data!;
 print( snapshot.data!.data!);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 12, top: 24),
                        //   child: CircleAvatar(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(2.0),
                        //       child: loginData.image
                        //           .toString()
                        //           .isEmpty ? Image.asset(
                        //         "images/lab_1.jpg",
                        //         height: 60, width: 60,
                        //         fit: BoxFit.cover,
                        //       ) : Image.network(
                        //         loginData.image.toString(),
                        //         height: 60, width: 60,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            loginData.name
                                .toString()
                                .isEmpty ? "" : "${loginData.name}",
                            style: TextStyle(
                                color: Constant.hexToColor(
                                    Constant.primaryBlueMin)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            loginData.email
                                .toString()
                                .isEmpty
                                ? ""
                                : "" + loginData.email.toString(),
                            style: TextStyle(
                                color:
                                Constant.hexToColor(Constant.primaryBlue)),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 24, bottom: 24, top: 24),
                          child: CircleAvatar(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "images/lab_1.jpg",
                                height: 50, width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            "",
                            style: TextStyle(
                                color: Constant.hexToColor(
                                    Constant.primaryBlueMin)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            "",
                            style: TextStyle(
                                color:
                                Constant.hexToColor(Constant.primaryBlue)),
                          ),
                        )
                      ],
                    );
                  }
                }
            );})

          ),),
          ListTile(
            leading: Image.asset(
              "images/home.png", width: 20, height: 20, color: Colors.grey,),
            title: const Text('Home',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              // Get.to(DashboardScreenV1());

            },
          ),
          ListTile(
            leading: Image.asset("images/chemistry.png", width: 20,
              height: 20,
              color: Colors.grey,),
            title: const Text('My Assets',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
        //      Get.to(AllTest(cateogoryTest: false));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.border_all_rounded, color: Colors.grey,),
          //   title: const Text('Booking History',
          //       style: TextStyle(fontSize: 14, color: Colors.grey)),
          //   onTap: () {
          //     Navigator.pop(context);
          //
          //     if (!useriD) {
          //
          //       Get.to(LoginScreen());
          //
          //     } else {
          //       pushNewScreen(
          //         context,
          //         screen: OrderList(),
          //         withNavBar: true,
          //       );
          //     }
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: const Text(
          //     'Account',
          //     style: TextStyle(fontSize: 14, color: Colors.black54),
          //   ),
          //   onTap: () {
          //     // Navigator.pop(context);
          //     // pushNewScreen(
          //     //   context,
          //     //   screen: ProductList("Wishlist",1),
          //     //   withNavBar: true, // OPTIONAL VALUE. True by default.
          //     //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
          //     // );
          //   },
          // ),
          Container(
              margin: EdgeInsets.only(left: 8, bottom: 12, top: 12),
              child: Text("Other Infomartion")),
          ListTile(
            leading: Icon(Icons.note_outlined),
            title: const Text('About us',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              Get.to(AppWebView(typewebview: 1));

            },
          ),
          ListTile(
            leading: Icon(Icons.note_outlined),
            title: const Text('Privacy policy',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
        //      Get.to(AppWebView(typewebview: 2));
            },
          ),

          ListTile(
            leading: Icon(Icons.note_outlined),
            title: const Text('Terms and Conditions',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
         //     Get.to(AppWebView(typewebview: 3));
            },
          ),
          // Container(
          //     margin: EdgeInsets.only(left: 8, bottom: 12, top: 12),
          //     child: Text("Other")),
          Constant.USERLOGGEDIN ?
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              GetStorage().write(Constant.USERID, "");
              GetStorage().write(Constant.USERID, null);
              GetStorage().remove(Constant.USERID);
              Constant.USERLOGGEDIN=false;
              setPrefs();
      //        Get.offAll(HomeBottomBar(0));
            },
          ) :Container(),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: const Text('Settings',
          //       style: TextStyle(fontSize: 14, color: Colors.black54)),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: const Text('Languages',
          //       style: TextStyle(fontSize: 14, color: Colors.black54)),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
  Future<LoginData?> _getLoginUser() async {
    if (login_user == null) {
      login_user = LoginData();
      String? userString =
      await AppSharedPrefs.get().getValue(PreferenceKeys.USER_DATA);
      Map<String, dynamic> userMap = json.decode(userString!);

      login_user = LoginData.fromJson(userMap);
      return LoginData.fromJson(userMap);
    } else {
      return login_user;
    }
  }
  Future<bool> getPrefs() async {

    sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.getString(Constant.USERID)==null){
      useriD = false;

      return false;
    }else {
      setState(() {
        id = sharedPreferences.getString(Constant.USERID)!;
      });
      useriD = true;
      return true;
    }


  }

  Future<void> setPrefs() async {

    sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setBool(Constant.USERID, false);
    sharedPreferences.setString(Constant.USERID, "");
    sharedPreferences.remove(Constant.USERID);
    Constant.USERLOGGEDIN=false;
    useriD = false;
  }


}
