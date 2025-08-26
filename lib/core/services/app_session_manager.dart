
import 'package:flustra_template/modules/auth/data/responses/auth_response.dart';

import '../data/cache/cache_key.dart';

class AppSessionManager {
  AppSessionManager._();

  static AuthResposne? response;

  static Userdata? get user => response?.data?.user;
  static String? get token => response?.data?.token;
  static bool get amILogin => response?.data?.token?.isNotEmpty ?? false;

  static void updateUserToken(String token) {
    response?.data?.token = token;
    updateUser(response);
  }

  /// pass null that mean user will removes
  static void updateUserOnly(Userdata? user) {
    response?.data?.user = user;
    updateUser(response);
  }

  /// pass null that mean user will removes
  static void updateUser(AuthResposne? authResposne) {
    response = authResposne;
// -------------------------- Save response data -------------------------- //
    if (authResposne == null) {
      AppCache.remove(key: CacheKey.loginResponse);
      return;
    }
    AppCache.saveData(key: CacheKey.loginResponse, value: response?.toJson());
  }

  static void init() {
    var res = AppCache.getMap(key: CacheKey.loginResponse);
    if (res == null) return;
    response = AuthResposne.fromJson(res);
  }
}
