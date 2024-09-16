import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:asset_management/helper/ap_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

// import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWebView extends StatefulWidget {
  // final LabModel labModel;

  int typewebview;
  String orderid="";
  String userid="";
  String path="";
  AppWebView({required this.typewebview,this.orderid="",this.userid="",this.path=""});

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {

String url="";
String headingname="";
//GetStorage().read(Constant.USERID);
  @override
  void initState() {
    getPrefs();
    if(widget.typewebview==1){
      headingname="About Us";
      url=ApiConstant.HOST_URL+"terms_and_conditions.php";
    }else if(widget.typewebview==2){
      headingname="Privacy Policy";
      url=ApiConstant.HOST_URL+"privacy_policy.php";
    }else if(widget.typewebview==3){
      headingname="Terms & Conditions";
      url=ApiConstant.HOST_URL+"terms_and_conditions.php";
    }else if(widget.typewebview==4){
      //view report
      headingname="View Report";
      url="${ApiConstant.HOST_URL}vendor/${widget.path}";
      // https://docs.google.com/gview?embedded=true&url=
      // print(url);
      // url=ApiConstant.HOST_URL+"admin/viewtestreport.php?orderid="+widget.orderid+"&userid="+widget.userid;
      print(url);
    }
    super.initState();

    // userid=GetStorage().read(Constant.USERID);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(
            color: Colors.white,
          ),
        ),
        actions: [
          Container()
        ],
        title: Text(
          headingname,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            widget.typewebview==4? PDF(
              swipeHorizontal: false,
            ).cachedFromUrl(url) :WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              // onPageFinished: (s) => model.updateLoadingWebView(false),
              // onWebViewCreated: (WebViewController webViewController) {
              //   _controller.complete(webViewController);
              // },
            ),
            // model.loadingWebView ? _loadingView() : Stack()
          ],
        ),
      ),
    );
  }

Future<String?> getPrefs() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  setState(() {
    // userid = sharedPreferences.getString(Constant.USERID) == null
    //     ? "1"
    //     : sharedPreferences.getString(Constant.USERID)!;
    // print("ssssssssssss-${userid}");
  });

  return "";
}
}
