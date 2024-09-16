import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_theme.dart';
import '../../cart/ui/rokenmodel.dart';
import '../../dashboard/repository/dashboard_controller.dart';
import '../../helper/constant.dart';
import '../../helper/widgets/Dialogs.dart';
import '../../helper/widgets/text_styles.dart';
import '../controllers/app_controller.dart';
import '../data/local/app_shared_prefs.dart';
import '../data/local/preference_keys.dart';
import '../qr_code.dart';
import '../ui_view/text_decoration.dart';
import 'add_link_asset.dart';
import 'add_new_asset.dart';
import 'add_new_asset_new.dart';
import 'model/add_asset_model.dart';
import 'model/add_asset_response.dart';
import 'model/get_asset_items.dart';
import 'model/my_asset_model.dart';

class ViewMyAsset extends StatefulWidget {
  AddAssetModel addAssetModel;
  AddAssetModel? parentAsset;
  String pagetype;
  ViewMyAsset(this.addAssetModel, this.parentAsset,this.pagetype, {super.key});
  // TestDetail({required this.data, this.refresh});
  @override
  State<ViewMyAsset> createState() => _ViewMyAssetState();
}

class _ViewMyAssetState extends State<ViewMyAsset> {
  final appController = Get.put(AppController());
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<AddAssetModel> myAllAssetList=[];
  final pageController = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  DashboardController dashboardController = Get.find();
  String userlocaton = "";
  LoginData? login_user; //= LoginData();
  List<AddAssetModel> myLinkassetlist=[];

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text((widget.pagetype=="Link")? "View Link Asset":"View Asset"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit',
              onPressed: () {

                // (widget.pagetype=="Link")?  Get.to(
                //     AddLinkAsset(widget.addAssetModel,"yes")): Get.to(
                //     // AddNewAsset(appController.selectedCategory,widget.addAssetModel));
                //     AddNewAssetNew(appController.selectedCategory,null,null,widget.addAssetModel));
                _getAllItems();
              },
            ),
          ],
        ),
        // drawer: AppDrawer(),
        key: _key,
        body: FutureBuilder(
            future: _getLoginUser(),
            builder: (context, AsyncSnapshot<LoginData?> loginData) {
              login_user = loginData.data!;
              return FutureBuilder(
                  future: appController.getMyLinkAsset(
                      login_user!.id, widget.addAssetModel.id),
                  builder: (context, AsyncSnapshot<GetMyAsset> snapshot) {
                    // categories = GetStorage().read(Constant.CATEGORIES);
                    if (snapshot.hasData && snapshot.data?.assets != null) {
    myLinkassetlist=snapshot.data!.assets!;

                    }
                      print(snapshot.data);
                      return Container(
                          margin: EdgeInsets.all(2),
                          child: _buildCard());
                    // } else {
                    //   return const Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                  });
            }));
  }



  //
  // @override
  // Widget build(BuildContext context) {
  //
  //   return  Container(
  //       color: AppTheme.background,
  //       child: Scaffold(
  //       appBar: AppBar(
  //       title: Text("View Asset"),
  //   centerTitle: false,
  //   ),
  //           key: _key,
  //           body: FutureBuilder(
  //               future: _getLoginUser(),
  //               builder: (context, AsyncSnapshot<LoginData?> loginData) {
  //                 login_user = loginData.data!;
  //                 return FutureBuilder(
  //       future: appController.getMyLinkAsset(
  //           login_user!.id, widget.addAssetModel.id),
  //       builder: (context, AsyncSnapshot<GetMyAsset> snapshot) {
  //         // categories = GetStorage().read(Constant.CATEGORIES);
  //         if (snapshot.hasData && snapshot.data?.assets != null) {
  //           print(snapshot.data);
  //           if(snapshot.data!.assets!=null){
  //         myLinkassetlist=snapshot.data!.assets!;
  //         }
  //           return Container(
  //               margin: EdgeInsets.all(12),
  //               child: _buildCard());
  //         } else {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       })
  //       )
  //               }));
  //   );
  // }
