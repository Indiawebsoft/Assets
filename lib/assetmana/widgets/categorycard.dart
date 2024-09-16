import 'dart:math';

import 'package:flutter/material.dart';

import '../../dashboard/repository/model/get_home_data_response.dart';
import 'categoryicon.dart';


class CategoryCard extends StatelessWidget {
  Categories? category;
  Function? onCardClick;

  CategoryCard({ this.category, this.onCardClick });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onCardClick!();
      },
      child: Container(
          margin: EdgeInsets.all(20),
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                      'assets/imgs/' + this.category!.image! + '.png',
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent
                            ]))),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CategoryIcon(
                          color: RandomColorModel().getColor(),
                          iconName: ''),
                      SizedBox(width: 10),
                      Text(this.category!.name!,
                          style: TextStyle(color: Colors.white, fontSize: 25))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

}

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
  }
}
