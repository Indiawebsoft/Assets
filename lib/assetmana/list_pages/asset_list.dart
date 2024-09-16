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
import 'package:asset_management/dashboard/widgets/search_bar.dart';
import 'package:asset_management/helper/back_screen.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:asset_management/helper/size_config.dart';

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

import '../../app_theme.dart';
import '../../cart/ui/rokenmodel.dart';
import '../../helper/widgets/Dialogs.dart';
import '../../helper/widgets/text_styles.dart';
import '../app_drawer.dart';
import '../controllers/app_controller.dart';
import '../data/local/app_shared_prefs.dart';
import '../data/local/preference_keys.dart';
import '../ui_view/text_decoration.dart';
import '../widgets/categorycard.dart';
import 'add_new_asset.dart';
import 'link_my_asset.dart';
import 'model/add_asset_response.dart';
import 'model/get_asset_items.dart';

class AssetListPage extends StatefulWidget {
  Categories? selectedCategory;
  List<Categories>? allCategory;
  Subcategories? selectedSubCategory;
  AssetItems? selectedItem;

  AssetListPage(
      this.allCategory, this.selectedCategory, this.selectedSubCategory, this.selectedItem,
      {super.key});

  @override
  State<AssetListPage> createState() => _AssetListPageState();
}

double totalSubtotal = 0.0;

class _AssetListPageState extends State<AssetListPage> {
  final appController = Get.put(AppController());
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final pageController = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  DashboardController dashboardController = Get.find();
  String userlocaton = "";
  LoginData? login_user; // = LoginData();
  var categories;

  String currentLocation = "Sourabh";
  String _currentAddress = "";

