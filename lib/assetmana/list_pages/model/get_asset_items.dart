import 'add_asset_model.dart';

class GetAssetItems {
  GetAssetItems({
    bool? success,
    String? message,
    List<AssetItems>? items,
  }) {
    _success = success;
    _message = message;
    _items = items;
  }

  List<AssetItems>? get items => _items;

  GetAssetItems.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _minimumAmountValue = json['minimum_amount_value'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        // _items?.add(v);
        _items?.add(AssetItems.fromJson(v));
      });
    }
  }

  bool? _success;
  String? _message;
  String? _minimumAmountValue;
  List<AssetItems>? _items;

  bool? get success => _success;

  String? get message => _message;

  String? get minimumAmountValue => _minimumAmountValue;

  List<AssetItems>? get banner => _items;

  set success(bool? value) {
    _success = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['minimumAmountValue'] = _minimumAmountValue;

    if (_items != null) {
      map['items'] = _items?.map((v) => v).toList();
    }

    return map;
  }

  set message(String? value) {
    _message = value;
  }

  set items(List<AssetItems>? value) {
    _items = value;
  }
}

class AssetItems {
  AssetItems(
      {String? id,
      String? appClientId,
      String? item,
      String? category_id,
      String? image,
      String? status,
      String? addedon,
      String? subcategory_id,
        String? subcategotyname,
      List<AddAssetModel>? oldassets,
      ItemFormData? formdata}) {
    _id = id;
    _appClientId = appClientId;
    _item = item;
    _category_id = category_id;
    _image = image;
    _status = status;
    _addedon = addedon;
    _asset_type_name = asset_type_name;
    _subcategory_id = subcategory_id;
    _subcategotyname=subcategotyname;
    _formdata = formdata;
    _oldassets=oldassets;
  }

  AssetItems.fromJson(dynamic json) {
    _id = json['id'];
    _appClientId = json['app_client_id'];
    _item = json['item'];
    _image = json['image'];
    _status = json['status'];
    _category_id = json['category_id'];
    _subcategory_id = json['subcategory_id'];
    _asset_type_name = json['asset_type_name'];
    _addedon = json['addedon'];
    _subcategotyname=json['subcategotyname'];
    _formdata = ItemFormData.fromJson(json['formdata']);
    if (json['oldassets'] != null) {
      _oldassets = [];
      json['oldassets'].forEach((v) {
        // _items?.add(v);
        _oldassets?.add(AddAssetModel.fromJson(v));
      });
    }
  }

  String? _id;
  String? _appClientId;
  String? _item;
  String? _image;
  String? _category_id;
  String? _subcategory_id;
  String? _asset_type_name;
  String? _status;
  String? _addedon;
  String? _subcategotyname;
  ItemFormData? _formdata;
  List<AddAssetModel>? _oldassets;

  String? get subcategotyname=>_subcategotyname;

  ItemFormData? get formdata => _formdata;

  String? get id => _id;

  String? get appClientId => _appClientId;

  String? get item => _item;

  String? get image => _image;

  String? get category_id => _category_id;

  String? get subcategory_id => _subcategory_id;

  String? get asset_type_name => _asset_type_name;

  String? get status => _status;

  String? get addedon => _addedon;
  List<AddAssetModel>? get oldassets => _oldassets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['app_client_id'] = _appClientId;
    map['name'] = _item;
    map['image'] = _image;
    map['status'] = _status;
    map['category_id'] = _category_id;
    map['subcategory_id'] = _subcategory_id;
    map['asset_type_name'] = _asset_type_name;
    map['addedon'] = _addedon;
    map['subcategotyname']=_subcategotyname;
    map['formdata']=_formdata?.toJson();
    if (_oldassets != null) {
      map['oldassets'] = _oldassets?.map((v) => v).toList();
    }
    return map;
  }
}

class ItemFormData {
  ItemFormData(
      {String? id,
      String? appClientId,
      String? item,
      String? assettype,
      String? form_type,
      String? form_subtype_id,
      String? addedon,
      String? status,
      FormName? form_name}) {
    _id = id;
    _appClientId = appClientId;
    _item = item;
    _assettype = assettype;
    _assettype = assettype;
    _status = status;
    _addedon = addedon;
    _form_subtype_id = form_subtype_id;
    _form_name = form_name;
  }

