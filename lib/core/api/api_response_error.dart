class ErrorsModel {
  ErrorsModel({
    String? errorMessage,
    String? errorCode,
  }) {
    _errorMessage = errorMessage;
    _errorCode = errorCode;
  }

  ErrorsModel.fromJson(dynamic json) {
    _errorMessage = json['ErrorMessage'];
    _errorCode = json['ErrorCode'];
  }

  String? _errorMessage;
  String? _errorCode;

  String? get errorMessage => _errorMessage;

  String? get errorCode => _errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ErrorMessage'] = _errorMessage;
    map['ErrorCode'] = _errorCode;
    return map;
  }
}
