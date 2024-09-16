import 'package:asset_management/app_theme.dart';
import 'package:asset_management/assetmana/list_pages/asset_list.dart';
import 'package:asset_management/assetmana/list_pages/tab_screen.dart';
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
import 'package:asset_management/dashboard/widgets/search_bar.dart';
import 'package:asset_management/helper/back_screen.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:asset_management/helper/size_config.dart';
import 'package:asset_management/helper/widgets/custom_button.dart';

import 'package:asset_management/login/ui/login_screen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;

import 'package:geocoding/geocoding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../list_pages/add_new_asset_new.dart';
import '../list_pages/tab_screen_by_item.dart';
import '../controllers/app_controller.dart';
import '../widgets/categorycard.dart';

class HomePage extends StatefulWidget {
  @override
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;

  const HomePage({
    Key? key,
    this.onScreenHideButtonPressed,
    this.hideStatus = false,
  }) : super(key: key);

  State<HomePage> createState() => _HomePageState();
}

double totalSubtotal = 0.0;

class _HomePageState extends State<HomePage> {
  final appController = Get.put(AppController());

  final pageController = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  // late Position _currentPosition;
  bool _permissionCheck = false;
  DashboardController dashboardController = Get.find();
  String userlocaton = "";

  var categories;

  String currentLocation = "Sourabh";
  String _currentAddress = "";

  @override
  void initState() {
    super.initState();
    getPrefs();
    if (GetStorage().read(Constant.useraddress) != null) {
      print(GetStorage().read(Constant.useraddress) != null);
      _currentAddress = (GetStorage().read(Constant.useraddress).toString());
    }
    // _checkLocationPermission3();
    //  _checkCameraPermission3();
  }

