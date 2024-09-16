import 'dart:convert';

import 'package:asset_management/assetmana/list_pages/add_link_asset.dart';
import 'package:asset_management/assetmana/list_pages/model/add_asset_model.dart';
import 'package:asset_management/assetmana/list_pages/model/get_asset_items.dart';
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


import '../controllers/app_controller.dart';
import '../data/local/app_shared_prefs.dart';
import '../data/local/preference_keys.dart';
import 'add_new_asset.dart';
import 'add_new_asset_new.dart';
import 'asset_list.dart';
import '../../cart/ui/rokenmodel.dart';



class TabScreenItem extends StatefulWidget {
  Categories selectedCategory;
  List<Categories> allCategory;

  TabScreenItem(this.allCategory, this.selectedCategory, {super.key});

  @override
  State<TabScreenItem> createState() => _TabScreenItemState();
}

double totalSubtotal = 0.0;

class _TabScreenItemState extends State<TabScreenItem> with SingleTickerProviderStateMixin{
  final appController = Get.put(AppController());

  final pageController = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  DashboardController dashboardController = Get.find();
  String userlocaton = "";
  LoginData? login_user; // = LoginData();
  var categories;

  String currentLocation = "Sourabh";
  String _currentAddress = "";
  late TabController _controller;
  int _selectedIndex = 0;

  List<AssetItems>? itemsList;
  @override
  void initState() {
    // _getLoginUser();
    super.initState();
    appController.selectedCategory = widget.selectedCategory;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.selectedCategory.title!),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_box_rounded),
                tooltip: 'Open',
                onPressed: () {
                  // Get.to(
                  //     AddNewAsset(widget.selectedCategory,null));

                  Get.to(
                      AddNewAssetNew(widget.selectedCategory,itemsList,itemsList![_selectedIndex],null));
                },
              ),
            ],

        ),
      body:  FutureBuilder(
        future: _getLoginUser(),
    builder: (context, AsyncSnapshot<LoginData?> loginData) {
    if (loginData.data != null) {
    login_user = loginData.data!;
    }

    return  FutureBuilder(
          future:  appController.getAssetByCategory(
              login_user!.id,
              widget.selectedCategory!.id, "0"),

          builder: (context, AsyncSnapshot<GetAssetItems> snapshot) {
            // categories = GetStorage().read(Constant.CATEGORIES);
            if (snapshot.hasData){
            snapshot.data?.items ??= [];
              print(snapshot.data);
              // appController.appItemByid=snapshot.data!.categories!;
            if(itemsList==null) {
              itemsList = snapshot.data!.items;
              _controller =
                  TabController(length: itemsList!.length, vsync: this);

              _controller.addListener(() {
                setState(() {

                  _selectedIndex = _controller.index;
                });
                print("Selected Index: " + _controller.index.toString());
              });
            }
              return DefaultTabController(

                // length: widget.selectedCategory.subcategories!.length,
                length: snapshot.data!.items!.length,

                child: Scaffold(
                  appBar: AppBar(
                      // titleSpacing: 0,

                      automaticallyImplyLeading: false,

                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(0),
                        ///Note: Here I assigned 40 according to me. You can adjust this size acoording to your purpose.

                        child: TabBar(
                          padding: const EdgeInsets.only(top: 1),
                          indicatorPadding:const EdgeInsets.only(top: 1),
                          // labelPadding: EdgeInsets.zero,

                          indicatorColor: Colors.black,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white,
                          isScrollable: true, // new line
                          tabAlignment: TabAlignment.start,
                          controller: _controller,

                          tabs: [
                            // for (Subcategories caa in widget.selectedCategory.subcategories!)... [
                            // Tab( text: "${caa.subcategory_name}"),
                            // ]
                            for (AssetItems caa in snapshot.data!.items!)... [
                              Tab( text: "${caa.item}"),
                            ]

                          ],
                        ),)
                  ),
                  body: TabBarView(
                    controller: _controller,

                    children: [
                      //   for (Subcategories caa in widget.selectedCategory.subcategories!)... [
                      //     AssetListPage(widget.allCategory,widget.selectedCategory,caa)
                      // ]
                      for (AssetItems caa in snapshot.data!.items!)... [
                        AssetListPage(widget.allCategory,widget.selectedCategory,null,caa)
                      ]


                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }));

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
