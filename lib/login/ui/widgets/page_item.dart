import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:asset_management/helper/ap_constant.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:asset_management/login/repository/model/splash_response.dart';

class PageItem extends StatelessWidget {
  final SplashData splashData;
  final double height;
  PageItem(this.splashData,this.height );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.network(splashData.img!, height: height*.2, fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
          if(loadingProgress==null)
            return child;
            return Center(child: Image.asset("images/logo.png",height:height*.2,width: 90,));


        }),
        Container(
          margin: EdgeInsets.only(top: 24),
          child: Text(
            "${splashData.heading}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Constant.hexToColor(Constant.primaryBlueMin),
                fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          child: Text(
            "${splashData.subheading}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 16),
          ),
        )
      ]),
    );
  }
}
