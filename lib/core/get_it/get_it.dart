import 'package:flustra_template/core/data/cache/cache_service.dart';
import 'package:flustra_template/core/data/cache/shared_prefs_cache_service.dart';
import 'package:flustra_template/core/data/network/api_service_repo.dart';
import 'package:flustra_template/core/data/network/dio_api_service.dart';
import 'package:flustra_template/modules/Profile/data/repo.dart';
import 'package:flustra_template/modules/Profile/logic/profile_cubit.dart';
import 'package:flustra_template/modules/Wishist/data/repo.dart';
import 'package:flustra_template/modules/Wishist/logic/fav_cubit.dart';
import 'package:flustra_template/modules/auth/data/auth_repo.dart';
import 'package:flustra_template/modules/auth/logic/auth_cubit.dart';
import 'package:flustra_template/modules/best_seller/data/repo/best_seller_repo.dart';
import 'package:flustra_template/modules/best_seller/logic/best_seller_cubit.dart';
import 'package:flustra_template/modules/cart/data/repo/cart_repo.dart';
import 'package:flustra_template/modules/cart/logic/cart_cubit.dart';
import 'package:flustra_template/modules/home/data/repo/home_repo.dart';
import 'package:flustra_template/modules/new_arrival/data/repo/new_arrivals_repo.dart';
import 'package:flustra_template/modules/new_arrival/logic/new_arrival_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_settings/app_settings_cubit.dart';
import '../services/app_session_manager.dart';

final getIt = GetIt.instance;

Future setupGetIt() async {
  await initPublicServices();
  initRepositories();
  initCubits();
}

// ========================== 🔥 Public services 🔥 ==========================
Future initPublicServices() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<CacheServices>(SharedPrefsCacheService(prefs: prefs));
  AppSessionManager.init();
  getIt.registerSingleton<IApiService>(DioApiService());
}
// ========================== 🔥 repositories 🔥 ==========================

void initRepositories() {
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl());
  getIt.registerSingleton<HomeRepo>(HomeRepoImp());
  getIt.registerSingleton<bestSellerRepo>(bestSellerRepoImp());
  getIt.registerSingleton<NewArrivalsRepo>(NewArrivalsRepoImp());
  getIt.registerSingleton<CartRepo>(CartImp());
  getIt.registerSingleton<ProfileRepo>(ProfileImp());
  getIt.registerSingleton<WishlistRepo>(WishlistImp());
}

// ========================== 🔥 cubits 🔥 ==========================
void initCubits() {
  getIt.registerLazySingleton<AppSettingsCubit>(() => AppSettingsCubit());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
  getIt.registerLazySingleton<bestSellerCubit>(() => bestSellerCubit(getIt<bestSellerRepo>()));
  getIt.registerLazySingleton<newArrivalCubit>(() => newArrivalCubit(getIt<NewArrivalsRepo>()));
  getIt.registerLazySingleton<CartCubit>(() => CartCubit(getIt<CartRepo>()));
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit(getIt<ProfileRepo>()));
  getIt.registerLazySingleton<WishlistCubit>(() => WishlistCubit(getIt<WishlistRepo>()));
}
