import 'package:asset_management/dashboard/repository/model/get_home_data_response.dart';

/// success : true
/// message : "data found."
/// data : [{"id":"1","app_client_id":"1","name":"test1","image":"","status":"1","addedon":"2021-12-15 12:38:55","addedby":"1","updated_on":"2021-12-15 13:02:55","updated_by":"1"},{"id":"2","app_client_id":"1","name":"test2","image":"","status":"1","addedon":"2021-12-15 12:39:31","addedby":"1","updated_on":"2021-12-15 13:03:04","updated_by":"1"},{"id":"5","app_client_id":"1","name":"test3","image":"","status":"1","addedon":"2021-12-15 13:59:56","addedby":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0"},{"id":"7","app_client_id":"1","name":"new","image":"","status":"1","addedon":"2021-12-22 15:28:25","addedby":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0"}]

class GetPackageResponse
{
  GetPackageResponse({
    bool? success,
    String? message,
    List<Packages>? data,}){
    _success = success;
    _message = message;
    _data = data;
  }

  GetPackageResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Packages.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Packages>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<Packages>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
