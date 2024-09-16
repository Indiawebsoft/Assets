import 'package:flutter/material.dart';
import 'package:asset_management/helper/constant.dart';

class SearchBar extends StatelessWidget {


  Function(String text) searchText;

  SearchBar(this.searchText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              width: 1, color: Constant.hexToColor(Constant.primaryBlue))),
      child: TextField(
        onChanged: (v)=>searchText(v),

          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),

              border: UnderlineInputBorder(borderSide: BorderSide.none),
            hintStyle: TextStyle(fontSize: 12),
              hintText: "   Search for Tests, Health Packages",
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 25,width: 25,
                  decoration: BoxDecoration(
                      color: Constant.hexToColor(Constant.primaryBlueMin),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(

                    Icons.search,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              )),
        ),

    );
  }
}
