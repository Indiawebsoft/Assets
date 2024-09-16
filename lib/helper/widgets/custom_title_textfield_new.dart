import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant.dart';

class CustomTitleTextfieldNew extends StatelessWidget {
  final String title;
  final Function(String val) onTextChanged;
  final String labelTitle;
  final String value;
  CustomTitleTextfieldNew(this.title, this.labelTitle,this.onTextChanged,this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: TextField(
            // controller: TextEditingController(text: value),
            keyboardType: isNumeric(title)?TextInputType.number:TextInputType.text,
            inputFormatters: [

            isNumeric(title)?LengthLimitingTextInputFormatter(10):LengthLimitingTextInputFormatter(2500)
            ],
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 4, left: 12),
                // labelText: labelTitle,

                hintText: labelTitle,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Constant.hexToColor(Constant.primaryBlueMin), width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Constant.hexToColor(Constant.primaryBlueMin), width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                filled: true,
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontFamily: "Montserrat"),
                hintStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontFamily: "Montserrat")),
            onChanged: onTextChanged,
          ),
        ),
        SizedBox(
          height: 12,
        )
      ],
    );
  }


  bool isNumeric(String s) {
    //   if(s == null) {
    //     return false;
    //   }
    //   return double.parse(s, (e) => 0) != null;
    // }

    if (s == null || s.isEmpty) {
      return false;
    }

    // Try to parse input string to number.
    // Both integer and double work.
    // Use int.tryParse if you want to check integer only.
    // Use double.tryParse if you want to check double only.
    final number = num.tryParse(s);

    if (number == null) {
      return false;
    }

    return true;
  }
}
