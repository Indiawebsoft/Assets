import 'package:asset_management/helper/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:asset_management/app_theme.dart';


class AppTextDecoration {

  static final _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: AppTheme.textColor),
  );


  static InputDecoration buildTextFieldDecoration({required String hintText,
    String? labelText}) {
    return InputDecoration(
      isDense: true,
      border: _inputBorder,
      enabledBorder: _inputBorder,
      disabledBorder: _inputBorder,
      errorBorder: _inputBorder,
      focusedBorder: _inputBorder,
      focusedErrorBorder: _inputBorder,
      fillColor: AppTheme.white,
      filled: true,
      // contentPadding: EdgeInsets.all(8),
contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      hintStyle: TSB.regularSmall(textColor: AppTheme.grey),
      hintText: hintText,
      labelText: labelText,
      // Add other common styling properties here
    );
  }

}