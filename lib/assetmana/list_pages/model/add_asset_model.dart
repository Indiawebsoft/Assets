import 'get_asset_items.dart';

class OldAssetModel{
  OldAssetModel({
  String? id,
  String? name,
  String? namecode,
  ItemFormData? itemForm,
}){
  _id=id;
  _name=name;
  namecode=namecode;
  _itemForm=itemForm;
}

String? _id="",_name="",_namecode="";
  ItemFormData? _itemForm;


  OldAssetModel.fromJson(dynamic json) {
    _id=json['id'];
    _name=json['name'];
    _namecode=json['namecode'];
    _itemForm = ItemFormData.fromJson(json['item_form']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id']=_id;
    map['name']=_name;
    map['namecode']=_namecode;
    map['item_form'] = _itemForm?.toJson();

    return map;
  }

  ItemFormData? get itemForm => _itemForm;

  set id(String? value) {
    _id = value;
  }

  String? get namecode => _namecode;

  String? get name => _name;

  String? get id => _id;

  set name(String? value) {
    _name = value;
  }

  set itemForm(ItemFormData? value) {
    _itemForm = value;
  }

  set namecode(String? value) {
    _namecode = value;
  }
}

class AddAssetModel {
  AddAssetModel({
    String? id,
    String? userid,
    String? app_client_id,
    String? parent,
    String? category,
    String? subCategory,
    String? item,
    String? categoryName,
    String? subCategoryName,
    String? itemName,
    String? item_form_id,
    String? headingName,
    String? item_image,
    String? addedon,
    String? add_button,
    ItemFormData? itemForm,
    List<AddAssetModel>? linkitemform,
    List<OldAssetModel>? oldassetmodel,
    String? reminder_date,
    String? reminder_befor,
    String? reminder_befor_type,

  }) {
    _id=id;
    _userid=userid;
    _app_client_id=app_client_id;
    _parent=parent;
    _category = category;
    _subCategory = subCategory;
    _item = item;
    _categoryName = categoryName;
    _subCategoryName = subCategoryName;
    _itemName = itemName;
    _item_form_id=item_form_id;
    _itemForm = itemForm;
    _addedon=addedon;
    _add_button=add_button;
    _headingName=headingName;
    _item_image=item_image;
    _linkitemform = linkitemform;
    _oldassetmodel=oldassetmodel;
    _reminder_date=reminder_date;
    _reminder_befor=reminder_befor;
    _reminder_befor_type=reminder_befor_type;
  }

  String? _id,_userid,_app_client_id,_category="",
      _subCategory="",
      _item="", _parent="0",
      _categoryName="",
      _subCategoryName="",
      _itemName="",_item_form_id,_headingName,_item_image,_addedon,
      _add_button,_reminder_date="",_reminder_befor="",_reminder_befor_type="";

  ItemFormData? _itemForm;
  List<AddAssetModel>? _linkitemform;
  List<OldAssetModel>? _oldassetmodel;

  AddAssetModel.fromJson(dynamic json) {
    _id=json['id'];
    _userid=json['userid'];
    _app_client_id=json['app_client_id'];
    _parent=json['parent'];
    _category = json['category'];
    _subCategory = json['subcategory'];
    _item = json['item'];
    _categoryName = json['category_name'];
    _subCategoryName = json['subcategory_name'];
    _itemName = json['item_name'];
    _item_form_id=json['item_form_id'];
    _headingName=json['heading_name'];
    _item_image=json['item_image'];
    _addedon=json['addedon'];
    _add_button=json['add_button'];
    _reminder_date=json['reminder_date'];
    _reminder_befor=json['reminder_befor'];
    _reminder_befor_type=json['reminder_befor_type'];
    _itemForm = ItemFormData.fromJson(json['item_form']);
    if (json['linkitemform'] != null) {
      _linkitemform = [];
      json['items'].forEach((v) {
        // _items?.add(v);
        _linkitemform?.add(AddAssetModel.fromJson(v));
      });
    }
    if (json['oldassetmodel'] != null) {
      _oldassetmodel = [];
      json['oldassetmodel'].forEach((v) {
        // _items?.add(v);
        _oldassetmodel?.add(OldAssetModel.fromJson(v));
      });
    }
  }
  String? get id => _id;
  String? get userid => _userid;
String? get add_button=>_add_button;
String? get reminder_date=>_reminder_date;

String? get reminder_befor=>_reminder_befor;

String? get reminder_befor_type=>_reminder_befor_type;

String? get parent=>_parent;
set parent(String? value){
  _parent=value;
}

  set reminder_befor_type(String? value){
    _reminder_befor_type=value;
  }
  set reminder_befor(String? value){
    _reminder_befor=value;
  }

set reminder_date(String? value){
  _reminder_date=value;
}
set add_button(String? value){
  _add_button=value;
}
  set id(String? value){
    _id=id;
  }
  set userid(String? value) {
    _userid = value;
  }

  get subCategory => _subCategory;

  List<OldAssetModel>? get oldassetmodel => _oldassetmodel;

  set oldassetmodel(List<OldAssetModel>? value) {
    _oldassetmodel = value;
  }

  String? get category => _category;

  set category(String? value) {
    _category = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id']=_id;
    map['userid']=_userid;
    map['app_client_id']=_app_client_id;
    map['parent']=_parent;
    map['category'] = _category;
    map['subcategory'] = _subCategory;
    map['item'] = _item;
    map['category_name'] = _categoryName;
    map['subcategory_name'] = _subCategoryName;
    map['item_name'] = _itemName;
    map['item_form_id']=_item_form_id;
    map['heading_name']=_headingName;
    map['item_image']=_item_image;
    map['addedon']=_addedon;
    map['add_button']=_add_button;
    map['item_form'] = _itemForm?.toJson();

    map['reminder_date']= _reminder_date;
    map['reminder_befor_type']=_reminder_befor_type;
    map['reminder_befor']=_reminder_befor;

    if (_linkitemform != null) {
      map['linkitemform'] = _linkitemform?.map((v) => v).toList();
    }
    if (_oldassetmodel != null) {
      map['oldassetmodel'] = _oldassetmodel?.map((v) => v).toList();
    }
    return map;
  }

  get addedon => _addedon;

  set app_client_id(value) {
    _app_client_id = value;
  }

  get app_client_id => _app_client_id;

  get headingName => _headingName;
  get item_image=>_item_image;

  List<AddAssetModel>? get linkitemform => _linkitemform;

  set linkitemform(List<AddAssetModel>? value) {
    _linkitemform = value;
  }

  set headingName(value) {
    _headingName = value;
  }
  set item_image(value) {
    _item_image = value;
  }

  get item_form_id => _item_form_id;

  set item_form_id(value) {
    _item_form_id = value;
  }

  get item => _item;

  get categoryName => _categoryName;

  get subCategoryName => _subCategoryName;

  get itemName => _itemName;

  set subCategory(value) {
    _subCategory = value;
  }

  ItemFormData? get itemForm => _itemForm;

  set item(value) {
    _item = value;
  }

  set itemForm(ItemFormData? value) {
    _itemForm = value;
  }

  set itemName(value) {
    _itemName = value;
  }

  set subCategoryName(value) {
    _subCategoryName = value;
  }

  set categoryName(value) {
    _categoryName = value;
  }
}
