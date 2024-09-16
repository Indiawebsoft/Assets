import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant {

  static String primaryBlue="#10529E";
  static String primaryBlueMin="#10529F";
  static String primaryRed="#E21D26";
  static String lightGrey="#F9F9F9";
  static String lightGreen="#E9FF3";

  static String SPLASHDATA="splash_data";

  static String USERID="userID";
  static bool USERLOGGEDIN=false;
  static String USER_DATA="";





  //old app
  static String welcomescreen="welcomescreen";
  static bool iswelcomescreen=false;

  static String userlat="";
  static String userlng="";
  static String useraddress="";



  static String items="items";
  static String minimumAmountValue="minimumAmountValue";

  static String Order="orderrr";

  static String PROFILE="profile";

  static String CATEGORIES="categoriessss";
  static String PACKAGES="packages";
  static String ALLCITES="allcity";

  static String TESTS="testsssss";
  static String ALLTESTS="alltestsssss";

  static String SCREEN="screens";
  static String CASHFREE_APP_ID="1955857e2663d536fae5e0824a585591";//live
  // static String CASHFREE_APP_ID="146500edc00267a71948a3f6c0005641";//test
  static String CASHFREE_APP_MODE= "PROD";//"TEST";//PROD



  static Color hexToColor(String code) {
    return new  Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }


  static void showToast(String s) {

    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );


  }



  // showLoading() => dialogService().showCustomDialog(customData: DialogType.Loading,);




}