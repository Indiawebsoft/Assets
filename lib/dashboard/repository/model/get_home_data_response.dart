import 'package:asset_management/assetmana/list_pages/model/get_asset_items.dart';

/// success : true
/// message : "user found"
/// banner : [{"id":"4","image":"http://medilabsdiagnostics.com/admin/bannerimage//1641284672SzJ.jpg","status":"1","addedon":"2022-01-04 13:54:32","addedby":"1","app_client_id":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0"},{"id":"5","image":"http://medilabsdiagnostics.com/admin/bannerimage//1641284729LeB.jpg","status":"1","addedon":"2022-01-04 13:55:29","addedby":"1","app_client_id":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0"}]
/// tests : [{"id":"2","category_id":"5","subcategory_id":"2","testname":"Hemoglobin Test","vendor_price":"500","medilabs_price":"500","total_price":"1000","discount":"10","display_price":"950","testimage":"http://medilabsdiagnostics.com/admin/","description":"test description","status":"1","addedon":"2021-12-17 13:58:52","addedby":"1","updated_on":"2021-12-31 17:51:34","updated_by":"1","app_client_id":"1","image":"","categoryname":"test3","subcategoryname":"subtest2"},{"id":"6","category_id":"2","subcategory_id":"1","testname":"Stool test","vendor_price":"550","medilabs_price":"","total_price":"","discount":"","display_price":"","testimage":"http://medilabsdiagnostics.com/admin/","description":"","status":"1","addedon":"2021-12-17 15:25:48","addedby":"1","updated_on":"2021-12-22 15:28:35","updated_by":"1","app_client_id":"1","image":"","categoryname":"test2","subcategoryname":"sub1test1"},{"id":"7","category_id":"7","subcategory_id":"5","testname":"shiven","vendor_price":"1000","medilabs_price":"","total_price":"","discount":"","display_price":"","testimage":"http://medilabsdiagnostics.com/admin/","description":"","status":"1","addedon":"2021-12-22 15:29:23","addedby":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0","app_client_id":"1","image":"","categoryname":"new","subcategoryname":"sub new"}]
/// categories : [{"id":"1","app_client_id":"1","name":"test1","image":"http://medilabsdiagnostics.com/admin/","status":"1","addedon":"2021-12-15 12:38:55","addedby":"1","updated_on":"2021-12-15 13:02:55","updated_by":"1"},{"id":"2","app_client_id":"1","name":"test2","image":"http://medilabsdiagnostics.com/admin/","status":"1","addedon":"2021-12-15 12:39:31","addedby":"1","updated_on":"2021-12-15 13:03:04","updated_by":"1"},{"id":"5","app_client_id":"1","name":"test3","image":"http://medilabsdiagnostics.com/admin/","status":"1","addedon":"2021-12-15 13:59:56","addedby":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0"},{"id":"7","app_client_id":"1","name":"new","image":"http://medilabsdiagnostics.com/admin/","status":"1","addedon":"2021-12-22 15:28:25","addedby":"1","updated_on":"0000-00-00 00:00:00","updated_by":"0"}]

class GetHomeDataResponse {
  GetHomeDataResponse({
    bool? success,
    String? message,
    String? minimumAmountValue,
    List<String>? workingcities,
    List<Banner>? banner,
    List<Tests>? tests,
    List<Categories>? categories,
    List<Packages>? packages,
  }) {
    _success = success;
    _message = message;
    _minimumAmountValue = minimumAmountValue;
    _banner = banner;
    _tests = tests;
    _categories = categories;
    _packages = packages;
  }

  GetHomeDataResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _minimumAmountValue = json['minimum_amount_value'];
    if (json['workingcities'] != null) {
      _workingcities = [];
      json['workingcities'].forEach((v) {
        _workingcities?.add(v);
      });
    }
    if (json['banner'] != null) {
      _banner = [];
      json['banner'].forEach((v) {
        _banner?.add(Banner.fromJson(v));
      });
    }
    if (json['tests'] != null) {
      _tests = [];
      json['tests'].forEach((v) {
        _tests?.add(Tests.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    if (json['packages'] != null) {
      _packages = [];
      json['packages'].forEach((v) {
        _packages?.add(Packages.fromJson(v));
      });
    }
  }

  bool? _success;
  String? _message;
  String? _minimumAmountValue;
  List<Banner>? _banner;
  List<Tests>? _tests;
  List<Categories>? _categories;
  List<Packages>? _packages;
  List<String>? _workingcities;

  bool? get success => _success;

  String? get message => _message;

  String? get minimumAmountValue => _minimumAmountValue;

  List<String>? get workingcities => _workingcities;

  List<Banner>? get banner => _banner;

  List<Tests>? get tests => _tests;

  List<Categories>? get categories => _categories;

  List<Packages>? get packages => _packages;

  set success(bool? value) {
    _success = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['minimumAmountValue'] = _minimumAmountValue;

    if (_banner != null) {
      map['workingcities'] = _workingcities?.map((v) => v).toList();
    }
    if (_banner != null) {
      map['banner'] = _banner?.map((v) => v.toJson()).toList();
    }
    if (_tests != null) {
      map['tests'] = _tests?.map((v) => v.toJson()).toList();
    }
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    if (_packages != null) {
      map['packages'] = _packages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set message(String? value) {
    _message = value;
  }

  set banner(List<Banner>? value) {
    _banner = value;
  }

  set tests(List<Tests>? value) {
    _tests = value;
  }

  set categories(List<Categories>? value) {
    _categories = value;
  }

  set package(List<Packages>? value) {
    _packages = value;
  }
}

/// id : "1"
/// app_client_id : "1"
/// name : "test1"
/// image : "http://medilabsdiagnostics.com/admin/"
/// status : "1"
/// addedon : "2021-12-15 12:38:55"
/// addedby : "1"
/// updated_on : "2021-12-15 13:02:55"
/// updated_by : "1"

class Packages {
  Packages({
    String? id,
    String? testname,
    String? vendor_price,
    String? package,
    String? addedon,
    String? addedby,
    String? app_client_id,
    String? packageimage,
    String? discount,
    String? display,
    String? description,
    String? status,
    String? mediprice,
    String? totalprice,
    String? image,
    String? quantity,
    List<Tests>? packagestest,
  }) {
    _id = id;
    _testname = testname;
    _vendor_price = vendor_price;
    _package = package;
    _addedon = addedon;
    _addedby = addedby;
    _app_client_id = app_client_id;
    _packageimage = packageimage;
    _discount = discount;
    _display = display;
    _description = description;
    _status = status;
    _image = image;
    _mediprice = mediprice;
    _totalprice = totalprice;
    _quantity = quantity;
    _packagestest = packagestest;
  }

  Packages.fromJson(dynamic json) {
    _id = json['id'];
    _testname = json['testname'];
    _vendor_price = json['vendor_price'];
    _package = json['package'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _app_client_id = json['app_client_id'];
    _packageimage = json['packageimage'];
    _discount = json['discount'];
    _display = json['display'];
    _description = json['description'];
    _status = json['status'];
    _mediprice = json['mediprice'];
    _totalprice = json['totalprice'];
    _image = json['image'];
    _quantity = json['quantity'];
    if (json['packagestest'] != null) {
      _packagestest = [];
      json['packagestest'].forEach((v) {
        _packagestest?.add(Tests.fromJson(v));
      });
    }
  }

  String? _id;
  String? _testname;
  String? _vendor_price;

  String? get id => _id;
  String? _package;
  String? _addedon;
  String? _addedby;
  String? _app_client_id;
  String? _packageimage;
  String? _discount;
  String? _display;
  String? _description;
  String? _status;
  String? _image;
  String? _mediprice;
  String? _quantity;

  set quantity(String? value) {
    _quantity = value;
  }

  String? get mediprice => _mediprice;
  String? _totalprice;
  List<Tests>? _packagestest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['testname'] = _testname;
    map['vendor_price'] = _vendor_price;
    map['package'] = _package;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['app_client_id'] = _app_client_id;
    map['packageimage'] = _packageimage;
    map['discount'] = _discount;
    map['display'] = _display;
    map['description'] = _description;
    map['status'] = _status;
    map['image'] = _image;
    map['totalprice'] = _totalprice;
    map['mediprice'] = _mediprice;
    map['quantity'] = _quantity;
    if (_packagestest != null) {
      map['packagestest'] = _packagestest?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  String? get quantity => _quantity;

  String? get testname => _testname;

  String? get vendor_price => _vendor_price;

  String? get package => _package;

  String? get addedon => _addedon;

  String? get addedby => _addedby;

  String? get app_client_id => _app_client_id;

  String? get packageimage => _packageimage;

  String? get discount => _discount;

  String? get display => _display;

  String? get description => _description;

  String? get status => _status;

  String? get image => _image;

  List<Tests>? get packagestest => _packagestest;

  String? get totalprice => _totalprice;
}

class Subcategories {
  Subcategories(
      {String? id,
      String? appClientId,
      String? subcategory_name,
      String? category_id,
      String? image,
      String? status,
      String? addedon,
      String? asset_type_name}) {
    _id = id;
    _appClientId = appClientId;
    _subcategory_name = subcategory_name;
    _category_id = category_id;
    _image = image;
    _status = status;
    _addedon = addedon;
    _asset_type_name = asset_type_name;
  }

  Subcategories.fromJson(dynamic json) {
    _id = json['id'];
    _appClientId = json['app_client_id'];
    _subcategory_name = json['subcategory_name'];
    _image = json['image'];
    _status = json['status'];
    _category_id = json['category_id'];
    _asset_type_name = json['asset_type_name'];
    _addedon = json['addedon'];
  }

  String? _id;
  String? _appClientId;
  String? _subcategory_name;
  String? _image;
  String? _category_id;
  String? _asset_type_name;
  String? _status;
  String? _addedon;

  String? get id => _id;

  set id(String? value){
    _id=value;
  }

  String? get appClientId => _appClientId;

  String? get subcategory_name => _subcategory_name;

  String? get image => _image;

  String? get category_id => _category_id;

  String? get asset_type_name => _asset_type_name;

  String? get status => _status;

  String? get addedon => _addedon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['app_client_id'] = _appClientId;
    map['name'] = _subcategory_name;
    map['image'] = _image;
    map['status'] = _status;
    map['category_id'] = _category_id;
    map['asset_type_name'] = _asset_type_name;
    map['addedon'] = _addedon;
    return map;
  }
}

class Categories {
  Categories({
    String? id,
    String? appClientId,
    String? name,
    String? image,
    String? title,
    String? asset_type,
    String? asset_type_name,
    String? status,
    String? addedon,
    String? addedby,
    String? updatedOn,
    String? updatedBy,
    List<Subcategories>? subcategories,
    List<AssetItems>? items,
  }) {
    _id = id;
    _appClientId = appClientId;
    _name = name;
    _image = image;
    _title=title;
    _asset_type = asset_type;
    _asset_type_name = asset_type_name;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _updatedOn = updatedOn;
    _updatedBy = updatedBy;
    _subcategories = subcategories;
    _items=items;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _appClientId = json['app_client_id'];
    _name = json['category'];
    _title=json['title'];
    _image = json['image'];
    _status = json['status'];
    _asset_type = json['asset_type'];
    _asset_type_name = json['asset_type_name'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _updatedOn = json['updated_on'];
    _updatedBy = json['updated_by'];
    if (json['subcategories'] != null) {
      _subcategories = [];
      json['subcategories'].forEach((v) {
        _subcategories?.add(Subcategories.fromJson(v));
      });
    }
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(AssetItems.fromJson(v));
      });
    }
  }

  String? _id;
  String? _appClientId;
  String? _name;
  String? _title;
  String? _image;
  String? _asset_type;
  String? _asset_type_name;
  String? _status;
  String? _addedon;
  String? _addedby;
  String? _updatedOn;
  String? _updatedBy;
  List<Subcategories>? _subcategories;
  List<AssetItems>? _items;

  List<Subcategories>? get subcategories => _subcategories;
  List<AssetItems>? get items => _items;

  String? get id => _id;

  String? get title=>_title;
  set title(String? value){
    _title=value;
  }

  set id(String? value){
    _id=value;
  }

  String? get appClientId => _appClientId;

  String? get name => _name;

  String? get image => _image;

  String? get asset_type => _asset_type;

  String? get asset_type_name => _asset_type_name;

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
    map['title']=_title;
    map['status'] = _status;
    map['asset_type'] = _asset_type;
    map['asset_type_name'] = _asset_type_name;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['updated_on'] = _updatedOn;
    map['updated_by'] = _updatedBy;
    return map;
  }
}

class Tests {
  Tests(
      {String? id,
      String? categoryId,
      String? subcategoryId,
      String? testname,
      String? vendorPrice,
      String? medilabsPrice,
      String? totalPrice,
      String? discount,
      String? displayPrice,
      String? testimage,
      String? description,
      String? status,
      String? addedon,
      String? addedby,
      String? updatedOn,
      String? updatedBy,
      String? appClientId,
      String? image,
      String? categoryname,
      String? subcategoryname,
      String? quantity,
      String? total}) {
    _id = id;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _testname = testname;
    _vendorPrice = vendorPrice;
    _medilabsPrice = medilabsPrice;
    _totalPrice = totalPrice;
    _discount = discount;
    _displayPrice = displayPrice;
    _testimage = testimage;
    _description = description;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _updatedOn = updatedOn;
    _updatedBy = updatedBy;
    _appClientId = appClientId;
    _image = image;
    _categoryname = categoryname;
    _subcategoryname = subcategoryname;
    _quantity = quantity;
    _subtotal = total;
  }

  Tests.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _testname = json['testname'];
    _vendorPrice = json['vendor_price'];
    _medilabsPrice = json['medilabs_price'];
    _totalPrice = json['total_price'];
    _discount = json['discount'];
    _displayPrice = json['display_price'];
    _testimage = json['testimage'];
    _description = json['description'];
    _status = json['status'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _updatedOn = json['updated_on'];
    _updatedBy = json['updated_by'];
    _appClientId = json['app_client_id'];
    _image = json['image'];
    _categoryname = json['categoryname'];
    _subcategoryname = json['subcategoryname'];
  }

  String? _id;
  String? _categoryId;
  String? _subcategoryId;
  String? _testname;
  String? _vendorPrice;
  String? _medilabsPrice;
  String? _totalPrice;
  String? _discount;
  String? _displayPrice;
  String? _testimage;
  String? _description;
  String? _status;
  String? _addedon;
  String? _addedby;
  String? _updatedOn;
  String? _updatedBy;
  String? _appClientId;
  String? _image;
  String? _categoryname;
  String? _subcategoryname;
  String? _quantity = "0";
  String? _subtotal = "0";

  set subtotal(String? value) {
    _subtotal = value;
  }

  set quantity(String? value) {
    _quantity = value;
  }

  set medilabsPrice(String? value) {
    _medilabsPrice = value;
  }

  set id(String? value) {
    _id = value;
  }

  set categoryId(String? value) {
    _categoryId = value;
  }

  set subcategoryId(String? value) {
    _subcategoryId = value;
  }

  set testname(String? value) {
    _testname = value;
  }

  set vendorPrice(String? value) {
    _vendorPrice = value;
  }

  set totalPrice(String? value) {
    _totalPrice = value;
  }

  set discount(String? value) {
    _discount = value;
  }

  set displayPrice(String? value) {
    _displayPrice = value;
  }

  set testimage(String? value) {
    _testimage = value;
  }

  set description(String? value) {
    _description = value;
  }

  set status(String? value) {
    _status = value;
  }

  set addedon(String? value) {
    _addedon = value;
  }

  set addedby(String? value) {
    _addedby = value;
  }

  set updatedOn(String? value) {
    _updatedOn = value;
  }

  set updatedBy(String? value) {
    _updatedBy = value;
  }

  set appClientId(String? value) {
    _appClientId = value;
  }

  set image(String? value) {
    _image = value;
  }

  set categoryname(String? value) {
    _categoryname = value;
  }

  set subcategoryname(String? value) {
    _subcategoryname = value;
  }

  String? get subtotal => _subtotal;

  String? get quantity => _quantity;

  String? get id => _id;

  String? get categoryId => _categoryId;

  String? get subcategoryId => _subcategoryId;

  String? get testname => _testname;

  String? get vendorPrice => _vendorPrice;

  String? get medilabsPrice => _medilabsPrice;

  String? get totalPrice => _totalPrice;

  String? get discount => _discount;

  String? get displayPrice => _displayPrice;

  String? get testimage => _testimage;

  String? get description => _description;

  String? get status => _status;

  String? get addedon => _addedon;

  String? get addedby => _addedby;

  String? get updatedOn => _updatedOn;

  String? get updatedBy => _updatedBy;

  String? get appClientId => _appClientId;

  String? get image => _image;

  String? get categoryname => _categoryname;

  String? get subcategoryname => _subcategoryname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['testname'] = _testname;
    map['vendor_price'] = _vendorPrice;
    map['medilabs_price'] = _medilabsPrice;
    map['total_price'] = _totalPrice;
    map['discount'] = _discount;
    map['display_price'] = _displayPrice;
    map['testimage'] = _testimage;
    map['description'] = _description;
    map['status'] = _status;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['updated_on'] = _updatedOn;
    map['updated_by'] = _updatedBy;
    map['app_client_id'] = _appClientId;
    map['image'] = _image;
    map['categoryname'] = _categoryname;
    map['subcategoryname'] = _subcategoryname;
    return map;
  }
}

/// id : "4"
/// image : "http://medilabsdiagnostics.com/admin/bannerimage//1641284672SzJ.jpg"
/// status : "1"
/// addedon : "2022-01-04 13:54:32"
/// addedby : "1"
/// app_client_id : "1"
/// updated_on : "0000-00-00 00:00:00"
/// updated_by : "0"

class Banner {
  Banner({
    String? id,
    String? image,
    String? status,
    String? addedon,
    String? addedby,
    String? appClientId,
    String? updatedOn,
    String? updatedBy,
  }) {
    _id = id;
    _image = image;
    _status = status;
    _addedon = addedon;
    _addedby = addedby;
    _appClientId = appClientId;
    _updatedOn = updatedOn;
    _updatedBy = updatedBy;
  }

  Banner.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _status = json['status'];
    _addedon = json['addedon'];
    _addedby = json['addedby'];
    _appClientId = json['app_client_id'];
    _updatedOn = json['updated_on'];
    _updatedBy = json['updated_by'];
  }

  String? _id;
  String? _image;
  String? _status;
  String? _addedon;
  String? _addedby;
  String? _appClientId;
  String? _updatedOn;
  String? _updatedBy;

  String? get id => _id;

  String? get image => _image;

  String? get status => _status;

  String? get addedon => _addedon;

  String? get addedby => _addedby;

  String? get appClientId => _appClientId;

  String? get updatedOn => _updatedOn;

  String? get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['status'] = _status;
    map['addedon'] = _addedon;
    map['addedby'] = _addedby;
    map['app_client_id'] = _appClientId;
    map['updated_on'] = _updatedOn;
    map['updated_by'] = _updatedBy;
    return map;
  }
}
