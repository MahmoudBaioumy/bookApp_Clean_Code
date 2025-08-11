abstract class ApiConstants {
  static const String _baseUrl = "https://codingarabic.online/api";

  static const String baseUrl = _baseUrl;

  static final _AuthApi auth = _AuthApi();
  static final _HomeApi home = _HomeApi();
  static final _cart cart = _cart();
  static final _profile profile = _profile();
}

// ========================== 🔥 Auth End points 🔥 ========================== //
class _AuthApi {
  final String login = "/login";
  final String register = "/register";
}
// ========================== 🔥 Home End points 🔥 ========================== //

class _HomeApi {
  final String homeBestSeller = "/products-bestseller";
  final String homeNewArrivals = "/products-new-arrivals";
}
// ========================== 🔥 cart End points 🔥 ========================== //
class _cart{
  final String getCart='/cart';
  final String removeCart='/remove-from-cart';
}

// ========================== 🔥 profile End points 🔥 ========================== //
class _profile{
  final String profile='/profile';
}
