
import 'package:flustra_template/modules/auth/data/responses/auth_response.dart';

import '../data/cache/cache_key.dart';

class AppSessionManager {
  AppSessionManager._();

  static AuthResposne? _user;

  static User? get user => _user?.data?.user;
  static String? get token => _user?.data?.token;
  static bool get amILogin => _user?.data?.token?.isNotEmpty ?? false;

  static void updateUserToken(String token) {
    _user?.data?.token = token;
    updateUser(_user);
  }

  /// pass null that mean user will removes
  static void updateUser(AuthResposne? authResposne) {
    _user = authResposne;
// -------------------------- Save response data -------------------------- //
    if (authResposne == null) {
      AppCache.remove(key: CacheKey.loginResponse);
      return;
    }
    AppCache.saveData(key: CacheKey.loginResponse, value: _user?.toJson());
  }

  static void init() {
    var res = AppCache.getMap(key: CacheKey.loginResponse);
    if (res == null) return;
    _user = AuthResposne.fromJson(res);
  }
}
