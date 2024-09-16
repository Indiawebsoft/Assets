import 'package:flutter/material.dart';
import 'package:asset_management/helper/constant.dart';

class GenderRadio extends StatelessWidget {
  final bool selected;
  final String title;
  final IconData icon;
  final Function (String v) onClicked;


  GenderRadio({required this.selected, required this.title, required this.icon, required this.onClicked});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onClicked(title),
      child: Container(
        height: 90,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 1,
                color: selected
                    ? Constant.hexToColor(Constant.primaryBlue)
                    : Colors.grey)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 45,
                color: selected
                    ? Constant.hexToColor(Constant.primaryBlue)
                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 12,
                      color: selected
                          ? Constant.hexToColor(Constant.primaryBlue)
                          : Colors.grey),
                ))
          ],
        ),
      ),
    );
  }
}
