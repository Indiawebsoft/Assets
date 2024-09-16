import 'dart:convert';

import 'package:get/get.dart';
import 'package:asset_management/helper/ap_constant.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:asset_management/login/repository/model/login_response.dart';
import 'package:asset_management/login/repository/model/splash_response.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asset_management/login/ui/login_screen.dart';

class LoginController extends GetxController {
  var loading = false.obs;

  Future<SplashResponse> getSplashData() async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.SPLASHAPI}").catchError((e) {
      print("Errrrrr ${e}");
      Constant.showToast("Server Error");
      // Get.to(LoginScreen());
    });

    SplashResponse splashResponse = SplashResponse.fromJson(response.data);
    GetStorage().write(Constant.SPLASHDATA, splashResponse);

    return splashResponse;
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




  Future<LoginResponse> user_registration(String name, String email,String appclientid, String loginby,
      String access_id, String device_name, String device_id) async {
    var dio = Dio();
    final response = await dio
        .get("${ApiConstant.USER_REGISTRATION}${email}&name=${name}&app_client_id="
            "${appclientid}&loginby=${loginby}&access_id="
            "${access_id}&device_name=${device_name}&device_id=${device_id}")
        .catchError((e) {
      print("Errrrrr ${e}");
      Get.to(LoginScreen());
    });
    print(response.requestOptions);
print("requestOptions ${response.requestOptions.path}");
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);

    if (loginResponse.success!) {
    } else {}
    return loginResponse;
  }

  Future<LoginResponse> checkOtp(String userID, String otp) async {
    var dio = Dio();
    final response = await dio
        .get("${ApiConstant.CHECK_OTP_USER}${userID}${ApiConstant.OTP}${otp}")
        .catchError((e) {
      print("Errrrrr ${e}");
      Get.to(LoginScreen());
    });

    LoginResponse loginResponse = LoginResponse.fromJson(response.data);

    if (loginResponse.success!) {
      GetStorage().write(Constant.USERID, loginResponse.data!.id.toString());
    }

    return loginResponse;
  }
}
