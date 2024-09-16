import 'dart:io';
import 'package:asset_management/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:get/get.dart';
import '../../cart/ui/rokenmodel.dart';
import '../../helper/constant.dart';
import '../../helper/widgets/Dialogs.dart';
import '../../helper/widgets/text_styles.dart';
import '../controllers/app_controller.dart';
import '../data/local/app_shared_prefs.dart';
import '../data/local/preference_keys.dart';
import '../ui_view/text_decoration.dart';
import '../utility/base64_image_widget.dart';
import 'model/add_asset_model.dart';
import 'model/add_asset_response.dart';
import 'model/get_asset_items.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'model/my_asset_model.dart';

class LinkMyAsset extends StatefulWidget {
  AddAssetModel selectedItem;
  // List<Categories> allCategory;
  String userid;
  String eidtitem;
  LinkMyAsset(this.userid,this.selectedItem, this.eidtitem, {super.key});

  @override
  State<LinkMyAsset> createState() => _LinkMyAssetState();
}

class _LinkMyAssetState extends State<LinkMyAsset> {
  AppController appController = Get.find();
  LoginData? login_user; // = LoginData();
  List<AddAssetModel> myassetlist = [];
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<String> itemDropDownList = [];
  AddAssetModel? selectedItemss;
  @override
  void initState() {
    super.initState();
    _getLoginUser();
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
              "Link My Asset",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            // Text("Complete Profile"),
          ),
          body: Container(margin: EdgeInsets.all(12), child: builMyUI()),
        ));
  }

  Widget builMyUI() {
    final jobRoleCtrl = TextEditingController();

    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 13.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return SingleChildScrollView(
        child: FutureBuilder(
            future: _getLoginUser(),
            builder: (context, AsyncSnapshot<LoginData?> loginData) {
              if (loginData.data != null) {
                login_user = loginData.data!;
              }

              return FutureBuilder(
                  future:
                      appController.getMyOldAsset(widget.userid, '', '', ''),
                  // : appController.getMyAsset(login_user!.id, "0", "0","0"),
                  builder: (context, AsyncSnapshot<GetMyAsset> snapshot) {
                    if (snapshot.hasData && snapshot.data?.assets != null) {
                      myassetlist = snapshot.data!.assets!;
                      itemDropDownList = [];
                      for (AddAssetModel tempItems in myassetlist) {
                        itemDropDownList.add(tempItems.headingName!);
                      }
                      // setState(() {});
                      print(snapshot.data);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // _getLabel("Sub Category", "YES"),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "Link Asset to ${widget.selectedItem.headingName}",
                                    style: AppTheme.title),
                              ]),
                          _getLabel("Asset Item", "YES"),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: itemDropDownList,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  AppTextDecoration.buildTextFieldDecoration(
                                      hintText: 'Select'),
                            ),
                            onChanged: (value) {
                              //   _getAssetForm(value!);
                              onselectitem(value!);
                            },
                            // selectedItem: addAssetData.itemName,
                          ),
                          (selectedItemss != null)
                              ? _getLabel("Asset Detail", "no")
                              : Container(),
                          (selectedItemss != null)
                              ? _getAssetDataNew()
                              : Container(),
                          (selectedItemss != null) ?
                          Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff132137),
                                ),
                                onPressed: _onSubmitClick,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // Icon(Icons.arrow_forward_rounded, color: Colors.white),
                                  ],
                                ),
                              )) : Container(),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            }));
  }

  onselectitem(String ssitem) {
    print(ssitem);
    for (AddAssetModel iit in myassetlist) {
      if (ssitem == iit.headingName!) {
        selectedItemss = iit;
        setState(() {});
        break;
      }
    }
  }

  _onSubmitClick() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    AddAssetResponse assetResponse = await appController.
    postlinkasset(widget.userid,widget.selectedItem.id,selectedItemss?.id);
    if (assetResponse.success!) {
      Constant.showToast("Asset linked Successfully");

      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pop(context);
      // Get.to(OrderConfirm());
      // Get.offAll(HomeBottomMenu());
      // if (Navigator.canPop(context)) {
      //   Navigator.pop(context);
      // } else {
      //   SystemNavigator.pop();
      // }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      print("Add Asset error " + assetResponse.toString());
    }
  }

  _getAssetDataNew() {
    return Table(
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(4),
          // 2: FlexColumnWidth(4),
        },
        border: const TableBorder(
            horizontalInside:
                BorderSide(color: AppTheme.black_text_color, width: 1.0),
            verticalInside:
                BorderSide(color: AppTheme.black_text_color, width: 1.0)),
        // Allows to add a border decoration around your table
        children: [
          // for (Files itemFormFiles in selectedItemss!.itemForm!.form_name!.files!)
          //   inputs.forEachIndexed((index, element) {
          for (var i = 0;
              i < selectedItemss!.itemForm!.form_name!.files!.length;
              i++) ...[
            if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "alphabetical") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),

                // Text(selectedItemss!.itemForm!.form_name!.files![i].heading!),
                // Text(selectedItemss!.itemForm!.form_name!.files![i].heading!),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "numarical") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "alphanumeric") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "date") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "p") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "dropdown") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "multipal") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "checkbox") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "radio") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    (selectedItemss!.itemForm!.form_name!.files![i].value !=
                            null)
                        ? selectedItemss!.itemForm!.form_name!.files![i].value!
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "file") ...[
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    selectedItemss!.itemForm!.form_name!.files![i].heading!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child: selectedItemss!
                                  .itemForm!.form_name!.files![i].value !=
                              null
                          ? Center(
                              child: Container(
                                  height: 100,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Base64ImageWidget(selectedItemss!
                                      .itemForm!.form_name!.files![i].value!)))
                          : Container()),
                ),
                // Text('Author'),
              ]),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "addform")
              ...[]
            else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "auto--") ...[
              //  _getLabel(selectedItemss!.itemForm!.form_name!.files![i].heading!,
              //    selectedItemss!.itemForm!.form_name!.files![i].isrequerd!),
            ] else if (selectedItemss!.itemForm!.form_name!.files![i].type ==
                "showitem")
              ...[]
          ],
        ]);
  }

  String getConvertIntoBase64(String path) {
    final bytes = File(path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }

  void hideKeyboard(BuildContext context) {}

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

  _getLabel(String title, String required) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          children: [
            Expanded(
                flex: 30,
                child: RichText(
                  text: TextSpan(
                      text: title,
                      style: TSB.boldMedium(textColor: Color(0xff666666)),
                      children: [
                        (required == "YES")
                            ? const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ))
                            : const TextSpan(
                                text: '',
                              ),
                      ]),
                  // textScaleFactor: labelTextScale,
                  maxLines: 3,
                  // overflow: overflow,
                  // textAlign: textAlign,
                )),
          ],
        ));
  }
}