_buildCard(){
  return Container(
        margin: EdgeInsets.all(12),
        // child: Card(
        //   elevation: 10,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(18),
        //   ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child:  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ), child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Asset Code: #${widget.addAssetModel.id}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 3,right: 5),
                              child:   Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Container(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: OutlinedButton(
                                          onPressed: (){
                                            Get.to(
                                                QRCodeScreen(widget.addAssetModel.id!));
                                          },//_showPopup,
                                          style: OutlinedButton.styleFrom(
                                            //<-- SEE HERE
                                            side: BorderSide(width: 1.0),
                                          ),
                                          child: Text("View Qr Code"),
                                        ),
                                      ))) ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      //  height: MediaQuery.of(context).size.height * .45,

                        margin: EdgeInsets.all(12),
                        child: _getAssetDataNew()),
                  ],
                )
                ),
              ),
              (widget.addAssetModel.add_button=="showitem") ?
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12, top: 12),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Link Assets",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                        // Container(
                        //     margin: EdgeInsets.only(top: 3,right: 5),
                        //     child:   Padding(
                        //         padding: const EdgeInsets.only(top: 1),
                        //         child: Container(
                        //             child: Align(
                        //               alignment: Alignment.centerRight,
                        //               child: OutlinedButton(
                        //                 onPressed: (){
                        //                   // Get.to(
                        //                   //     AddLinkAsset(myassetlist[index]));
                        //                 },//_showPopup,
                        //                 style: OutlinedButton.styleFrom(
                        //                   //<-- SEE HERE
                        //                   side: BorderSide(width: 1.0),
                        //                 ),
                        //                 child: Text("View Qr Code"),
                        //               ),
                        //             ))) ),
                        // SizedBox(
                        //   width: 8,
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    //  height: MediaQuery.of(context).size.height * .45,

                    margin: EdgeInsets.all(12),
                    child: _buildLinkedAssetList(myLinkassetlist)
                  ),
                ],
              ) :Container()
            ],
          ),
        ),
        // ),
      );
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
          // for (Files itemFormFiles in widget.addAssetModel.itemForm!.form_name!.files!)
          //   inputs.forEachIndexed((index, element) {
          for (var i = 0;
              i < widget.addAssetModel.itemForm!.form_name!.files!.length;
              i++) ...[
            if (widget.addAssetModel.itemForm!.form_name!.files![i].type ==
                "alphabetical") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),

                // Text(widget.addAssetModel.itemForm!.form_name!.files![i].heading!),
                // Text(widget.addAssetModel.itemForm!.form_name!.files![i].heading!),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "numarical") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                  widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "alphanumeric") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                  widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "date") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                  widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "p") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                  widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "dropdown") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                  widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "multipal") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                  widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "checkbox") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                  widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "radio") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text((widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!=null)?
                  widget
                      .addAssetModel.itemForm!.form_name!.files![i].value!:"",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "file") ...[
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text(
                    widget
                        .addAssetModel.itemForm!.form_name!.files![i].heading!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child:  widget
                          .addAssetModel
                          .itemForm!.form_name!.files![i].value!= null
                          ? Center(
                          child: Container(
                              height: 100,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Base64ImageWidget(widget
                                  .addAssetModel
                                  .itemForm!.form_name!.files![i].value!)))
                          : Container()
                  ),
                ),
                // Text('Author'),
              ]),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "addform")
              ...[]
            else if (widget.addAssetModel.itemForm!.form_name!.files![i].type ==
                "auto--") ...[
              //  _getLabel(widget.addAssetModel.itemForm!.form_name!.files![i].heading!,
              //    widget.addAssetModel.itemForm!.form_name!.files![i].isrequerd!),
            ] else if (widget
                    .addAssetModel.itemForm!.form_name!.files![i].type ==
                "showitem")
              ...[]
          ],
        ]);
  }

  Widget _buildLinkedAssetList(List<AddAssetModel> myassetlist) {
    myAllAssetList=myassetlist;
    if (myassetlist.isNotEmpty) {
      return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (c, index) {
      return  Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
              color: Colors.white,
              elevation: 1,
              //   shadowColor: Colors.blue,
              child:  ListTile(
                onTap: () {
                  // print(category);
                  // Constant.showToast("Yes");

                  Get.to(
                      ViewMyAsset(myassetlist[index],widget.addAssetModel,"Link"),preventDuplicates: false);
                },
                leading: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[ CircleAvatar(
                      backgroundImage: AssetImage('images/gall.png'),
                    )]),
                title: Text(myassetlist[index].headingName,style: AppTheme.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${myassetlist[index].categoryName}, ${myassetlist[index].subCategoryName}",
                      style: AppTheme.subtitle,
                    ),
                    Text("${myassetlist[index].itemName}",
                        style: AppTheme.subtitle),
                    Text("Addedon - ${myassetlist[index].addedon}",style: AppTheme.body1),
                    (myassetlist[index].add_button=="showitem") ?
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: OutlinedButton(
                                onPressed: (){
                                  Get.to(
                                      AddLinkAsset(myassetlist[index],""));
                                },//_showPopup,
                                style: OutlinedButton.styleFrom(
                                  //<-- SEE HERE
                                  side: BorderSide(width: 1.0),
                                ),
                                child: Text("Link More Assets"),
                              ),
                            ))): Container(),
                    const SizedBox(width: 10), // Add some space between the buttons
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                  children: [ OutlinedButton(
                      onPressed: () {
                        Get.to(
                            unlinkDialog(context,login_user!.id,myassetlist[index]));
                      }, //_showPopup,
                      style: OutlinedButton.styleFrom(
                        //<-- SEE HERE
                        side: BorderSide(width: 1.0),

                      ),
                      child: const Text("Unkink Assets",style: TextStyle(fontSize: 12)),
                    )]),

                  ],
                ),
                //Text("${myassetlist[index].categoryName}, ${myassetlist[index].subCategoryName}"),
                trailing: Container(
                  // margin: const EdgeInsets.only(top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
              ) ));

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


  unlinkDialog(BuildContext context, String userid, AddAssetModel myassetlist) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true)
            .pop(false); //
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Unlink Asset"),
      onPressed:  () {
        unlinkAsset(userid,myassetlist);
       // Navigator.of(context, rootNavigator: true).pop(true); //
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Unlink Asset"),
      content: const Text("Are you sure want to unlink this asset?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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

  _getAllItems()  async {
    AssetItems? tempItemssss;
    List<AssetItems> tempeditItems=[];
    Dialogs.showLoadingDialog(context, _keyLoader);
    GetAssetItems response =
    await appController.getAssetByCategory(login_user!.id,
        widget.addAssetModel.category, "0");
    print("resooo- ${response}");
    if (response.success! && response.items != null) {

      tempeditItems=response.items!;
      // itemlist = response.items!;
      // itemDropDownList = [];
      for (AssetItems tempItems in response.items!) {
        print("${tempItems.id}==${widget.addAssetModel.item}");
        if(tempItems.id==widget.addAssetModel.item){
          tempItemssss=tempItems;
          break;
        }else{
          print("else");
        }
        // itemDropDownList.add(tempItems.item!);
      }
      Navigator.of(context, rootNavigator: true).pop();

      (widget.pagetype=="Link")?  Get.to(
          AddLinkAsset(widget.addAssetModel,"yes")): Get.to(
          AddNewAssetNew(appController.selectedCategory,tempeditItems,tempItemssss,widget.addAssetModel));
      // setState(() {});

    }
  }

  void unlinkAsset(String userid, AddAssetModel myassetlist) async {

    Dialogs.showLoadingDialog(context, _keyLoader);
    AddAssetResponse assetResponse = await appController.unlinkAsset(userid,myassetlist.id);
    if (assetResponse.success!) {
      Constant.showToast("Unlink Asset Added Successfully");

      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {});
      // Navigator.of(context, rootNavigator: true).pop(true);
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


// Widget buildTopUi(double size, Size width, BuildContext context) {
//   return Container(
//     child: Stack(
//       children: [
//         Image.asset(
//           "images/lab_1.jpg",
//           scale: 2,
//           width: width.width,
//         ),
//         Container(
//             margin: EdgeInsets.all(4),
//             child: IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.blueGrey,
//                   size: 15,
//                 ))),
//         // Positioned(
//         //     bottom: 0,
//         //     child: Container(
//         //         height: size * .2, width: width.width, child: BottomBar()))
//       ],
//     ),
//   );
// }
//
//
// Widget buildProductSummaryNew() {
//   return SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(),
//                   height: 340,
//                   child:Image.asset("images/lab_1.jpg")
//                   // child: buildProductPages(),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 8, bottom: 12, right: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Icon(Icons.medical_services_outlined,color: Constant.hexToColor(Constant.primaryBlue),)
//                       ,
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(top: 8),
//                             child: Text(
//                              "Diabetes Test",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.w600),
//                               textAlign: TextAlign.start,
//                             ),
//                           ),
//
//
//                           Container(
//                             margin: EdgeInsets.only(top: 12),
//                             child: Row(
//                               children: [
//                                 Text("Status "),
//                                 Text("Pending",style: TextStyle(color: Colors.redAccent,
//                                     fontWeight: FontWeight.bold),)
//                               ],
//                             ),
//                           ),
//
//
//                           Container(
//                             margin: EdgeInsets.only(top: 12),
//                             child: Text("Free diabetes test for all"),
//                           ),
//
//                           Container(
//                             margin: EdgeInsets.only(top: 12),
//                             child: Text("Free insulin for concerned"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//           ],
//         ),
//
//       ],
//     ),
//   );
// }

// Widget buildPriceAndProceed() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Row(
//         children: [
//           Container(
//             margin: EdgeInsets.only(left: 12),
//             child: Text(
//               labModel.discountPrice,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 6),
//             child: Text(
//               labModel.regularPrice,
//               style: TextStyle(fontSize: 20, decoration: TextDecoration.lineThrough),
//             ),
//           ),
//         ],
//       ),
//
//
//       // InkWell(
//       //   onTap: (){
//       //     Get.to(CartList(labModel));
//       //   },
//       //   child: Container(
//       //     margin: EdgeInsets.only(right: 12),
//       //     height: 45,
//       //     width: 150,
//       //     decoration: BoxDecoration(
//       //         borderRadius: BorderRadius.circular(25),
//       //         color: Colors.deepOrangeAccent),
//       //     child: Center(
//       //       child: Text(
//       //         "Add to Cart",
//       //         style:
//       //             TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//       //       ),
//       //     ),
//       //   ),
//       // )
//     ],
//   );
// }

// Widget buildProductPages() {
//   return Container(
//     child: Column(
//       children: [
//         Stack(
//           children: [
//             Container(
//               height: 320,
//               child: PageView.builder(
//                 controller: pageController,
//                 itemBuilder: (c, index) {
//                   return Image.asset(
//                     labModel.image,
//                     fit: BoxFit.cover,
//                   );
//                 },
//                 itemCount: 4,
//               ),
//             ),
//             // Positioned(
//             //     top: 0,
//             //     right: 0,
//             //     child: Container(
//             //         margin: EdgeInsets.all(8),
//             //         child: Icon(
//             //           Icons.favorite,
//             //           color: Colors.redAccent,
//             //         )))
//           ],
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 8),
//           height: 4,
//           child: SmoothPageIndicator(
//               controller: pageController, // PageController
//               count: 1,
//               effect: SlideEffect(
//                   dotHeight: 8,
//                   dotWidth: 8,
//                   dotColor: Colors.grey,
//                   activeDotColor: Constant.hexToColor(Constant.primaryBlue)),
//               onDotClicked: (index) {
//
//
//
//               }),
//         ),
//       ],
//     ),
//   );
// }
}
