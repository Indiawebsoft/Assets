import 'dart:io';
import 'package:asset_management/app_theme.dart';
import 'package:asset_management/assetmana/controllers/app_controller.dart';
import 'package:asset_management/assetmana/list_pages/model/add_asset_model.dart';
import 'package:asset_management/assetmana/list_pages/model/add_asset_response.dart';
import 'package:asset_management/assetmana/list_pages/model/get_asset_items.dart';
import 'package:asset_management/assetmana/ui_view/text_decoration.dart';
import 'package:asset_management/web_view.dart';
import 'package:asset_management/login/repository/model/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:asset_management/dashboard/repository/dashboard_controller.dart';
import 'package:asset_management/helper/back_screen.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:asset_management/assetmana/utility/app_utility.dart';

import '../../dashboard/repository/model/get_home_data_response.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../helper/size_config.dart';
import '../../helper/widgets/Dialogs.dart';
import '../../helper/widgets/text_styles.dart';
import '../data/local/app_shared_prefs.dart';
import '../data/local/preference_keys.dart';
import '../home/home_bottom_menu.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import 'link_asset_dialog.dart';
import 'model/my_asset_model.dart';

class AddNewAsset extends StatefulWidget {
  Categories? selectedCategory;
  // List<Categories> allCategory;
  AddAssetModel? editAsset;
  AddNewAsset(this.selectedCategory, this.editAsset, {super.key});

  @override
  State<AddNewAsset> createState() => _AddNewAssetState();
}

class _AddNewAssetState extends State<AddNewAsset> {
  AppController appController = Get.find();
  LoginData? login_user; // = LoginData();
  bool isshowcategory = false;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<String> categoryarray = [];
  final picker = ImagePicker();

  List<String> subcategoryarray = [];
  List<AssetItems> itemlist = [];

  List<String> itemDropDownList = [];

  List<AssetItems>? itemAssetList = [];
  List<String> tempitemDropDownList = [];

  List<AssetItems>? itemAssetList2 = [];
  List<String> tempitemDropDownList2 = [];

  List<String> oldtempitemDropDownList2 = [];

  AddAssetModel addAssetData = AddAssetModel();

  List<AddAssetModel>? linkAssetArrey = [];
  List<AddAssetModel>? linkAssetArrey2 = [];

  List<AddAssetModel>? oldListAsset2 = [];

  AddAssetModel addLinkAssetData = AddAssetModel();
  AddAssetModel addLinkAssetData2 = AddAssetModel();

