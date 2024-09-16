import 'package:asset_management/assetmana/list_pages/model/add_asset_model.dart';

class GetMyAsset {
  GetMyAsset({
    bool? success,
    String? message,
    List<AddAssetModel>? assets,
  }) {
    _success = success;
    _message = message;
    _assets= assets;
  }

  List<AddAssetModel>? get assets => _assets;

  GetMyAsset.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _minimumAmountValue = json['minimum_amount_value'];
    if (json['assets'] != null) {
      _assets = [];
      json['assets'].forEach((v) {
        // _items?.add(v);
        _assets?.add(AddAssetModel.fromJson(v));
      });
    }
  }

  bool? _success;
  String? _message;
  String? _minimumAmountValue;
  List<AddAssetModel>? _assets;

  bool? get success => _success;

  String? get message => _message;

  String? get minimumAmountValue => _minimumAmountValue;


  set success(bool? value) {
    _success = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['minimumAmountValue'] = _minimumAmountValue;

    if (_assets != null) {
      map['items'] = _assets?.map((v) => v).toList();
    }

    return map;
  }

  set message(String? value) {
    _message = value;
  }

  set assets(List<AddAssetModel>? value) {
    _assets = value;
  }
}


