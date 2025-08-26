import 'package:bot_toast/bot_toast.dart';
import 'package:flustra_template/core/localization/locale_watcher.dart';
import 'package:flustra_template/main.dart';
import 'package:flustra_template/modules/Profile/view/lang_view.dart';
import 'package:flustra_template/modules/Profile/view/profile_view.dart';
import 'package:flustra_template/modules/Profile/view/contact_support.dart';
import 'package:flustra_template/modules/Wishist/view/wishist_view.dart';
import 'package:flustra_template/modules/auth/view/login/login_screen.dart';
import 'package:flustra_template/modules/auth/view/sign_in/register_screen.dart';
import 'package:flustra_template/modules/best_seller/view/best_seller_detials.dart';
import 'package:flustra_template/modules/cart/view/cart_view.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flustra_template/modules/best_seller/view/widgets/book_list_details_screen.dart';
import 'package:flustra_template/modules/home/view/home_view.dart';
import 'package:flustra_template/modules/nav_bar/nav_bar_screen.dart';
import 'package:flustra_template/modules/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'not_found_screen.dart';

// ========================== 🔥 Routers 🔥 ==========================

abstract class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String registerScreen = '/registerScreen';
  static const String homeScreenWithNavigationBar = '/homeScreenWithNavigationBar';
  static const String themeShowcaseScreen = '/ThemeShowcaseScreen';
  static const String proxyView = '/ProxyView';
  static const String navBarView = '/NavBarView';
  static const String bestSellerBooks = '/bestSellerBooks';
  static const String NewArrivelsBooksScreen = '/NewArrivelsBooksScreen';
  static const String BestSellerBooksdetails = '/BestSellerBooksdetails';
  static const String BooksListScreen = '/BooksListScreen';
  static const String cartScreen = '/CartScreen';
  static const String profile = '/ProfileView';
  static const String languageSelectionScreen = '/languageSelectionScreen';
  static const String ContactSupport = '/ContactSupport';
  static const String wishist = '/WishistView';

}

// ========================== 🔥 routerConfig 🔥 ==========================

final GoRouter routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  observers: [BotToastNavigatorObserver()],
  initialLocation: AppRoutes.splash,
  errorBuilder: (context, state) => NotFoundScreen(homeRoute: AppRoutes.home),
  routes: _buildRoutes(),
);

// ========================== 🔥 _buildRoutes 🔥 ==========================

/// Build and return all application routes
List<RouteBase> _buildRoutes() {
  return [
    _baseGoRoute(AppRoutes.splash, (_) => SplashView()),
    _baseGoRoute(AppRoutes.login, (_) => LoginScreen()),
    _baseGoRoute(AppRoutes.registerScreen, (_) => RegisterScreen()),
    _baseGoRoute(AppRoutes.navBarView, (_) => NavBarView()),
    _baseGoRoute(AppRoutes.cartScreen, (_) => CartScreen()),
    _baseGoRoute(AppRoutes.profile, (_) => ProfileView()),
    _baseGoRoute(AppRoutes.home, (_) => HomeView()),
    _baseGoRoute(AppRoutes.wishist, (_) => WishistView()),
    _baseGoRoute(AppRoutes.ContactSupport, (_) => ContactSupport()),
    _baseGoRoute(AppRoutes.languageSelectionScreen, (_) => LanguageSelectionScreen()),
    _baseGoRoute<Map<String, dynamic>>(
      AppRoutes.BooksListScreen, (args) => BooksListScreen(title: args?['title'] ?? '',products: args?['products'] ?? [],
      ),
    ),
    _baseGoRoute<Products>(AppRoutes.BestSellerBooksdetails, (p) => BestSellerBooksdetails(bookdetails:p,)),

//    _baseGoRoute<HomeScreenWithNavigationBarData>(AppRoutes.homeScreenWithNavigationBar, (data) => HomeScreenWithNavigationBar(data: data)),
  ];
}

// ========================== 🔥 base GoRoute 🔥 ==========================
GoRoute _baseGoRoute<T>(String path, Widget Function(T? data) screen) {
  // if first char in path not "/" add it
  if (path.isNotEmpty && path[0] != '/') path = '/$path';

  return GoRoute(
    path: path,
    name: path,
    builder: (context, state) => LocaleWatcher(child: ()=>screen(getTheObjectOrNull(state.extra))),
  );
}

// -------------------------- getTheObjectOrNull --------------------------

T? getTheObjectOrNull<T>(Object? extra) {
  print("extra : $extra type ${extra.runtimeType}");

  if (extra == null || extra is! T) return null;
  print("2");
  return extra as T;
}