  String newAssetlink2name = "";
  @override
  void initState() {
    super.initState();
    _getLoginUser();

    if (widget.selectedCategory == null) {
      // widget.selectedCategory
      isshowcategory = true;

      categoryarray = [];
      for (Categories caate in appController.appAllCategory) {
        categoryarray.add(caate.name!);
      }
    } else {
      if (widget.editAsset != null) {
        addAssetData = widget.editAsset!;
        // addAssetData.subCategoryName =widget.editAsset!.subCategory;
        // addAssetData.subCategory =widget.editAsset!.subCategory;
        // addAssetData.subCategoryName = subcategory;
      } else {
        addAssetData.category = widget.selectedCategory!.id;
        addAssetData.categoryName = widget.selectedCategory!.name;
        addAssetData.add_button = "No";
      }
      appController.selectedCategory = widget.selectedCategory!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedCategory != null) {
      subcategoryarray = [];
      for (Subcategories caa in widget.selectedCategory!.subcategories!) {
        subcategoryarray.add(caa.subcategory_name!);
      }
      addAssetData.category = widget.selectedCategory!.id;
      addAssetData.categoryName = widget.selectedCategory!.name;
    } else {
      addAssetData.category = "";
      addAssetData.categoryName = "";
    }
    return Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              "Add ${(widget.selectedCategory != null) ? widget.selectedCategory!.name : ""} Asset",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            // Text("Complete Profile"),
          ),
          body: Container(margin: EdgeInsets.all(12), child: buildProfileUI()),
        ));
  }

  Widget buildProfileUI() {
    final jobRoleCtrl = TextEditingController();

    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 13.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return SingleChildScrollView(
        child: Column(
      children: [
        (isshowcategory) ? _getLabel("Category", "YES") : Container(),
        (isshowcategory)
            ? Container(
                height: 44,
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                    showSelectedItems: true,
                    // disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: categoryarray,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration:
                        AppTextDecoration.buildTextFieldDecoration(
                            hintText: 'Select'),
                  ),
                  onChanged: (value) {
                    _getSelectCategory(value!);
                  },
                  selectedItem: addAssetData.categoryName!,
                ))
            : Container(),

        _getLabel("Sub Category", "YES"),
        Container(
            height: 44,
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSearchBox: true,
                showSelectedItems: true,
                // disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: subcategoryarray,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Select'),
              ),
              onChanged: (value) {
                _getAssetItems(value!);
              },
              selectedItem: addAssetData.subCategoryName,
            )),

        (addAssetData.subCategory != null && addAssetData.subCategory != "")
            ? Column(children: [
                _getLabel("Asset Item", "YES"),
                Container(
                    height: 44,
                    child: DropdownSearch<String>(
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
                        _getAssetForm(value!);
                      },
                      selectedItem: addAssetData.itemName,
                    )),
              ])
            : Container(),
        (addAssetData.item != null &&
                addAssetData.item != "" &&
                addAssetData.itemForm != null)
            ? _getFormFields()
            : Container(),
        // _getLabel("Asset Sub Category"),
        // DropdownSearch<String>(
        //   popupProps: const PopupProps.menu(
        //     showSearchBox: true,
        //     showSelectedItems: true,
        //     // disabledItemFn: (String s) => s.startsWith('I'),
        //   ),
        //   items: subcategoryarray,
        //   dropdownDecoratorProps:  DropDownDecoratorProps(
        //     dropdownSearchDecoration: AppTextDecoration.buildTextFieldDecoration(
        //         hintText: 'Select'),
        //   ),
        //   onChanged: (value){
        //
        //   },
        //   selectedItem: "",
        // ),
        // TextField(
        //   enabled: false,
        //   style: TSB.regularVSmall(),
        //   controller: TextEditingController(text: login_user?.email),
        //   onChanged: (s) => login_user?.email = s.trim(),
        //   textInputAction: TextInputAction.done,
        //   keyboardType: TextInputType.emailAddress,
        //   decoration: AppTextDecoration.buildTextFieldDecoration(
        //       hintText: 'Your Email Id'),
        // ),
      ],
    ));
  }

  _getSelectCategory(String categoty) async {
    for (Categories caa in appController.appAllCategory!) {
      if (categoty == caa.name!) {
        addAssetData.category = caa.id!;
        addAssetData.categoryName = categoty;
        widget.selectedCategory = caa;
        break;
      }

      subcategoryarray = [];
      for (Subcategories caa in widget.selectedCategory!.subcategories!) {
        subcategoryarray.add(caa.subcategory_name!);
      }
      addAssetData.category = widget.selectedCategory!.id;
      addAssetData.categoryName = widget.selectedCategory!.name;
    }

    addAssetData.item = "";
    addAssetData.itemName = "";
    addAssetData.itemForm = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    GetAssetItems response =
        await appController.getAssetItems(addAssetData.subCategory);

    if (response.success! && response.items != null) {
      itemlist = response.items!;
      itemDropDownList = [];
      for (AssetItems tempItems in itemlist) {
        itemDropDownList.add(tempItems.item!);
      }

      setState(() {});
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      //close the dialoge
      Navigator.of(context, rootNavigator: true).pop();
      Constant.showToast("No Item Found");
    }
  }

  _getAssetItems(String subcategory) async {
    for (Subcategories caa in widget.selectedCategory!.subcategories!) {
      if (subcategory == caa.subcategory_name!) {
        addAssetData.subCategory = caa.id!;
        addAssetData.subCategoryName = subcategory;
        break;
      }
    }

    addAssetData.item = "";
    addAssetData.itemName = "";
    addAssetData.itemForm = null;
    Dialogs.showLoadingDialog(context, _keyLoader);
    GetAssetItems response =
        await appController.getAssetItems(addAssetData.subCategory);

    if (response.success! && response.items != null) {
      itemlist = response.items!;
      itemDropDownList = [];
      for (AssetItems tempItems in itemlist) {
        itemDropDownList.add(tempItems.item!);
      }

      setState(() {});
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      //close the dialoge
      Navigator.of(context, rootNavigator: true).pop();
      Constant.showToast("No Item Found");
    }
  }

  _getAssetForm(String item) async {
    for (AssetItems iit in itemlist) {
      if (item == iit.item!) {
        addAssetData.item = iit.id!;
        addAssetData.itemName = iit.item;
        addAssetData.itemForm = iit.formdata;
        break;
      }
    }
    setState(() {});
  }

  _getLinkAssetForm(String item) async {
    for (AssetItems iit in itemAssetList!) {
      if (item == iit.item!) {
        addLinkAssetData.item = iit.id!;
        addLinkAssetData.itemName = iit.item;
        addLinkAssetData.itemForm = iit.formdata;
        break;
      }
    }
    // setState(() {});
  }

  _getLinkAssetForm2(String item) async {
    for (AssetItems iit in itemAssetList2!) {
      if (item == iit.item!) {
        addLinkAssetData2.item = iit.id!;
        addLinkAssetData2.itemName = iit.item;
        addLinkAssetData2.itemForm = iit.formdata;
        oldListAsset2 = iit!.oldassets;
        break;
      }
    }
    // setState(() {});
  }

  _selectOldAssect(String item1) async {
    if (item1 != "") {
      final splitted = item1.split('(code:');
      String item = splitted[0];
      for (AddAssetModel iit in oldListAsset2!) {
        if (item == iit.itemName!) {
          addLinkAssetData2.item = iit.item;
          addLinkAssetData2.itemName = iit.item;
          break;
        }
      }
    }
    // setState(() {});
  }

  _getFormFields() {
    // Files itemFormFiles  = addAssetData.itemForm!.form_name!.files![0];
    return Column(children: [
      // for (Files itemFormFiles in addAssetData.itemForm!.form_name!.files!)
      //   inputs.forEachIndexed((index, element) {
      for (var i = 0;
          i < addAssetData.itemForm!.form_name!.files!.length;
          i++) ...[
        if (addAssetData.itemForm!.form_name!.files![i].type ==
            "alphabetical") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {
              addAssetData.itemForm!.form_name!.files![i].value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "numarical") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {
              print("aaaaaaa - ${s}");
              addAssetData.itemForm!.form_name!.files![i].value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "alphanumeric") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {
              print(s);
              addAssetData.itemForm!.form_name!.files![i].value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "date") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {},
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: 'Date'),
            readOnly: true,
            onTap: () {
              _selectDate(context, i, 999);
            },
          ),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type == "p") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            minLines: 3,
            maxLines: null,
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {
              addAssetData.itemForm!.form_name!.files![i].value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "dropdown") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),

          Container(
            height: 44,
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSearchBox: true,
                showSelectedItems: true,
                // disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: addAssetData.itemForm!.form_name!.files![i].option!,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Select'),
              ),
              onChanged: (value) {
                addAssetData.itemForm!.form_name!.files![i].value = value;
                // _getAssetForm(value!);
              },
              selectedItem: addAssetData.itemForm!.form_name!.files![i].value,
            ),
          ),

          // DropdownSearch<String>(
          //   popupProps: const PopupProps.menu(
          //     showSearchBox: true,
          //     showSelectedItems: true,
          //     // disabledItemFn: (String s) => s.startsWith('I'),
          //   ),
          //   items: addAssetData.itemForm!.form_name!.files![i].option!,
          //   dropdownDecoratorProps: DropDownDecoratorProps(
          //     dropdownSearchDecoration:
          //         AppTextDecoration.buildTextFieldDecoration(
          //             hintText: 'Select'),
          //   ),
          //   onChanged: (value) {
          //     addAssetData.itemForm!.form_name!.files![i].value = value;
          //     // _getAssetForm(value!);
          //   },
          //   selectedItem: addAssetData.itemForm!.form_name!.files![i].value,
          // ),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "multipal") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          Container(
            height: 44,
            child: DropdownSearch<String>.multiSelection(
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
                showSelectedItems: true,
                // disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: addAssetData.itemForm!.form_name!.files![i].option!,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Select'),
              ),
              onChanged: (value) {
                addAssetData.itemForm!.form_name!.files![i].multipleValues =
                    value;
                // _getAssetForm(value!);
              },
              selectedItems: (addAssetData
                          .itemForm!.form_name!.files![i].multipleValues !=
                      null)
                  ? addAssetData.itemForm!.form_name!.files![i].multipleValues!
                  : [],
            ),
          )
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "checkbox") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          for (var item in addAssetData.itemForm!.form_name!.files![i].option!)
            CheckboxListTile(
              title: Text(item.toUpperCase()),
              value: (addAssetData
                  .itemForm!.form_name!.files![i].multipleValues!
                  .contains(item)),
              onChanged: (value) {
                var indexOf = addAssetData
                    .itemForm!.form_name!.files![i].option!
                    .indexOf(item);
                setState(() {
                  if (addAssetData
                          .itemForm!.form_name!.files![i].multipleValues ==
                      null) {
                    addAssetData.itemForm!.form_name!.files![i].multipleValues =
                        [];
                  }
                  if (value!) {
                    if (!addAssetData
                        .itemForm!.form_name!.files![i].multipleValues!
                        .contains(item)) {
                      addAssetData
                          .itemForm!.form_name!.files![i].multipleValues!
                          .add(item);
                    }
                  } else {
                    addAssetData.itemForm!.form_name!.files![i].multipleValues!
                        .remove(item);
                  }
                  print(addAssetData
                      .itemForm!.form_name!.files![i].multipleValues);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "radio") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var option
                  in addAssetData.itemForm!.form_name!.files![i].option!)
                // Expanded(
                // child:
                ListTile(
                  // contentPadding: const EdgeInsets.all(0),
                  title: Text(option),
                  leading: Radio(
                    value: option!,
                    groupValue:
                        addAssetData.itemForm!.form_name!.files![i].value,
                    activeColor: Colors.red,
                    // Change the active radio button color here
                    fillColor: MaterialStateProperty.all(Colors.red),
                    // Change the fill color when selected
                    splashRadius: 20,
                    // Change the splash radius when clicked
                    onChanged: (value) {
                      setState(() {
                        addAssetData.itemForm!.form_name!.files![i].value =
                            value;
                      });
                    },
                  ),
                )
              // ),
            ],
          ),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "file") ...[
          _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          Container(
              margin: EdgeInsets.only(top: 1),
              child: addAssetData
                      .itemForm!.form_name!.files![i].value!= null
                  ? Center(
                      child: Container(
                          height: 100,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Base64ImageWidget(addAssetData
        .itemForm!.form_name!.files![i].value!)))
                  : Center(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                width: 1,
                                color: Constant.hexToColor(
                                    Constant.primaryBlueMin))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _showPicker(context,addAssetData,i,1);
                                  },
                                  icon: Icon(Icons.add_circle_outline_sharp)),
                              // Container(
                              //     margin: const EdgeInsets.only(top: 0),
                              //     child: const Text(
                              //       "Upload Image",
                              //       style: TextStyle(fontSize: 2),
                              //     ))
                            ],
                          ),
                        ),
                      ),
                    )),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "addform") ...[
          _geHeading(addAssetData.itemForm!.form_name!.files![i].heading!,
              addAssetData.itemForm!.form_name!.files![i].isrequerd!),
          _getExtraFormFields(
              i, addAssetData.itemForm!.form_name!.files![i].extraform)
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "auto--") ...[
          //  _getLabel(addAssetData.itemForm!.form_name!.files![i].heading!,
          //    addAssetData.itemForm!.form_name!.files![i].isrequerd!),
        ] else if (addAssetData.itemForm!.form_name!.files![i].type ==
            "showitem") ...[
          _updateButtonText("showitem")
          // Padding(
          //     padding: const EdgeInsets.only(top: 10),
          //     child: Container(
          //         child: Align(
          //       alignment: Alignment.centerRight,
          //       child: OutlinedButton(
          //         onPressed: _showPopup,
          //         style: OutlinedButton.styleFrom(
          //           //<-- SEE HERE
          //           side: BorderSide(width: 1.0),
          //         ),
          //         child: Text(
          //             addAssetData.itemForm!.form_name!.files![i].heading!),
          //       ),
          //     )))
        ]
      ],

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
          ))
    ]);
  }

  _updateButtonText(String value) {
    addAssetData.add_button = value;
    return Container();
  }

  _getExtraFormFields(int i, FormName? extraform) {
    // Files itemFormFiles  = addAssetData.itemForm!.form_name!.files![0];
    return Column(children: [
      // for (Files itemFormFiles in addAssetData.itemForm!.form_name!.files!)
      //   inputs.forEachIndexed((index, element) {
      for (var j = 0;
          j <
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files!.length;
          j++) ...[
        if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "alphabetical") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData
                    .itemForm!.form_name!.files![i].extraform!.files![j].value),
            onChanged: (s) {
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "numarical") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData
                    .itemForm!.form_name!.files![i].extraform!.files![j].value),
            onChanged: (s) {
              print("aaaaaaa - ${s}");
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "alphanumeric") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData
                    .itemForm!.form_name!.files![i].extraform!.files![j].value),
            onChanged: (s) {
              print(s);
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "date") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData
                    .itemForm!.form_name!.files![i].extraform!.files![j].value),
            onChanged: (s) {},
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: 'Date'),
            readOnly: true,
            onTap: () {
              _selectDate(context, i, j);
            },
          ),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "p") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          TextField(
            minLines: 3,
            maxLines: null,
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData
                    .itemForm!.form_name!.files![i].extraform!.files![j].value),
            onChanged: (s) {
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "dropdown") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          Container(
            height: 44,
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSearchBox: true,
                showSelectedItems: true,
                // disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].option!,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Select'),
              ),
              onChanged: (value) {
                addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                    .value = value;
                // _getAssetForm(value!);
              },
              selectedItem: addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].value,
            ),
          )
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "multipal") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          Container(
            height: 44,
            child: DropdownSearch<String>.multiSelection(
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
                showSelectedItems: true,
                // disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].option!,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Select'),
              ),
              onChanged: (value) {
                addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                    .multipleValues = value;
                // _getAssetForm(value!);
              },
              selectedItems:
                  (addAssetData.itemForm!.form_name!.files![i].multipleValues !=
                          null)
                      ? addAssetData.itemForm!.form_name!.files![i].extraform!
                          .files![j].multipleValues!
                      : [],
            ),
          )
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "checkbox") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          for (var item in addAssetData
              .itemForm!.form_name!.files![i].extraform!.files![j].option!)
            CheckboxListTile(
              title: Text(item.toUpperCase()),
              value: (addAssetData
                  .itemForm!.form_name!.files![i].multipleValues!
                  .contains(item)),
              onChanged: (value) {
                var indexOf = addAssetData
                    .itemForm!.form_name!.files![i].option!
                    .indexOf(item);
                setState(() {
                  if (addAssetData
                          .itemForm!.form_name!.files![i].multipleValues ==
                      null) {
                    addAssetData.itemForm!.form_name!.files![i].extraform!
                        .files![j].multipleValues = [];
                  }
                  if (value!) {
                    if (!addAssetData
                        .itemForm!.form_name!.files![i].multipleValues!
                        .contains(item)) {
                      addAssetData
                          .itemForm!.form_name!.files![i].multipleValues!
                          .add(item);
                    }
                  } else {
                    addAssetData.itemForm!.form_name!.files![i].extraform!
                        .files![j].multipleValues!
                        .remove(item);
                  }
                  print(addAssetData
                      .itemForm!.form_name!.files![i].multipleValues);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "radio") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var option in addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].option!)
                // Expanded(
                // child:
                ListTile(
                  // contentPadding: const EdgeInsets.all(0),
                  title: Text(option),
                  leading: Radio(
                    value: option!,
                    groupValue: addAssetData.itemForm!.form_name!.files![i]
                        .extraform!.files![j].value,
                    activeColor: Colors.red,
                    // Change the active radio button color here
                    fillColor: MaterialStateProperty.all(Colors.red),
                    // Change the fill color when selected
                    splashRadius: 20,
                    // Change the splash radius when clicked
                    onChanged: (value) {
                      setState(() {
                        addAssetData.itemForm!.form_name!.files![i].extraform!
                            .files![j].value = value;
                      });
                    },
                  ),
                )
              // ),
            ],
          ),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "file--") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData
                    .itemForm!.form_name!.files![i].extraform!.files![j].value),
            onChanged: (s) {},
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "addform--") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
        ] else if (addAssetData
                .itemForm!.form_name!.files![i].extraform!.files![j].type ==
            "auto---") ...[
          _getLabel(
              addAssetData
                  .itemForm!.form_name!.files![i].extraform!.files![j].heading!,
              addAssetData.itemForm!.form_name!.files![i].extraform!.files![j]
                  .isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addAssetData
                    .itemForm!.form_name!.files![i].extraform!.files![j].value),
            onChanged: (s) {},
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration: AppTextDecoration.buildTextFieldDecoration(
                hintText: 'Your Email Id'),
          ),
        ]
      ],
      // Padding(
      //     padding: const EdgeInsets.only(top: 20, bottom: 20),
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: Color(0xff132137),
      //       ),
      //       onPressed: _onSubmitClick,
      //       child: const Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             'Add Asset',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 18,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //           Icon(Icons.arrow_forward_rounded, color: Colors.white),
      //         ],
      //       ),
      //     ))
    ]);
  }

  _getPopupFormFields(StateSetter popup1setState) {
    // Files itemFormFiles  = addLinkAssetData.itemForm!.form_name!.files![0];
    return Column(children: [
      // for (Files itemFormFiles in addLinkAssetData.itemForm!.form_name!.files!)
      //   inputs.forEachIndexed((index, element) {
      for (var i = 0;
          i < addLinkAssetData.itemForm!.form_name!.files!.length;
          i++) ...[
        if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "alphabetical") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addLinkAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {
              addLinkAssetData.itemForm!.form_name!.files![i].value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "numarical") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addLinkAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {
              print("aaaaaaa - ${s}");
              addLinkAssetData.itemForm!.form_name!.files![i].value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "alphanumeric") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addLinkAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {
              print(s);
              addLinkAssetData.itemForm!.form_name!.files![i].value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "date") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addLinkAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {},
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: 'Date'),
            readOnly: true,
            onTap: () {
              _selectDate(context, i, 999);
            },
          ),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "p") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            minLines: 3,
            maxLines: null,
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addLinkAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {
              addLinkAssetData.itemForm!.form_name!.files![i].value = s;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "dropdown") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          Container(
            height: 44,
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSearchBox: true,
                showSelectedItems: true,
                // disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: addLinkAssetData.itemForm!.form_name!.files![i].option!,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Select'),
              ),
              onChanged: (value) {
                addLinkAssetData.itemForm!.form_name!.files![i].value = value;
                // _getAssetForm(value!);
              },
              selectedItem:
                  addLinkAssetData.itemForm!.form_name!.files![i].value,
            ),
          )
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "multipal") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          Container(
            height: 44,
            child: DropdownSearch<String>.multiSelection(
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
                showSelectedItems: true,
                // disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: addLinkAssetData.itemForm!.form_name!.files![i].option!,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    AppTextDecoration.buildTextFieldDecoration(
                        hintText: 'Select'),
              ),
              onChanged: (value) {
                addLinkAssetData.itemForm!.form_name!.files![i].multipleValues =
                    value;
                // _getAssetForm(value!);
              },
              selectedItems: (addLinkAssetData
                          .itemForm!.form_name!.files![i].multipleValues !=
                      null)
                  ? addLinkAssetData
                      .itemForm!.form_name!.files![i].multipleValues!
                  : [],
            ),
          )
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "checkbox") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          for (var item
              in addLinkAssetData.itemForm!.form_name!.files![i].option!)
            CheckboxListTile(
              title: Text(item.toUpperCase()),
              value: (addLinkAssetData
                  .itemForm!.form_name!.files![i].multipleValues!
                  .contains(item)),
              onChanged: (value) {
                var indexOf = addLinkAssetData
                    .itemForm!.form_name!.files![i].option!
                    .indexOf(item);
                setState(() {
                  if (addLinkAssetData
                          .itemForm!.form_name!.files![i].multipleValues ==
                      null) {
                    addLinkAssetData
                        .itemForm!.form_name!.files![i].multipleValues = [];
                  }
                  if (value!) {
                    if (!addLinkAssetData
                        .itemForm!.form_name!.files![i].multipleValues!
                        .contains(item)) {
                      addLinkAssetData
                          .itemForm!.form_name!.files![i].multipleValues!
                          .add(item);
                    }
                  } else {
                    addLinkAssetData
                        .itemForm!.form_name!.files![i].multipleValues!
                        .remove(item);
                  }
                  print(addLinkAssetData
                      .itemForm!.form_name!.files![i].multipleValues);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "radio") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var option
                  in addLinkAssetData.itemForm!.form_name!.files![i].option!)
                // Expanded(
                // child:
                ListTile(
                  // contentPadding: const EdgeInsets.all(0),
                  title: Text(option),
                  leading: Radio(
                    value: option!,
                    groupValue:
                        addLinkAssetData.itemForm!.form_name!.files![i].value,
                    activeColor: Colors.red,
                    // Change the active radio button color here
                    fillColor: MaterialStateProperty.all(Colors.red),
                    // Change the fill color when selected
                    splashRadius: 20,
                    // Change the splash radius when clicked
                    onChanged: (value) {
                      setState(() {
                        addLinkAssetData.itemForm!.form_name!.files![i].value =
                            value;
                      });
                    },
                  ),
                )
              // ),
            ],
          ),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "file--") ...[
          _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          TextField(
            style: TSB.regularVSmall(),
            controller: TextEditingController(
                text: addLinkAssetData.itemForm!.form_name!.files![i].value),
            onChanged: (s) {},
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration:
                AppTextDecoration.buildTextFieldDecoration(hintText: ''),
          ),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "addform22") ...[
          _geHeading(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
              addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
          _getExtraFormFields(
              i, addLinkAssetData.itemForm!.form_name!.files![i].extraform)
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "auto--") ...[
          //  _getLabel(addLinkAssetData.itemForm!.form_name!.files![i].heading!,
          //    addLinkAssetData.itemForm!.form_name!.files![i].isrequerd!),
        ] else if (addLinkAssetData.itemForm!.form_name!.files![i].type ==
            "showitem") ...[
          (linkAssetArrey2 != null && linkAssetArrey2!.isNotEmpty)
              ? _getlinkassetcard2()
              : Container(),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                  child: Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    _showPopup2(popup1setState);
                  },
                  style: OutlinedButton.styleFrom(
                    //<-- SEE HERE
                    side: BorderSide(width: 1.0),
                  ),
                  child: Text(
                      addLinkAssetData.itemForm!.form_name!.files![i].heading!),
                ),
              )))
        ]
      ],

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
          ))
    ]);
  }

  _getPopupFormFields2(StateSetter popup1setState) {
    oldtempitemDropDownList2 = [];
    // oldtempitemDropDownList2.add("");
    for (AddAssetModel tempItems in oldListAsset2!) {
      oldtempitemDropDownList2
          .add("${tempItems.itemName!}(code: ${tempItems.id!})");
    }

    return Column(children: [
      // for (Files itemFormFiles in addLinkAssetData2.itemForm!.form_name!.files!)
      //   inputs.forEachIndexed((index, element) {

      // oldListAsset2

      _getLabel("Select From Saved Assets", "No"),
      (oldListAsset2 != null && oldListAsset2!.isNotEmpty)
          ? Container(
              height: 44,
              child: DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                  showSelectedItems: false,
                  // disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: oldtempitemDropDownList2!,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration:
                      AppTextDecoration.buildTextFieldDecoration(
                          hintText: 'Select'),
                ),
                onChanged: (value) {
                  _selectOldAssect(value!);
                  setState(() {});
                },
                selectedItem: addLinkAssetData2.itemName,
              ))
          : Container(),

      (oldListAsset2 != null && oldListAsset2!.isNotEmpty)
          ? _getLabel("OR Add New", "NO")
          : Container(),

      _getLabel("Asset Name", "Yes"),
      TextField(
        style: TSB.regularVSmall(),
        controller: TextEditingController(text: newAssetlink2name),
        onChanged: (s) {
          newAssetlink2name = s;
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.name,
        decoration: AppTextDecoration.buildTextFieldDecoration(hintText: ''),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff132137),
            ),
            onPressed: () {
              _onSubmitPopu2Click(popup1setState);
            },
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
          ))
    ]);
  }

  _getlinkassetcard2() {
    return Column(children: [
      // for (Files itemFormFiles in addLinkAssetData.itemForm!.form_name!.files!)
      //   inputs.forEachIndexed((index, element) {
      for (var i = 0; i < linkAssetArrey2!.length; i++) ...[
        AspectRatio(
          aspectRatio: 3,
          child: Card(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(
                  //     'https://upload.wikimedia.org/wikipedia/commons/5/54/RowanAtkinsonMar07.jpg',
                  //   ),
                  //   radius: 50.0,
                  // ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Asset Name',
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'code',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Button pushed'),
                        ),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        )
      ]
    ]);
  }

  _showPopup2(StateSetter popup1setState) {
    addLinkAssetData2.item = "";
    addLinkAssetData2.itemName = "";
    addLinkAssetData2.itemForm = null;
    newAssetlink2name = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Link Asset'),
            insetPadding: EdgeInsets.zero,
            // contentPadding: EdgeInsets.zero,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Container(
              width:
                  MediaQuery.of(context).size.width - 150, //double.maxFinite,
              height: MediaQuery.of(context).size.height -
                  300, // Adjust height according to your needs
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future:
                        appController.getAllMyFreeAssetItems(login_user!.id),
                    builder: (context, AsyncSnapshot<GetAssetItems> snapshot) {
                      print(snapshot);
                      // categories = GetStorage().read(Constant.CATEGORIES);
                      if (snapshot.hasData && snapshot.data?.items != null) {
                        itemAssetList2 = snapshot.data?.items!;
                        tempitemDropDownList = [];
                        for (AssetItems tempItems in itemAssetList2!) {
                          tempitemDropDownList2.add(tempItems.item!);
                        }

                        // setState(() {});
                        print(snapshot.data);
                        return Column(
                          children: [
                            _getLabel("Select Asset Item", "No"),
                            Container(
                              height: 44,
                              child: DropdownSearch<String>(
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                  // disabledItemFn: (String s) => s.startsWith('I'),
                                ),
                                items: tempitemDropDownList2!,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: AppTextDecoration
                                      .buildTextFieldDecoration(
                                          hintText: 'Select'),
                                ),
                                onChanged: (value) {
                                  _getLinkAssetForm2(value!);
                                  setState(() {});
                                },
                                selectedItem: addLinkAssetData2.itemName,
                              ),
                            ),
                            (addLinkAssetData2.item != null &&
                                    addLinkAssetData2.item != "" &&
                                    addLinkAssetData2.itemForm != null)
                                ? _getPopupFormFields2(popup1setState)
                                : Container(),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
              // Additional actions can be added here
            ],
          );
        });
      },
    );
    return;
  }

  _showPopup() {
    addLinkAssetData.item = "";
    addLinkAssetData.itemName = "";
    addLinkAssetData.itemForm = null;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Link Asset'),
            insetPadding: EdgeInsets.zero,
            // contentPadding: EdgeInsets.zero,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Container(
              width: MediaQuery.of(context).size.width - 70, //double.maxFinite,
              height: MediaQuery.of(context).size.height -
                  200, // Adjust height according to your needs
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: appController.getAllAssetItems(login_user!.id),
                    builder: (context, AsyncSnapshot<GetAssetItems> snapshot) {
                      print(snapshot);
                      // categories = GetStorage().read(Constant.CATEGORIES);
                      if (snapshot.hasData && snapshot.data?.items != null) {
                        itemAssetList = snapshot.data?.items!;
                        tempitemDropDownList = [];
                        for (AssetItems tempItems in itemAssetList!) {
                          tempitemDropDownList.add(tempItems.item!);
                        }

                        // setState(() {});
                        print(snapshot.data);
                        return Column(
                          children: [
                            _getLabel("Select Asset Item", "No"),
                            Container(
                              height: 44,
                              child: DropdownSearch<String>(
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                  // disabledItemFn: (String s) => s.startsWith('I'),
                                ),
                                items: tempitemDropDownList!,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: AppTextDecoration
                                      .buildTextFieldDecoration(
                                          hintText: 'Select'),
                                ),
                                onChanged: (value) {
                                  _getLinkAssetForm(value!);
                                  setState(() {});
                                },
                                selectedItem: addLinkAssetData.itemName,
                              ),
                            ),
                            (addLinkAssetData.item != null &&
                                    addLinkAssetData.item != "" &&
                                    addLinkAssetData.itemForm != null)
                                ? _getPopupFormFields(setState)
                                : Container(),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
              // Additional actions can be added here
            ],
          );
        });
      },
    );
    return;
  }

  _geHeading(String title, String required) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff666666),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              // style: TSB.boldMedium(textColor: Color(0xff666666)),
              // font
            ),
            (required == "YES")
                ? Text(
                    '*',
                    style: TSB.boldMedium(textColor: Colors.red),
                  )
                : Container(),
            // style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Color(0xff666666)),
          ],
        ));
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

  Future<void> _selectDate(
      BuildContext context, int index, int extraindex) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        if (extraindex != 999) {
          addAssetData.itemForm!.form_name!.files![index].extraform!
              .files![extraindex].value = picked.toString().split(" ")[0];
        } else {
          addAssetData.itemForm!.form_name!.files![index].value =
              picked.toString().split(" ")[0];
        }
      });
    }
  }

  _onSubmitPopu2Click(StateSetter popup1setState) async {
    bool isfalsenew = false;
    // for (Files itemFormFiles in addLinkAssetData2.itemForm!.form_name!.files!) {
    //   if (itemFormFiles.value == "") {
    //     Constant.showToast("Please Enter Valid ${itemFormFiles.heading}");
    //     isfalse = true;
    //     break;
    //   }
    // }

    // if(addLinkAssetData2==null ||
    //     addLinkAssetData2.itemName==null ||
    //     addLinkAssetData2.item==null  ||
    //     addLinkAssetData2.item==""){
    //   isfalsenew=true;
    // }
    //
    //
    // if(newAssetlink2name==""){
    //   isfalsenew=true;
    // }

    if (isfalsenew) {
      Constant.showToast("Please Select A valid Asset");
      return;
    }
    addLinkAssetData2.userid = login_user!.id;
    addLinkAssetData2.app_client_id = login_user!.appClientId;
    addLinkAssetData2.item_form_id = addLinkAssetData2.itemForm!.id;
    addLinkAssetData2.headingName =
        addLinkAssetData2.itemForm!.form_name!.files![0].value;
    linkAssetArrey2?.add(addLinkAssetData2);

    popup1setState(() {});
    Navigator.of(context).pop();
  }

  _onSubmitClick() async {
    bool isfalse = false;
    for (Files itemFormFiles in addAssetData.itemForm!.form_name!.files!) {
      if (itemFormFiles.value == "") {
        Constant.showToast("Please Enter Valid ${itemFormFiles.heading}");
        isfalse = true;
        break;
      }
    }
    if (isfalse) {
      return;
    }
    addAssetData.userid = login_user!.id;
    addAssetData.app_client_id = login_user!.appClientId;
    addAssetData.item_form_id = addAssetData.itemForm!.id;
    addAssetData.headingName =
        addAssetData.itemForm!.form_name!.files![0].value;

    Dialogs.showLoadingDialog(context, _keyLoader);
    AddAssetResponse assetResponse = await appController.addAsset(addAssetData);
    if (assetResponse.success!) {
      Constant.showToast("Asset Added Successfully");

      Navigator.of(context, rootNavigator: true).pop();

      // Get.to(OrderConfirm());
      Get.offAll(HomeBottomMenu());
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

  void _showPicker(context, AddAssetModel addAssetData, int i , int type) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        imgFromGallery(addAssetData,i,type);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imgFromCamera(addAssetData,i,type);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  imgFromCamera(AddAssetModel addAssetData, int i , int type) async {
    try {
      final pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 10,
          maxWidth: 480,
          maxHeight: 600);

      if (pickedFile != null) {
        setState(() {
          var image = File(pickedFile.path);
          var imageBase64 = getConvertIntoBase64(pickedFile.path);
          // loginResponse!.image = getConvertIntoBase64(pickedFile.path);
          List<String> pieces = pickedFile.path.split("/");
          String last = pieces[pieces.length - 1];
          updateimage(imageBase64,i,type);
          // loginResponse!.image = "sourabh:image/"+last+";base64,"+getConvertIntoBase64(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  imgFromGallery(AddAssetModel addAssetData, int i , int type) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      setState(() {
        var image = File(pickedFile.path);
        var imageBase64 = getConvertIntoBase64(pickedFile.path);

        List<String> pieces = pickedFile.path.split("/");
        String last = pieces[pieces.length - 1];
        updateimage(imageBase64,i,type);
        // loginResponse!.image = "sourabh:image/"+last+";base64,"+getConvertIntoBase64(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  updateimage(var imageBase64,int i , int type){
    setState(() {
    if(type==1){
      addAssetData
          .itemForm!.form_name!.files![i].value=imageBase64;
    }
    });
  }

  String getConvertIntoBase64(String path) {
    final bytes = File(path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }



  void hideKeyboard(BuildContext context) {}
}

class Base64ImageWidget extends StatelessWidget {
  final String base64String;

  Base64ImageWidget(this.base64String);

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64.decode(base64String);
    return Image.memory(bytes);
  }
}