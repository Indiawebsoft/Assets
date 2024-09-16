import 'dart:convert';

import 'package:asset_management/assetmana/list_pages/add_link_asset.dart';
import 'package:asset_management/assetmana/list_pages/model/add_asset_model.dart';
import 'package:asset_management/assetmana/list_pages/model/my_asset_model.dart';
import 'package:asset_management/assetmana/list_pages/view_my_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:asset_management/category/ui/all_categpries.dart';
import 'package:asset_management/category/ui/all_packages.dart';
import 'package:asset_management/dashboard/repository/dashboard_controller.dart';
import 'package:asset_management/dashboard/repository/model/get_home_data_response.dart';


import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart'
as permissionHandler;

import 'package:geocoding/geocoding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';
import '../../cart/ui/rokenmodel.dart';
import '../app_drawer.dart';
import '../controllers/app_controller.dart';
import '../data/local/app_shared_prefs.dart';
import '../data/local/preference_keys.dart';
import '../widgets/categorycard.dart';
import 'add_new_asset.dart';
import 'asset_list.dart';

class TabScreen extends StatefulWidget {
  Categories selectedCategory;
  List<Categories> allCategory;

  TabScreen(this.allCategory, this.selectedCategory, {super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

double totalSubtotal = 0.0;

class _TabScreenState extends State<TabScreen> {
  final appController = Get.put(AppController());

  final pageController = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  DashboardController dashboardController = Get.find();
  String userlocaton = "";
  LoginData? login_user; // = LoginData();
  var categories;

  String currentLocation = "Sourabh";
  String _currentAddress = "";

  @override
  void initState() {
    // _getLoginUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(

        length: widget.selectedCategory.subcategories!.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.selectedCategory.name!),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_box_rounded),
                tooltip: 'Open',
                onPressed: () {
                  Get.to(
                      AddNewAsset(widget.selectedCategory,null));
                },
              ),
            ],
            bottom: PreferredSize(
    preferredSize: Size.fromHeight(25),
    ///Note: Here I assigned 40 according to me. You can adjust this size acoording to your purpose.

    child: TabBar(

              indicatorColor: Colors.black,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              isScrollable: true, // new line
        tabAlignment: TabAlignment.start,

        // isScrollable: true,
            // labelPadding: EdgeInsets.only(left: 0, right: 0),

            // labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              tabs: [
            for (Subcategories caa in widget.selectedCategory.subcategories!)... [
            Tab( text: "${caa.subcategory_name}"),
            ]

              ],
            ),)
          ),
          body: TabBarView(
            children: [
          for (Subcategories caa in widget.selectedCategory.subcategories!)... [
            AssetListPage(widget.allCategory,widget.selectedCategory,caa,null)
        ]
            ],
          ),
        ),
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
}
