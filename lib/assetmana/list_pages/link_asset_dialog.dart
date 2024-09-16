import 'dart:io';
import 'package:asset_management/app_theme.dart';
import 'package:asset_management/assetmana/controllers/app_controller.dart';
import 'package:asset_management/assetmana/list_pages/model/add_asset_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/ui/rokenmodel.dart';

class LinkAssetDialog extends StatefulWidget {

  @override
  State<LinkAssetDialog> createState() => _LinkAssetDialogState();
}

class _LinkAssetDialogState extends State<LinkAssetDialog> {
  AppController appController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin:  const EdgeInsets.all(12),
        // // padding: const EdgeInsets.all(3.0),
        // decoration: BoxDecoration(
        //     border: Border.all(color: Colors.blueAccent)
        // ),
        // color: Colors.transparent,
        child: Scaffold(
          // margin:  const EdgeInsets.all(12),
          // backgroundColor: Colors.white.withOpacity(0), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
//          backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             centerTitle: false,
//             backgroundColor: Colors.black,
//             title: const Text(
//               "Add Asset",
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             // Text("Complete Profile"),
//           ),
          body: Container(
            margin: EdgeInsets.all(12), child: Column(children: [
            Container(
              height: 160.0,
              child: Stack(
                children: <Widget>[

                  Positioned(
                    top: 80.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.0),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5), width: 1.0),
                            color: Colors.white),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                print("your menu action here");
                               // _scaffoldKey.currentState.openDrawer();
                              },
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                print("your menu action here");
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                print("your menu action here");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

              Text('tetsjvgac'),
              Padding(
          padding: const EdgeInsets.only(top: 10),
            child:
            Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child:  OutlinedButton(
                    onPressed: _onSubmitClick,
                    style: OutlinedButton.styleFrom( //<-- SEE HERE
                      side: BorderSide(width: 1.0),
                    ),
                    child: Text('Submit'),
                  ),
                )) )
              ])),
        ));
  }
  _onSubmitClick(){
    Navigator.of(context, rootNavigator: true).pop();
  }
}