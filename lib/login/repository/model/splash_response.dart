/// success : true
/// message : "Welcome"
/// results : 3
/// data : [{"id":1,"img":"http://medilabsdiagnostics.com/admin/welcomephotos/img1.png","heading":"Book Pathology Lab Test Medilabs","subheading":"Home Sample Collection by Skilled &amp; Trained Phlebotomist."},{"id":2,"img":"http://medilabsdiagnostics.com/admin/welcomephotos/img2.png","heading":"Book online test","subheading":"Book lab test at home from Medi labs diagnostics"},{"id":3,"img":"http://medilabsdiagnostics.com/admin/welcomephotos/img3.png","heading":"Digital Report Bank","subheading":"Access them  anytime, anywhere"}]

class SplashResponse {
  SplashResponse({
      bool? success, 
      String? message, 
      int? results, 
      List<SplashData>? data,}){
    _success = success;
    _message = message;
    _results = results;
    _data = data;
}

  SplashResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _results = json['results'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SplashData.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  int? _results;
  List<SplashData>? _data;

  bool? get success => _success;
  String? get message => _message;
  int? get results => _results;
  List<SplashData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['results'] = _results;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// img : "http://medilabsdiagnostics.com/admin/welcomephotos/img1.png"
/// heading : "Book Pathology Lab Test Medilabs"
/// subheading : "Home Sample Collection by Skilled &amp; Trained Phlebotomist."

class SplashData {
  SplashData({
      int? id, 
      String? img, 
      String? heading, 
      String? subheading,}){
    _id = id;
    _img = img;
    _heading = heading;
    _subheading = subheading;
}

  SplashData.fromJson(dynamic json) {
    _id = json['id'];
    _img = json['img'];
    _heading = json['heading'];
    _subheading = json['subheading'];
  }
  int? _id;
  String? _img;
  String? _heading;
  String? _subheading;

  int? get id => _id;
  String? get img => _img;
  String? get heading => _heading;
  String? get subheading => _subheading;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['img'] = _img;
    map['heading'] = _heading;
    map['subheading'] = _subheading;
    return map;
  }

}