/// success : true
/// message : "OTP has been sent to your mobile number 9425688897"
/// data : {"id":"4","name":"","mobile":"9425688897","email":"","age":"","gender":"","landmark":"","pincode":"","address":"","country":"","state":"","city":"","latitude":"","longitude":"","device_token":"","otp":"1234","image":"","status":"1","addedon":"2022-01-04 14:59:36","addedby":"0","updated_on":"2022-01-04 14:59:36","updated_by":"0","app_client_id":"1"}

class LoginResponse {


  LoginResponse({
    bool? success,
    dynamic? message,
    LoginData? data,}){
    _success = success;
    _message = message;
    _data = data;
  }

  LoginResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
  bool? _success;
  dynamic? _message;
  LoginData? _data;

  bool? get success => _success;
  dynamic? get message => _message;
  LoginData? get data => _data;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return 'LoginResponse{_success: $_success, _message: $_message, _data: $_data}';
  }
}

/// id : "4"
/// name : ""
/// mobile : "9425688897"
/// email : ""
/// age : ""
/// gender : ""
/// landmark : ""
/// pincode : ""
/// address : ""
/// country : ""
/// state : ""
/// city : ""
/// latitude : ""
/// longitude : ""
/// device_token : ""
/// otp : "1234"
/// image : ""
/// status : "1"
/// addedon : "2022-01-04 14:59:36"
/// addedby : "0"
/// updated_on : "2022-01-04 14:59:36"
/// updated_by : "0"
/// app_client_id : "1"

class LoginData {
  LoginData({
    dynamic? id,
    dynamic? name,
    dynamic? mobile,
    dynamic? email,
    dynamic? age,
    dynamic? gender,
    dynamic? landmark,
    dynamic? pincode,
    dynamic? address,
    dynamic? country,
    dynamic? state,
    dynamic? city,
    dynamic? latitude,
    dynamic? longitude,
    dynamic? deviceToken,
    dynamic? otp,
    dynamic? image,
    dynamic? status,
    dynamic? addedon,
    dynamic? addedby,
    dynamic? updatedOn,
    dynamic? updatedBy,
    dynamic? appClientId,}){
    _id = id;
    _name = name;
    _mobile = mobile;
    _email = email;
    _age = age;
    _gender = gender;
    _landmark = landmark;
    _pincode = pincode;
    _address = address;
    _country = country;
    _state = state;
    _city = city;
    _latitude = latitude;
    _longitude = longitude;
    _deviceToken = deviceToken;
    _otp = otp;
    _image = image;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _updatedOn = updatedOn;
    _updatedBy = updatedBy;
    _appClientId = appClientId;
  }

  LoginData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _email = json['email'];
    _age = json['age'];
    _gender = json['gender'];
    _landmark = json['landmark'];
    _pincode = json['pincode'];
    _address = json['address'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _deviceToken = json['device_token'];
    _otp = json['otp'];
    _image = json['image'];
    _status = json['status'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _updatedOn = json['updated_on'];
    _updatedBy = json['updated_by'];
    _appClientId = json['app_client_id'];
  }
  dynamic? _id;
  dynamic? _name;
  dynamic? _mobile;
  dynamic? _email;
  dynamic? _age;
  dynamic? _gender;
  dynamic? _landmark;
  dynamic? _pincode;
  dynamic? _address;
  dynamic? _country;
  dynamic? _state;
  dynamic? _city;
  dynamic? _latitude;
  dynamic? _longitude;
  dynamic? _deviceToken;
  dynamic? _otp;
  dynamic? _image;
  dynamic? _status;
  dynamic? _addedon;
  dynamic? _addedby;
  dynamic? _updatedOn;
  dynamic? _updatedBy;
  dynamic? _appClientId;

  dynamic? get id => _id;
  dynamic? get name => _name;
  dynamic? get mobile => _mobile;
  dynamic? get email => _email;
  dynamic? get age => _age;
  dynamic? get gender => _gender;
  dynamic? get landmark => _landmark;
  dynamic? get pincode => _pincode;
  dynamic? get address => _address;
  dynamic? get country => _country;
  dynamic? get state => _state;
  dynamic? get city => _city;
  dynamic? get latitude => _latitude;
  dynamic? get longitude => _longitude;
  dynamic? get deviceToken => _deviceToken;
  dynamic? get otp => _otp;
  dynamic? get image => _image;
  dynamic? get status => _status;
  dynamic? get addedon => _addedon;
  dynamic? get addedby => _addedby;
  dynamic? get updatedOn => _updatedOn;
  dynamic? get updatedBy => _updatedBy;
  dynamic? get appClientId => _appClientId;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['age'] = _age;
    map['gender'] = _gender;
    map['landmark'] = _landmark;
    map['pincode'] = _pincode;
    map['address'] = _address;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['device_token'] = _deviceToken;
    map['otp'] = _otp;
    map['image'] = _image;
    map['status'] = _status;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['updated_on'] = _updatedOn;
    map['updated_by'] = _updatedBy;
    map['app_client_id'] = _appClientId;
    return map;
  }

  set appClientId(dynamic value) {
    _appClientId = value;
  }

  set updatedBy(dynamic value) {
    _updatedBy = value;
  }

  set updatedOn(dynamic value) {
    _updatedOn = value;
  }

  set addedby(dynamic value) {
    _addedby = value;
  }

  set addedon(dynamic value) {
    _addedon = value;
  }

  set status(dynamic value) {
    _status = value;
  }

  set image(dynamic value) {
    _image = value;
  }

  set otp(dynamic value) {
    _otp = value;
  }

  set deviceToken(dynamic value) {
    _deviceToken = value;
  }

  set longitude(dynamic value) {
    _longitude = value;
  }

  set latitude(dynamic value) {
    _latitude = value;
  }

  set city(dynamic value) {
    _city = value;
  }

  set state(dynamic value) {
    _state = value;
  }

  set country(dynamic value) {
    _country = value;
  }

  set address(dynamic value) {
    _address = value;
  }

  set pincode(dynamic value) {
    _pincode = value;
  }

  set landmark(dynamic value) {
    _landmark = value;
  }

  set gender(dynamic value) {
    _gender = value;
  }

  set age(dynamic value) {
    _age = value;
  }

  set email(dynamic value) {
    _email = value;
  }

  set mobile(dynamic value) {
    _mobile = value;
  }

  set name(dynamic value) {
    _name = value;
  }

  set id(dynamic value) {
    _id = value;
  }

  @override
  String toString() {
    return 'LoginData{_id: $_id, _name: $_name, _mobile: $_mobile, _email: $_email, _age: $_age, _gender: $_gender, _landmark: $_landmark, _pincode: $_pincode, _address: $_address, _country: $_country, _state: $_state, _city: $_city, _latitude: $_latitude, _longitude: $_longitude, _deviceToken: $_deviceToken, _otp: $_otp, _image: $_image, _status: $_status, _addedon: $_addedon, _addedby: $_addedby, _updatedOn: $_updatedOn, _updatedBy: $_updatedBy, _appClientId: $_appClientId}';
  }
}