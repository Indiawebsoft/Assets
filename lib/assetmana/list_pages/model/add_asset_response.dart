
class AddAssetResponse {


  AddAssetResponse({
    bool? success,
    dynamic? message,
    dynamic? orderid,
  }){
    _success = success;
    _message = message;
    _orderid=orderid;

  }

  AddAssetResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _orderid=json['orderid'];
    // _data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
  bool? _success;
  dynamic? _message;
  dynamic? _orderid;
  // LoginData? _data;

  bool? get success => _success;
  dynamic? get message => _message;
  dynamic? get orderid=> _orderid;
  // LoginData? get data => _data;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['orderid'] = _orderid;
    // if (_data != null) {
    //   map['data'] = _data?.toJson();
    // }
    return map;
  }

  @override
  String toString() {
    return 'AddAssetResponse{_success: $_success, _message: $_message,_orderid : $_orderid}';
  }
}