  List<AddAssetModel> myAllAssetList=[];
  late DateTime _selectedDate;
  String _dropdownValue = 'Minutes';
  TextEditingController _notificationTimeController = TextEditingController();

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != _selectedDate)
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  // }


  @override
  void initState() {
    // _getLoginUser();
    super.initState();
    // if (widget.selectedCategory == null) {
    //   widget.selectedCategory = Categories();
    //   widget.selectedCategory!.id != "0";
    //
    //   widget.selectedSubCategory = Subcategories();
    //   widget.selectedSubCategory!.id != "0";
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.selectedCategory.name!),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.add_box_rounded),
      //       tooltip: 'Open',
      //       onPressed: () {
      //         Get.to(
      //             AddNewAsset(widget.selectedCategory,null));
      //       },
      //     ),
      //   ],
      // ),
      // drawer: AppDrawer(),
        key: _key,
        body: FutureBuilder(
            future: _getLoginUser(),
            builder: (context, AsyncSnapshot<LoginData?> loginData) {
              if (loginData.data != null) {
                login_user = loginData.data!;
              }

              return FutureBuilder(
                // future: (widget.selectedCategory != null)
                //     ? appController.getMyAsset(
                //         login_user!.id,
                //         widget.selectedCategory!.id,
                //         widget.selectedSubCategory!.id)
                // future: (widget.selectedCategory != null)
                //     ?
                  future: appController.getMyAsset(
                      login_user!.id,
                      widget.selectedCategory!.id,
                      widget.selectedItem!.subcategory_id,
                      widget.selectedItem!.id),
                  // : appController.getMyAsset(login_user!.id, "0", "0","0"),
                  builder: (context, AsyncSnapshot<GetMyAsset> snapshot) {
                    // categories = GetStorage().read(Constant.CATEGORIES);
                    if (snapshot.hasData && snapshot.data?.assets != null) {
                      print(snapshot.data);
                      myAllAssetList=snapshot.data!.assets!;
                      return Container(
                          margin: EdgeInsets.all(12),
                          child: _buildAssetList(snapshot.data!.assets!));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            }));
  }

  Widget _buildAssetList(List<AddAssetModel> myassetlist) {
    if (myassetlist.isNotEmpty) {
      return ListView.builder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (c, index) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                  color: Colors.white,
                  elevation: 1,
                  //   shadowColor: Colors.blue,
                  child: ListTile(
                    onTap: () {
                      // print(category);
                      Get.to(ViewMyAsset(myassetlist[index], null, ""));
                    },
                    leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (myassetlist[index].item_image == "") ?
                          const CircleAvatar(
                            backgroundImage: AssetImage('images/gall.png'),
                          ) : CircleAvatar(
                            backgroundColor: Colors.black,
                            // radius: 100,
                            child: CircleAvatar(
                              // radius: 20 - 5,
                              backgroundImage: Image
                                  .memory(
                                const Base64Decoder().convert(
                                    myassetlist[index].item_image),
                                fit: BoxFit.cover,
                              )
                                  .image,
                            ),
                          ),
                        ]),
                    title: Text(myassetlist[index].headingName,
                        style: AppTheme.title),
                    subtitle:
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${myassetlist[index]
                                        .categoryName}, ${myassetlist[index]
                                        .subCategoryName}",
                                    style: AppTheme.subtitle,
                                  ),
                                  Text("${myassetlist[index].itemName}",
                                      style: AppTheme.subtitle),
                                  Text(
                                      "Addedon - ${myassetlist[index].addedon}",
                                      style: AppTheme.body1),
                                  // (myassetlist[index].add_button == "showitem")
                                  //     ? Padding(
                                  //         padding: const EdgeInsets.only(top: 10),
                                  //         child: Container(
                                  //             child: Align(
                                  //           alignment: Alignment.centerRight,
                                  //           child: OutlinedButton(
                                  //             onPressed: () {
                                  //               Get.to(
                                  //                   AddLinkAsset(myassetlist[index], ""));
                                  //             }, //_showPopup,
                                  //             style: OutlinedButton.styleFrom(
                                  //               //<-- SEE HERE
                                  //               side: BorderSide(width: 1.0),
                                  //             ),
                                  //             child: Text("Link More Assets"),
                                  //           ),
                                  //         )))
                                  //     : Container(),

                                ],
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                // Center the column vertically
                                children: [
                                  GestureDetector(
                                    child:
                                    Image.asset(
                                      "images/notification.png",
                                      height: 30,
                                    ),
                                    onTap: () {
                                      _showReminderDialog(context,myassetlist[index],index);
                                    },
                                  ),
                                  const Text(
                                    "",
                                    style: AppTheme.body2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              (myassetlist[index].add_button == "showitem")
                                  ? OutlinedButton(
                                onPressed: () {
                                  Get.to(
                                      AddLinkAsset(myassetlist[index], ""));
                                }, //_showPopup,
                                style: OutlinedButton.styleFrom(
                                  //<-- SEE HERE
                                  side: BorderSide(width: 1.0),

                                ),
                                child: const Text("Link Assets",
                                    style: TextStyle(fontSize: 12)),
                              ) : Container(),
                              const SizedBox(width: 10),
                              // Add some space between the buttons
                              OutlinedButton(
                                onPressed: () {
                                  Get.to(
                                      LinkMyAsset(
                                          login_user!.id, myassetlist[index],
                                          ""));
                                }, //_showPopup,
                                style: OutlinedButton.styleFrom(
                                  //<-- SEE HERE
                                  side: BorderSide(width: 1.0),

                                ),
                                child: const Text("Link My Assets",
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ]),


                    //Text("${myassetlist[index].categoryName}, ${myassetlist[index].subCategoryName}"),
                    // trailing: Container(
                    //   // margin: const EdgeInsets.only(top: 5),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Image.asset(
                    //         "images/notification.png",
                    //         height: 20,
                    //       ),
                    //       const Text(
                    //         "",
                    //         style: AppTheme.body2,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  )));

          // return OrderCard(snapshot.data!.data![index]);
        },
        itemCount: myassetlist.length,
      );
    } else {
      return const Center(
        child: Text("No Asset Found"),
      );
    }
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
  void _showReminderDialog(BuildContext context, AddAssetModel myassetlist, int index) {
    if (myAllAssetList[index].reminder_befor_type == "") {
      myAllAssetList[index].reminder_befor_type = 'Days';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Set Reminder"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _getLabel("Reminder Date", "Yes"),
                  SizedBox(height: 20),
                  TextField(
                    style: TSB.regularVSmall(),
                    controller: TextEditingController(
                      text: myAllAssetList[index].reminder_date,
                    ),
                    onChanged: (s) {},
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppTextDecoration.buildTextFieldDecoration(hintText: 'Date'),
                    readOnly: true,
                    onTap: () {
                      _selectDate(context, index).then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            myAllAssetList[index].reminder_date = pickedDate;
                          });
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      // First input field with heading (70%)
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _getLabel("Remind me before (number)", "Yes"),
                            SizedBox(height: 8.0),
                            TextField(
                              style: TSB.regularVSmall(),
                              controller: TextEditingController(
                                text: myAllAssetList[index].reminder_befor,
                              ),
                              onChanged: (s) {
                                // setState(() {
                                  myAllAssetList[index].reminder_befor = s;
                                // });
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              decoration: AppTextDecoration.buildTextFieldDecoration(hintText: ''),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0), // Add some space between the two input fields
                      // Second input field with heading (30%)
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _getLabel("Duration", "Yes"),
                            SizedBox(height: 8.0),
                            DropdownButton<String>(
                              value: myAllAssetList[index].reminder_befor_type,
                              onChanged: (String? newValue) {
                                setState(() {
                                  myAllAssetList[index].reminder_befor_type = newValue!;
                                });
                              },
                              //'Minutes', 'Hours',
                              items: <String>[ 'Days', 'Weeks']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style:TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Set Reminder"),
              onPressed: () {
                if (myAllAssetList[index].reminder_date != null) {
                  // Add your reminder notification logic here

                  setremainder(myAllAssetList[index].reminder_date!,myAllAssetList[index].reminder_befor!,myAllAssetList[index].reminder_befor_type!,myAllAssetList[index].id!);
                  print(
                      "Reminder set for ${myAllAssetList[index].reminder_date!}, notify ${myAllAssetList[index].reminder_befor!}. ${myAllAssetList[index].reminder_befor_type!} before.");
                }
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void setremainder(String date, String befor, String type, String assetid) async {

    Dialogs.showLoadingDialog(context, _keyLoader);
    AddAssetResponse assetResponse = await appController.setreminder(date,befor,type,assetid);
    if (assetResponse.success!) {
      Constant.showToast("Unlink Asset Added Successfully");
      Navigator.of(context).pop();
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {});
    } else {
      Navigator.of(context).pop();
      Navigator.of(context, rootNavigator: true).pop();
      print("Add Asset error " + assetResponse.toString());
    }
  }

  _getLabel(String title, String required) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
            flex: 30,
            child: RichText(
              text: TextSpan(
                text: title,
                style: TSB.boldSmall(textColor: Color(0xff666666)),
                children: [
                  (required == "YES")
                      ? const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : const TextSpan(
                    text: '',
                  ),
                ],
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      return picked.toString().split(" ")[0];
    }else{
      return "";
    }
  }
}