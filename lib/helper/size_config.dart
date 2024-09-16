import 'package:flutter/widgets.dart';

//This class is used to provide dimensions (eg. margins, padding, width & height) to our app, which are sized as
//per different screen resolutions
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth, screenWidthActual;
  static late double screenHeight, screenHeightActual;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double textSizeVerySmall, textSizeSmall, textSizeMedium, textSizeLarge, textSizeHeading, textSizeXLarge;
  static late double margin_padding_20, margin_padding_10, margin_padding_5, margin_padding_2, margin_padding_3, margin_padding_37,
      margin_padding_35, margin_padding_15, margin_padding_29, margin_padding_40, devicePixelRatio, margin_padding_16, margin_padding_17, margin_padding_18,
      margin_padding_70, separatorWidth, strokeWidth, inputBorderRadius, margin_padding_85, margin_padding_50,
      margin_padding_65, margin_padding_28, margin_padding_4, margin_padding_24, margin_padding_13, margin_padding_100, margin_padding_8, margin_padding_14;
  static late double mapMarkerSize, googleMapPaddingTop, googleMapPaddingLeft;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    screenHeightActual = screenHeight - _safeAreaVertical;
    screenWidthActual = screenWidth - _safeAreaHorizontal;

    textSizeVerySmall = safeBlockHorizontal * 3.25; //for 12 pixel text-size
    textSizeSmall = safeBlockHorizontal * 4; //for 14 pixel text-size
    textSizeMedium = safeBlockHorizontal * 4.5; //for 16 pixel text-size
    textSizeLarge = safeBlockHorizontal * 5; //for 18 pixel text-size
    textSizeXLarge = safeBlockHorizontal * 6; //for 20 pixel text-size
    textSizeHeading = safeBlockHorizontal * 6.5; //for 24 pixel text-size

    separatorWidth = safeBlockHorizontal * 0.25; //approx 1 pixel
    strokeWidth = safeBlockHorizontal * 0.5; //approx 1.5 pixel
    inputBorderRadius = safeBlockHorizontal * 1.5; //approx 5 pixel
    margin_padding_4 = safeBlockHorizontal * 1; //approx 5 pixel
    margin_padding_8 = safeBlockHorizontal * 2; //approx 8 pixel
    margin_padding_5 = safeBlockHorizontal * 1.5; //approx 5 pixel
    margin_padding_10 = safeBlockHorizontal * 3; //approx 10 pixel
    margin_padding_13 = safeBlockHorizontal * 3.5; //approx 13 pixel
    margin_padding_14 = safeBlockHorizontal * 3.75; //approx 13 pixel
    margin_padding_15 = safeBlockHorizontal * 4; //approx 15 pixel
    margin_padding_16 = safeBlockHorizontal * 4.5; //approx 16 pixel
    margin_padding_17 = safeBlockHorizontal * 4.8; //approx 17 pixel
    margin_padding_18 = safeBlockHorizontal * 5; //approx 18 pixel
    margin_padding_20 = safeBlockHorizontal * 6; //approx 20 pixel
    margin_padding_24 = safeBlockHorizontal * 6.5; //approx 24 pixel
    margin_padding_29 = safeBlockHorizontal * 8; //approx 29 pixel
    margin_padding_35 = safeBlockHorizontal * 10; //approx 35 pixel
    margin_padding_40 = safeBlockHorizontal * 11; //approx 40 pixel
    margin_padding_70 = safeBlockHorizontal * 19.5; //approx 70 pixel
    margin_padding_85 = safeBlockHorizontal * 23.5; //approx 85 pixel
    margin_padding_50 = safeBlockHorizontal * 14; //approx 50 pixel
    margin_padding_65 = safeBlockHorizontal * 18; //approx 65 pixel
    margin_padding_28 = safeBlockHorizontal * 8; //approx 28 pixel
    margin_padding_2 = safeBlockHorizontal * 0.5; //approx 2 pixel
    margin_padding_37 = safeBlockHorizontal * 9;
    margin_padding_3 = margin_padding_2 + safeBlockHorizontal * 0.25;
    margin_padding_100 = margin_padding_50 + margin_padding_50;

    mapMarkerSize = safeBlockHorizontal * 7; //approx 25 pixel

    googleMapPaddingTop = safeBlockVertical * 37;
    googleMapPaddingLeft = margin_padding_10;
  }

  static double get(double val) => safeBlockHorizontal * val;
}