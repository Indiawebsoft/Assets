import 'dart:convert';

import 'package:asset_management/assetmana/list_pages/model/add_asset_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:asset_management/helper/ap_constant.dart';
import 'package:asset_management/helper/constant.dart';
import 'package:asset_management/login/repository/model/login_response.dart';
import 'package:asset_management/login/repository/model/splash_response.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asset_management/login/ui/login_screen.dart';


import '../../dashboard/repository/model/get_home_data_response.dart';
import '../list_pages/model/add_asset_response.dart';
import '../list_pages/model/get_asset_items.dart';
import '../list_pages/model/my_asset_model.dart';

class AppController extends GetxController {
  var loading = false.obs;
  late Categories selectedCategory;
  List<Categories> appAllCategory=[];
  List<Subcategories> appAllSubCategory=[];


  Future<SplashResponse> getSplashData() async {
    var dio = Dio();
    final response = await dio.get(ApiConstant.SPLASHAPI).catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
      Constant.showToast("Server Error");
    });
    SplashResponse splashResponse = SplashResponse.fromJson(response.data);
    GetStorage().write(Constant.SPLASHDATA, splashResponse);

    return splashResponse;
  }

  Future<GetHomeDataResponse> getHomeData() async {
    var dio = Dio();
    final response = await dio.get(ApiConstant.HOMEAPI).catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }

    GetHomeDataResponse getHomeDataResponse =
        GetHomeDataResponse.fromJson(response.data);

    GetStorage().write(Constant.CATEGORIES,
        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      print("data ${getHomeDataResponse.tests.toString()}");
    }

    return getHomeDataResponse;
  }


  Future<LoginResponse> getProfile2(String userID) async {
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
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }
    return loginResponse;
  }


  Future<GetAssetItems> getAssetItems(String? subcategory) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.GETASSETITEMS}$subcategory").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }

    GetAssetItems assetItems = GetAssetItems.fromJson(response.data);

    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      print("data ${assetItems.items.toString()}");
    }

    return assetItems;
  }


  Future<GetAssetItems> getAllAssetItems(String? userid) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.GETALLASSETITEMS}$userid").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }

    GetAssetItems assetItems = GetAssetItems.fromJson(response.data);

    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      print("data ${assetItems.items.toString()}");
    }

    return assetItems;
  }


  Future<GetAssetItems> getAllMyFreeAssetItems(String? userid) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.GETALLMYFREEASSET}$userid").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }

    GetAssetItems assetItems = GetAssetItems.fromJson(response.data);

    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      print("data ${assetItems.items.toString()}");
    }

    return assetItems;
  }



  Future<AddAssetResponse> postlinkasset(String? userid,String? parent,String? linkid) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.LINKMYASSET}$userid&itemid=$parent&linkto=$linkid").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }
    AddAssetResponse assetResponse = AddAssetResponse.fromJson(response.data);


    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      // print("data ${assetResponse..toString()}");
    }




    return assetResponse;
  }






  Future<AddAssetResponse> addAsset(AddAssetModel addAssetModel) async {
    var dio = Dio();
    print("makeOrderModel final-  $addAssetModel");
    final response = await dio.post(ApiConstant.ADD_ASSET,data: addAssetModel.toJson()).catchError((e) {
      print("Errrrrr ${e}");
    });

    print("Orderrrrrr ${addAssetModel.toString()}");


    AddAssetResponse assetResponse = AddAssetResponse.fromJson(response.data);

    return assetResponse;


  }


  Future<AddAssetResponse> setreminder(String date,String? before,String? type,String? assetid)  async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.SET_REMINDER}$date&assetid=$assetid&before=$before&type=$type").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }
    AddAssetResponse assetResponse = AddAssetResponse.fromJson(response.data);


    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      // print("data ${assetResponse..toString()}");
    }




    return assetResponse;
  }


  Future<AddAssetResponse> unlinkAsset(String userid,String? assetid)  async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.UNLINK_ASSET}$userid&assetid=$assetid").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }
    AddAssetResponse assetResponse = AddAssetResponse.fromJson(response.data);


    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      // print("data ${assetResponse..toString()}");
    }




    return assetResponse;
  }


  Future<GetMyAsset> getMyAsset(String? usreid, String? category, String? subcategory, String? itemid) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.GET_MY_ASSET}$usreid&category=$category&subcategory=$subcategory&itemid=$itemid").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    GetMyAsset assetItems = GetMyAsset.fromJson(response.data);

    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      print("data ${assetItems.assets.toString()}");
    }

    return assetItems;
  }



  Future<GetMyAsset> getMyOldAsset(String? usreid, String? category, String? subcategory, String? itemid) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.GET_MY_ASSET}$usreid&category=$category&subcategory=$subcategory&itemid=$itemid").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    GetMyAsset assetItems = GetMyAsset.fromJson(response.data);

    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      print("data ${assetItems.assets.toString()}");
    }

    return assetItems;
  }

  Future<GetAssetItems> getAssetByCategory(String? usreid, String? category, String? subcategory) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.ASSET_BY_CATEGORY}$usreid&category=$category&subcategory=$subcategory").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    GetAssetItems assetItems = GetAssetItems.fromJson(response.data);

    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      print("data ${assetItems.toString()}");
    }

    return assetItems;
  }



  Future<GetMyAsset> getMyLinkAsset(String? usreid, String? assetid) async {
    var dio = Dio();
    final response = await dio.get("${ApiConstant.GET_MY_LINK_ASSET}$usreid&assetid=$assetid").catchError((e) {
      if (kDebugMode) {
        print("Error ${e}");
      }
    });
    if (kDebugMode) {
      print("dartfmt home  ${response.data.toString()}");
    }
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }
    GetMyAsset assetItems = GetMyAsset.fromJson(response.data);

    // GetStorage().write(Constant.CATEGORIES,
//        getHomeDataResponse.categories! as List<Categories>);

    if (kDebugMode) {
      print("data ${assetItems.assets.toString()}");
    }

    return assetItems;
  }




  Future<LoginResponse> userRegistration(
      String name,
      String email,
      String appClientId,
      String loginBy,
      String accessId,
      String deviceName,
      String deviceId) async {
    var dio = Dio();
    final response = await dio
        .get("${ApiConstant.USER_REGISTRATION}$email&name=$name&app_client_id="
            "$appClientId&loginby=$loginBy&access_id="
            "$accessId&device_name=$deviceName&device_id=$deviceId")
        .catchError((e) {
      if (kDebugMode) {
        print("Error $e");
      }
      // Get.to(LoginScreen());
    });
    if (kDebugMode) {
      print(response.requestOptions);
      print("requestOptions ${response.requestOptions.path}");
    }

    LoginResponse loginResponse = LoginResponse.fromJson(response.data);

    if (loginResponse.success!) {
    } else {

    }
    return loginResponse;
  }

  Future<LoginResponse> updateProfile(LoginData loginUserData) async {
    if (kDebugMode) {
      print("update ${loginUserData.toString()}");
    }

    var dio = Dio();
    final response = await dio
        .post(ApiConstant.COMPLETE_PROFILE, data: loginUserData.toJson())
        .catchError((e) {
      if (kDebugMode) {
        print("Error $e");
      }
    });
    if (kDebugMode) {
      print(response.requestOptions);
      print("request URL- ${response.requestOptions.path}");
      print("response DATA-  ${response.data}");

    }

    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    if (loginResponse.success!) {
    } else {

    }
    return loginResponse;
  }
}
