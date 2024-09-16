/// success : true
/// message : "data found."
/// data : [{"id":"1","app_client_id":"1","name":"test1","image":"","status":"1","addedon":"2021-12-15 12:38:55","addedby":"1","updated_on":"2021-12-15 13:02:55","updated_by":"1"},{"id":"2","app_client_id":"1","name":"test2","image":"","status":"1","addedon":"2021-12-15 12:39:31","addedby":"1","updated_on":"2021-12-15 13:03:04","updated_by":"1"},{"id":"5","app_client_id":"1","name":"test3","image":"","status":"1","addedon":"2021-12-15 13:59:56","addedby":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0"},{"id":"7","app_client_id":"1","name":"new","image":"","status":"1","addedon":"2021-12-22 15:28:25","addedby":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0"}]

class GetCategoryResponse {
  GetCategoryResponse({
      bool? success,
      String? message,
      List<Data>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  GetCategoryResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Data>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<Data>? get data => _data;

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

/// id : "1"
/// app_client_id : "1"
/// name : "test1"
/// image : ""
/// status : "1"
/// addedon : "2021-12-15 12:38:55"
/// addedby : "1"
/// updated_on : "2021-12-15 13:02:55"
/// updated_by : "1"

class Data {
  Data({
      String? id,
      String? appClientId,
      String? name,
      String? image,
      String? status,
      String? addedon,
      String? addedby,
      String? updatedOn,
      String? updatedBy,}){
    _id = id;
    _appClientId = appClientId;
    _name = name;
    _image = image;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _updatedOn = updatedOn;
    _updatedBy = updatedBy;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _appClientId = json['app_client_id'];
    _name = json['name'];
    _image = json['image'];
    _status = json['status'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _updatedOn = json['updated_on'];
    _updatedBy = json['updated_by'];
  }
  String? _id;
  String? _appClientId;
  String? _name;
  String? _image;
  String? _status;
  String? _addedon;
  String? _addedby;
  String? _updatedOn;
  String? _updatedBy;

  String? get id => _id;
  String? get appClientId => _appClientId;
  String? get name => _name;
  String? get image => _image;
  String? get status => _status;
  String? get addedon => _addedon;
  String? get addedby => _addedby;
  String? get updatedOn => _updatedOn;
  String? get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['app_client_id'] = _appClientId;
    map['name'] = _name;
    map['image'] = _image;
    map['status'] = _status;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['updated_on'] = _updatedOn;
    map['updated_by'] = _updatedBy;
    return map;
  }

}