  _checkLocationPermission3() async {
    _permissionCheck = false;
    permissionHandler.PermissionStatus? status;
    if (Platform.isAndroid) {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.location].request();
      status = result[permissionHandler.Permission.location];
    } else {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result =
          await [permissionHandler.Permission.locationWhenInUse].request();
      status = result[permissionHandler.Permission.locationWhenInUse];
    }
    // printMsg('status $status');
    print('status $status');
    if (status == permissionHandler.PermissionStatus.granted) {
      // _proceedToNextScreen();
      print('permi yes');
      _permissionCheck = true;
      // _getCurrentLocation();
      _checkCameraPermission3();
    } else {
      print('permi Nooooo');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Location Permission'),
          content:
              const Text('Please allow location permission from settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                if (Platform.isAndroid &&
                    status == permissionHandler.PermissionStatus.denied) {
                  _checkLocationPermission3();
                } else {
                  print('permi Nooooo Setting');
                  // AppSettings.openAppSettings();
                }
              },
              child: const Text('Ok'),
            ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('OK'),
            // ),
          ],
        ),
      );
    }
  }

  _checkCameraPermission3() async {
    _permissionCheck = false;
    permissionHandler.PermissionStatus? status;
    if (Platform.isAndroid) {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.camera].request();
      status = result[permissionHandler.Permission.camera];
    } else {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.camera].request();
      status = result[permissionHandler.Permission.camera];
    }
    // printMsg('status $status');
    print('status $status');
    if (status == permissionHandler.PermissionStatus.granted) {
      // _proceedToNextScreen();
      print('permi yes');
      _permissionCheck = true;
      // _getCurrentLocation();
      _checkSTORAGEPermission3();
    } else {
      print('permi Nooooo');
      if (Platform.isAndroid) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Alert! Camera Permission Required'),
            content: const Text(
                'For a better app experience and App functionality, the TestNmeds app requires camera permission. You allow camera permission from settings app.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Permission Deny'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Open Settings');
                  if (Platform.isAndroid &&
                      status == permissionHandler.PermissionStatus.denied) {
                    _checkLocationPermission3();
                  } else {
                    print('permi Nooooo Setting');
                    permissionHandler.openAppSettings();
                  }
                },
                child: const Text('Open Setting App'),
              ),
            ],
          ),
        );
      } else {
        _checkSTORAGEPermission3();
      }
    }
  }

  _checkSTORAGEPermission3() async {
    _permissionCheck = false;
    permissionHandler.PermissionStatus? status;
    if (Platform.isAndroid) {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.storage].request();
      status = result[permissionHandler.Permission.storage];
    } else {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.photos].request();
      status = result[permissionHandler.Permission.photos];
    }
    // printMsg('status $status');
    print('status $status');
    if (status == permissionHandler.PermissionStatus.granted) {
      // _proceedToNextScreen();
      print('permi yes');
      _permissionCheck = true;
      // _getCurrentLocation();
    } else {
      print('permi Nooooo');
      if (Platform.isAndroid) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Alert! Read Storage Permission'),
            content: const Text(
                'For a better app experience and App functionality, the TestNmeds app requires storage permission. You can allow storage permission from settings app.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Open Settings');
                  if (Platform.isAndroid &&
                      status == permissionHandler.PermissionStatus.denied) {
                    // _checkLocationPermission3();
                  } else {
                    print('permi Nooooo Setting');
                    permissionHandler.openAppSettings();
                  }
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      }
      // );
    }
  }

  String? searchText;

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
            key: _key,
            body: FutureBuilder(
                future: appController.getHomeData(),
                builder:
                    (context, AsyncSnapshot<GetHomeDataResponse> snapshot) {
                  // categories = GetStorage().read(Constant.CATEGORIES);
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    appController.appAllCategory = snapshot.data!.categories!;

                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildTopBanner(snapshot),
                            // Container(
                            //   margin: const EdgeInsets.only(
                            //       bottom: 12, left: 12, top: 12),
                            //   child: const Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         "Asset Categories",
                            //         style: TextStyle(
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.bold,
                            //           fontFamily: 'Roboto'
                            //         ),
                            //       ),
                            //       // InkWell(
                            //       //   //  onTap: () => Get.to(AllTest(cateogoryTest
                            //       //   // }: false)),
                            //       //   child: Container(
                            //       //     margin: EdgeInsets.only(right: 8),
                            //       //     child: const Text(
                            //       //       "View all",
                            //       //       style: TextStyle(
                            //       //           fontSize: 10,
                            //       //           fontWeight: FontWeight.bold,
                            //       //           color: Colors.deepPurple),
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                                margin: const EdgeInsets.only(
                                    bottom: 65, left: 0, top: 20),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data?.categories?.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? 3
                                              : 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 1,
                                          childAspectRatio: .9

                                          // crossAxisSpacing: 8.0,
                                          // mainAxisSpacing: 8.0,
                                          // childAspectRatio: .75

                                          // childAspectRatio: (2 / 1),
                                          ),
                                  itemBuilder: (
                                    context,
                                    index,
                                  ) {
                                    return InkWell(
                                        onTap: () {
                                          // Get.to(AssetListPage(snapshot.data!.categories!,snapshot.data!.categories![index]));
                                          Get.to(TabScreenItem(
                                              snapshot.data!.categories!,
                                              snapshot
                                                  .data!.categories![index]));
                                        },
                                        child: Card(
                                          elevation: 4.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              // Top part with image and vertical icons
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 60.0,
                                                      height: 60.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        image: DecorationImage(
                                                          image: NetworkImage( snapshot
                                                              .data!
                                                              .categories![index]
                                                              .image!),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),


                                                    // SizedBox(width: 1.0),
                                                    Expanded(child: Container()),

                                                    // Icons on the top right
                                                    Column(
                                                      // mainAxisAlignment: MainAxisAlignment.end,
                                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          height: 35.0,
                                                          width: 40.0,
                                                          child:   IconButton(
                                                          padding:const EdgeInsets.all(0),
                                                          icon: const Icon(Icons
                                                              .add_circle_rounded),
                                                          onPressed: () {

                                                            Get.to(
                                                                AddNewAssetNew(snapshot
                                                                   .data!.categories![index],null,null,null));

                                                         //   AddNewAssetNew(  snapshot
                                                           //     .data!.categories![index],itemsList,itemsList![_selectedIndex],null);

                                                          },
                                                        ),),
                                                        SizedBox(
                                                          height: 35.0,
                                                          width: 40.0,
                                                          child: IconButton(
                                                          padding:const EdgeInsets.all(0),
                                                          icon: const Icon(
                                                              Icons.remove_red_eye),
                                                          onPressed: () {
                                                            Get.to(TabScreenItem(
                                                                snapshot.data!.categories!,
                                                                snapshot
                                                                    .data!.categories![index]));
                                                          },
                                                        ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Spacer(),
                                              // Bottom part with the title
                                      Expanded(
                                             child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Center(
                                                  child: Text(
                                                      snapshot
                                                          .data!
                                                          .categories![index]
                                                          .title!
                                                          .capitalizeFirst!,
                                                      style: AppTheme.title,
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                              ),),
                                            ],
                                          ),
                                        )

                                        //Old
                                        // Container(
                                        //   height: 0,
                                        //  // color: RandomColorModel().getColor(),
                                        //   child: Column(
                                        //     // mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                        //     children: [
                                        //   Image.network(snapshot.data!.categories![index].image!,height: 50,width: 50,
                                        //       fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                                        //       Widget child, ImageChunkEvent? loadingProgress) {
                                        //     if (loadingProgress == null) return child;
                                        //     return Center(
                                        //         child: Image.asset(
                                        //           "images/aslogo.jpeg",
                                        //           height: 50,
                                        //           width: 50,
                                        //         ));
                                        //   }),
                                        //
                                        //
                                        //       SizedBox(height: 5),
                                        //
                                        //       Text(snapshot.data!.categories![index].title!.capitalizeFirst!,
                                        //           style: AppTheme.title,// TextStyle(fontSize: 18, color: Colors.black),
                                        //          textAlign: TextAlign.center),
                                        //     ],
                                        //   ),
                                        // ),
                                        );
                                  },
                                ))

                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //     itemCount: snapshot.data?.categories?.length,
                            //   itemBuilder:
                            //       (BuildContext ctx, int index) {
                            //     return CategoryCard(
                            //         category:  snapshot.data?.categories?[index],
                            //         onCardClick: () {
                            //           //  catSelection.selectedCategory = categories[index];
                            //           //  Utils.mainAppNav.currentState!.pushNamed('/selectedcategorypage');
                            //         });
                            //   },
                            // )

                            // buildRecentlySearchItems(),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ),
    );
  }

  Widget _buildTopBanner(snapshot) {
    // return FutureBuilder(
    //     future: appController.getHomeData(),
    //     builder: (context, AsyncSnapshot<GetHomeDataResponse> snapshot) {
    //
    //       categories = GetStorage().read(Constant.CATEGORIES);
    //       if (snapshot.hasData) {
    return Column(
      children: [
        Container(
          height: 200,
          child: PageView.builder(
            controller: pageController,
            itemBuilder: (c, index) {
              return Image.network(snapshot.data!.banner![index].image!,
                  fit: BoxFit.cover, loadingBuilder: (BuildContext context,
                      Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                    child: Image.asset(
                  "images/aslogo.jpeg",
                  height: 170,
                  width: 90,
                ));
              });
            },
            itemCount: snapshot.data!.banner!.length,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          height: 4,
          child: SmoothPageIndicator(
              controller: pageController, // PageController
              count: snapshot.data!.banner!.length,
              effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: Colors.grey,
                  activeDotColor: Constant.hexToColor(Constant.primaryBlue)),
              onDotClicked: (index) {}),
        ),
      ],
    );
    // } else {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    //  });
  }

  Widget buildLoadingBar() {
    return LinearProgressIndicator(
      minHeight: 4,
      backgroundColor: Constant.hexToColor(Constant.primaryBlue),
    );
  }
}

Future<bool> getPrefs() async {
  late SharedPreferences sharedPreferences;
  sharedPreferences = await SharedPreferences.getInstance();

  if (sharedPreferences.getString(Constant.USERID) == null) {
    Constant.USERLOGGEDIN = false;
    return false;
  } else {
    Constant.USERLOGGEDIN = true;
    return true;
  }
}
