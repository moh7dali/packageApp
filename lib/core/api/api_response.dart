import 'api_response_error.dart';

class ApiResponse<T> {
  ApiResponse({
    bool? isSucceeded,
    List<ErrorsModel>? errors,
    T? data,
  }) {
    _isSucceeded = isSucceeded;
    _errors = errors;
    _data = data;
  }

  ApiResponse.fromJson(Map<String, dynamic> json, Function fromJsonModel) {
    _isSucceeded = json['IsSucceeded'];
    if (json['Errors'] != null) {
      _errors = [];
      json['Errors'].forEach((v) {
        _errors?.add(ErrorsModel.fromJson(v));
      });
    }
    _data = json["Data"] != null ? fromJsonModel(json["Data"]) : null;
  }

  bool? _isSucceeded;
  List<ErrorsModel>? _errors;
  T? _data;

  bool? get isSucceeded => _isSucceeded;

  List<ErrorsModel>? get errors => _errors;

  T? get data => _data;

  Map<String, dynamic> toJson(Function toJsonModel) {
    final map = <String, dynamic>{};
    map['IsSucceeded'] = _isSucceeded;
    if (_errors != null) {
      map['Errors'] = _errors?.map((v) => v.toJson()).toList();
    }
    if (_data != null) {
      map['Data'] = toJsonModel;
    }
    return map;
  }
}

class DynamicModel {
  final dynamic data;

  DynamicModel({
    this.data,
  });

  factory DynamicModel.fromMap(Map<String, dynamic> json) => DynamicModel(
        data: json,
      );
}

int getInt(dynamic data) => int.parse(data.toString());

bool? getBool(dynamic data) => data;

dynamic getDynamic(dynamic data) => data;