  ItemFormData.fromJson(dynamic json) {
    _id = json['id'];
    _appClientId = json['app_client_id'];
    _item = json['item'];
    _assettype = json['assettype'];
    _status = json['status'];
    _form_type = json['form_type'];
    _form_subtype_id = json['form_subtype_id'];
    _addedon = json['addedon'];
    if (json['form_name'] != null && json['form_name']!="") {
      _form_name = FormName.fromJson(json['form_name']);
    }
  }

  String? _id;
  String? _appClientId;
  String? _item;
  String? _assettype;
  String? _form_type;
  String? _form_subtype_id;
  String? _status;
  String? _addedon;
  FormName? _form_name;

  FormName? get form_name => _form_name;

  String? get form_subtype_id => _form_subtype_id;

  String? get form_type => _form_type;

  String? get assettype => _assettype;

  String? get id => _id;

  String? get appClientId => _appClientId;

  String? get item => _item;

  String? get status => _status;

  String? get addedon => _addedon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['app_client_id'] = _appClientId;
    map['name'] = _item;
    map['assettype'] = _assettype;
    map['status'] = _status;
    map['form_type'] = _form_type;
    map['form_subtype_id'] = _form_subtype_id;
    map['addedon'] = _addedon;

    map['form_name']=_form_name?.toJson();
    return map;
  }
}

class FormName {
  FormName({
    String? title,
    String? description,
    String? add_button,
    List<Files>? files,
  }) {
    _title = title;
    _description = description;
    _files = files;
    _add_button=add_button;
  }

  FormName.fromJson(dynamic json) {
    _title = json['title'];
    _description = json['description'];
    _add_button=json['add_button'];
    if (json['files'] != null) {
      _files = [];
      json['files'].forEach((v) {
        // _items?.add(v);
        _files?.add(Files.fromJson(v));
      });
    }
  }

  String? _title;
  String? _description;
  String? _add_button;
  List<Files>? _files;

  List<Files>? get files => _files;

  String? get title => _title;

  String? get add_button=>_add_button;

  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['add_button']=_add_button;
    map['description'] = _description;
    if (_files != null) {
      map['files'] = _files?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Files {
  Files({
    String? heading,
    String? type,
    String? isrequerd,
    List<String>? option,
    String? value,
    FormName? extraform,
    List<String>? multipleValues,


  }) {
    _heading = heading;
    _type = type;
    _isrequerd = isrequerd;
    _option = option;
    _value=value;
    _multipleValues=multipleValues;
    _extraform=extraform;
  }

  Files.fromJson(dynamic json) {
    _heading = json['heading'];
    _type = json['type'];
    _isrequerd = json['isrequerd'];
    _value=json['value'];

    if (json['option'] != null) {
      _option = [];
      json['option'].forEach((v) {
        _option?.add(v);
      });
    }

    if (json['multiple_value'] != null) {
      _multipleValues = [];
      json['multiple_value'].forEach((v) {
        _multipleValues?.add(v);
      });
    }
    if (json['extraform'] != null) {
      _extraform = FormName.fromJson(json['extraform']);
    }
  }

  String? _heading;
  String? _type;
  String? _isrequerd;
  String? _value="";

  String? get heading => _heading;
  List<String>? _option;
  List<String>? _multipleValues=[];
  FormName? _extraform;

  FormName? get extraform => _extraform;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['heading'] = _heading;
    map['type'] = _type;
    map['isrequerd'] = _isrequerd;
    map['value']=_value;
    if (_option != null) {
      map['option'] = _option?.map((v) => v).toList();
    }
    if (_multipleValues != null) {
      map['multiple_value'] = _multipleValues?.map((v) => v).toList();
    }

    map['extraform']=_extraform?.toJson();
    return map;
  }

  List<String>? get multipleValues => _multipleValues;

  set multipleValues(List<String>? value) {
    _multipleValues = value;
  }

  set value(String? value) {
    _value = value;
  }

  String? get type => _type;

  String? get isrequerd => _isrequerd;

  List<String>? get option => _option;

  String? get value => _value;
}
