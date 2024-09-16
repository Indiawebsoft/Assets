import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:asset_management/category/repository/model/get_category_response.dart';
import 'package:asset_management/category/repository/model/get_package_response.dart';
import 'package:asset_management/dashboard/repository/model/get_home_data_response.dart';
import 'package:asset_management/helper/ap_constant.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:asset_management/login/repository/model/login_response.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  var loading = false.obs;
  var cartCount = 0.obs;
  var orderItems = GetStorage().read(Constant.items);
var minimumAmountValue=0;

  void setupCartList(){

    if(orderItems==null){

     // orderItems = <Orderitem>[].obs;
    }else {
      orderItems = GetStorage().read(Constant.items).obs;

    }


  }

  Future<GetCategoryResponse> getCategories() async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.CATEGORIES}").catchError((e) {
      print("Errrrrr ${e}");
    });

    GetCategoryResponse registerLoginResponse =
        GetCategoryResponse.fromJson(response.data);

    return registerLoginResponse;
  }

  Future<GetPackageResponse> getPackages() async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.PACKAGES}").catchError((e) {
      print("Errrrrr ${e}");
    });

    GetPackageResponse registerLoginResponse =
    GetPackageResponse.fromJson(response.data);

    return registerLoginResponse;
  }



  Future<GetHomeDataResponse> getHomeData() async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.HOMEAPI}").catchError((e) {
      print("Errrrrr ${e}");
    });
    print("dattttt home  ${response.data.toString()}");
    GetHomeDataResponse getHomeDataResponse =
        GetHomeDataResponse.fromJson(response.data);

    GetStorage().write(Constant.CATEGORIES, getHomeDataResponse.categories! as List<Categories>);

    print("dataaaaaaa ${getHomeDataResponse.tests.toString()}");

    return getHomeDataResponse;
  }

  // Future<GetAllTestResponse> getAllTests() async {
  //   var dio = Dio();
  //   final response = await dio.get("${ApiConstant.ALL_TEST}").catchError((e) {
  //     print("Errrrrr ${e}");
  //   });
  //
  //   GetAllTestResponse getAllTestResponse =
  //       GetAllTestResponse.fromJson(response.data);
  //
  //   return getAllTestResponse;
  // }

  Future<LoginResponse> getProfile(String userID) async {
    var dio = Dio();
    final response =
        await dio.get("${ApiConstant.GET_PROFILE}${userID}").catchError((e) {
      print("Errrrrr ${e}");
      // Get.to(LoginScreen());
    });

    print("nnnnnn ${userID}");



    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    if(loginResponse.success!){
      GetStorage().write(Constant.PROFILE,loginResponse.data);


    }
    print("ressssss ${loginResponse.toString()}");

    return loginResponse;
  }

  Future<void> updateProfile(LoginData sloginResponse) async {

    print("update ${sloginResponse.toString()}");

    var dio = Dio();
    final response = await dio.post("${ApiConstant.UPDATE_PROFILE}", data: sloginResponse.toJson())
        .catchError((e) {
      print("Errrrrr ${e}");
      // Get.to(LoginScreen());
    });
    print("Errrrrr ${response.data}");

    // LoginResponse mloginResponse = LoginResponse.fromJson(response.data);

  }


  Future<void> updatePrescription(LoginData sloginResponse) async {





    print("update ${sloginResponse.toString()}");

    var dio = Dio();
    final response = await dio.post("${ApiConstant.UPDATE_Prescription}", data: sloginResponse.toJson())
        .catchError((e) {
      print("Errrrrr ${e}");
      // Get.to(LoginScreen());
    });
    print("Errrrrr ${response.data}");

    // LoginResponse mloginResponse = LoginResponse.fromJson(response.data);

  }


  // Future<GetAllTestResponse> getAllTestsByCategory(String categoryID) async {
  //   var dio = Dio();
  //   final response = await dio.get("${ApiConstant.GET_TEST_BY_CATEGORY}${categoryID}").catchError((e) {
  //     print("Errrrrr ${e}");
  //   });
  //
  //   GetAllTestResponse getAllTestResponse =
  //   GetAllTestResponse.fromJson(response.data);
  //
  //   return getAllTestResponse;
  // }


  // Future<Map<String, dynamic>> startPayUPayment(String txnID,String phone, String email,
  //     String amount,String productName, String firstName, PayuMoneyFlutter payuMoneyFlutter) async {
  //   // Generating hash from php server
  //   var dio = Dio();
  //
  //   var res =
  //   await dio.post("http://server_url.com", data: {
  //     "txnid": txnID,
  //     "phone": phone,
  //     "email": email,
  //     "amount": amount,
  //     "productinfo": productName,
  //     "firstname": firstName,
  //   });
  //   var data = jsonDecode(res.data);
  //   print(data);
  //   String hash = data['params']['hash'];
  //   print(hash);
  //   Map<String, dynamic> response = await payuMoneyFlutter.startPayment(
  //       txnid: txnID,
  //       amount: amount,
  //       name: firstName,
  //       email: email,
  //       phone: phone,
  //       productName: productName,
  //       hash: hash);
  //   print("EROROWROIWEURIWUERIUWRIOEU : $response");
  //
  //
  //   return response;
  //
  // }

}
