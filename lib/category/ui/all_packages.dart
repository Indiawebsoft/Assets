import 'package:flutter/material.dart';
import 'package:asset_management/category/repository/model/get_category_response.dart';
import 'package:asset_management/category/repository/model/get_package_response.dart';
import 'package:asset_management/dashboard/repository/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:asset_management/helper/size_config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllPackages extends StatelessWidget {


  DashboardController dashboardController = Get.find();
  var orderItems = GetStorage().read(Constant.items);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      floatingActionButton: (orderItems!=null && orderItems.length> 0) ? Container(
        height: 80.0,
        width: 80.0,

        child: FittedBox(
          child: FloatingActionButton(onPressed: () {},
            child:  Container(
              margin: EdgeInsets.only(right: 12),
              child: Stack(
                children: [
                  Container(
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.only(right: 0),
                        decoration: BoxDecoration(
                            color: Colors.redAccent, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Obx(() =>
                              Text("${dashboardController.cartCount.value}")),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ): null,

      appBar: AppBar(
        title: Text("Packages"),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.only(top: 12),
          child: buildStageredSortProductList(120)),

    );
  }

  Widget buildStageredSortProductList(double height) {
    height=SizeConfig.blockSizeVertical*25;
    double imgheight=SizeConfig.blockSizeVertical*20;
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<GetPackageResponse> data) {
        if (data.hasData) {
          if (data.data!.data!.length > 0) {
            return Container(
              margin: EdgeInsets.only(left: 8,right: 8),
              child: GridView.count(
                childAspectRatio: 175 / height,
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 8,
                children: List.generate(data.data!.data!.length, (index) {
                  if (orderItems != null) {
                    if (orderItems.length > 0) {
                      orderItems.forEach((element) {
                        if ("p"+element.id == "p${data.data!.data![index]!.id}") {
                          data.data!.data![index]!.quantity =
                          "${element.quantity}";
                          // data.data!.data![index]!.subtotal =
                          // "${element.subtotal}";
                        }
                      });
                    }
                  }
                  return InkWell(
                    // onTap: () => Get.to(AllTest(
                    //     cateogoryTest: true, categoryId: savedList[index].id)),

                    onTap: () {

                    },
                    child: Container(

                    ),
                  );
                }),
              ),


              // child: GridView.count(
              //   childAspectRatio: 160 / height,
              //   shrinkWrap: true,
              //   primary: false,
              //   crossAxisCount: 2,
              //   mainAxisSpacing: 24,
              //   crossAxisSpacing: 8,
              //   children: List.generate(data.data!.data!.length, (index) {
              //     return Container(
              //       child: Center(
              //         child: Text(
              //           data.data!.data![index].package!,
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, color: Colors.white),
              //         ),
              //       ),
              //       decoration: BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.circular(18)),
              //     );
              //   }),
              // ),
            );
          } else {
            return Center(
              child: Text("No Categories found"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: dashboardController.getPackages(),
    );
  }
}
