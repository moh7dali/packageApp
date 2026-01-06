class LoginModel {
  LoginModel({
    String? accessToken,
    int? profileId,
  }) {
    _accessToken = accessToken;
    _profileId = profileId;
  }

  LoginModel.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
    _profileId = json['ProfileId'];
  }

  String? _accessToken;
  int? _profileId;

  String? get accessToken => _accessToken;

  int? get profileId => _profileId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    map['ProfileId'] = _profileId;
    return map;
  }
}
