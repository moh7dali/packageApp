import '../../injection_container.dart';
import '../../shared/helper/shared_preferences_storage.dart';
import '../constants/constants.dart';

class HeaderInterceptor {
  static Future<Map<String, String>> getHeaders({bool isAuthorized = false, bool fromLogin = false}) async {
    String appLanguage = await sl<SharedPreferencesStorage>().getAppLanguage();
    Map<String, String> headers = {
      'DeviceLanguage': "${appLanguage == 'en' ? 2 : 1}",
      'Content-Type': 'application/json',
    };
    String? token;
    if (isAuthorized) {
      token = await sl<SharedPreferencesStorage>().getAccessToken();
    } else if (fromLogin) {
      token = await sl<SharedPreferencesStorage>().getSessionToken();
    }
    if (token != null) {
      if (fromLogin) {
        headers.putIfAbsent("SessionToken", () => "Bearer $token");
      } else {
        headers.putIfAbsent("Authorization", () => "Bearer $token");
      }
    }
    return headers;
  }
}
