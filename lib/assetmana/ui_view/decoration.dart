import 'package:asset_management/app_theme.dart';
import 'package:asset_management/helper/widgets/text_styles.dart';
import 'package:flutter/material.dart';
// import 'package:careuwell/ui/common/text_styles.dart';

// import 'colors.dart';

var containerDecoration1 = BoxDecoration(
    color: AppTheme.white,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    border: Border.all(color: AppTheme.white, width: 0));

var textFieldDecoration1 = InputDecoration(
  border: InputBorder.none,
  counterText: '',
  contentPadding: EdgeInsets.all(10),
);

var textFieldDecoration2 = InputDecoration(
  border: _inputBorder,
  enabledBorder: _inputBorder,
  disabledBorder: _inputBorder,
  errorBorder: _inputBorder,
  focusedBorder: _inputBorder,
  focusedErrorBorder: _inputBorder,
  fillColor: AppTheme.darkerText,
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: AppTheme.grey),
);

var _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: AppTheme.darkerText));


var textFieldDecoration3 = InputDecoration(
  border: _inputBorder3,
  enabledBorder: _inputBorder3,
  disabledBorder: _inputBorder3,
  errorBorder: _inputBorder3,
  focusedBorder: _inputBorder3,
  focusedErrorBorder: _inputBorder3,
  fillColor: AppTheme.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: AppTheme.grey),
);

var _inputBorder3 = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: BorderSide(color: AppTheme.textColor),
);

var textFieldDecorationHomeSearch = InputDecoration(
  border: _inputSearchBorder,
  enabledBorder: _inputSearchBorder,
  disabledBorder: _inputSearchBorder,
  errorBorder: _inputSearchBorder,
  focusedBorder: _inputSearchBorder,
  focusedErrorBorder: _inputSearchBorder,
  fillColor: AppTheme.darkerText,
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: AppTheme.grey),
);

var _inputSearchBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: BorderSide(color: AppTheme.darkerText),
);

var textFieldDecorationAmount = InputDecoration(
  border: _inputSearchBorder,
  enabledBorder: _inputSearchBorder,
  disabledBorder: _inputSearchBorder,
  errorBorder: _inputSearchBorder,
  focusedBorder: _inputSearchBorder,
  focusedErrorBorder: _inputSearchBorder,
  fillColor: AppTheme.darkerText,
  filled: true,
  prefixIcon: Icon(
    Icons.attach_money,
    color: AppTheme.black_text_color,
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: AppTheme.grey),
);

var textFieldDecorationAddCard = InputDecoration(
  border: _inputAddCard,
  enabledBorder: _inputAddCard,
  disabledBorder: _inputAddCard,
  errorBorder: _inputAddCard,
  focusedBorder: _inputAddCard,
  focusedErrorBorder: _inputAddCard,
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: AppTheme.grey),
);

var _inputAddCard = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
  borderSide: BorderSide(color: AppTheme.cart_item_border_color, width: 1.0),
);
