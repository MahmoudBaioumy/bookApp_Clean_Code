import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/modules/Wishist/data/response/fav_response.dart';
import 'package:flustra_template/modules/Wishist/logic/fav_cubit.dart';
import 'package:flutter/material.dart';

/// FavoriteController can be used to manage state and notify listeners about changes.
class WishistController extends ChangeNotifier {
  // ========================== Constructor ==========================
  WishistController();

  // ========================== 🔒 Private variables 🔒 ==========================
  final List<Map<String, dynamic>> _favoriteBooks = [];
  final List<FavData> _FavItems = [];

  List<FavData> get FavItems => _FavItems;
  final WishlistCubit _cubit = WishlistCubit.i;

  // ========================== 🗝️ Public variables 🗝️ ==========================
  List<Map<String, dynamic>> get favoriteBooks => _favoriteBooks;

  // ========================== 🔥 initialization 🔥 ==========================
  void init() async {
    final res = await _cubit.getWishlist();
    res.fold(
          (failure) => failure.showToast(),
          (data) {
        _FavItems
          ..clear()
          ..addAll(data.data ?? []);
        notifyListeners();
      },
    );
  }



  // ========================== 🌍 Public methods and events 🌍 ==========================
  void onTapRemove(int index) {
    _favoriteBooks.removeAt(index);
    notifyListeners();
  }

  // ========================== 🔒 Private methods 🔒 ==========================
  void _loadFavorites() {
    notifyListeners();
  }
}
