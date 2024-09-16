import 'package:flutter/material.dart';
import 'package:asset_management/helper/constant.dart';

class CartProgressUI extends StatelessWidget {
  final int stepsCount;

  CartProgressUI(this.stepsCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 48,right: 48),
      child: Row(
        children: [
          stepsCount==1||stepsCount==2||stepsCount==3||stepsCount==4?buildCircleBlue():buildCircleGrey(),
           Expanded(child: Container(height: 1,color: stepsCount==1||stepsCount==2||stepsCount==3?Constant.hexToColor(Constant.primaryBlue):Colors.grey,)),
           stepsCount==2||stepsCount==3||stepsCount==4?buildCircleBlue():buildCircleGrey(),
           Expanded(child: Container(height: 1,color: stepsCount==2||stepsCount==3?Constant.hexToColor(Constant.primaryBlue):Colors.grey,)),
          stepsCount==3||stepsCount==4? buildCircleBlue():buildCircleGrey(),
          Expanded(child: Container(height: 1,color: stepsCount==2||stepsCount==3||stepsCount==4?Constant.hexToColor(Constant.primaryBlue):Colors.grey,)),
          stepsCount==4? buildCircleBlue():buildCircleGrey(),
        ],
      ),
    );
  }
  
  Widget buildCircleBlue(){
    return Container(
      width: 50,height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Constant.hexToColor(Constant.primaryBlue)),
      child: Center(
        child: Container(
          width: 4,height: 4,

          decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
      ),
    );
  }
  Widget buildCircleGrey(){
    return Container(
      width: 50,height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey),
      child: Center(
        child: Container(
          width: 4,height: 4,
          decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
      ),
    );
  }

}
