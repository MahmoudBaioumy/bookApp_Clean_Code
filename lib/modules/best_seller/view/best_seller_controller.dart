import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/best_seller/logic/best_seller_cubit.dart';
import 'package:flustra_template/modules/cart/data/request/cart_request.dart';
import 'package:flustra_template/modules/cart/logic/cart_cubit.dart';
import 'package:flutter/material.dart';

class BestSellerBooksDetailsController extends ChangeNotifier {
  // ========================== Constructor ==========================
  BestSellerBooksDetailsController();

  final bestSellerCubit _bestSellerCubit = bestSellerCubit.i;

  // ========================== 🔒 Private variables 🔒 ==========================

  // ========================== 🗝️ Public variables 🗝️ ==========================

  // ========================== 🔥 initialization 🔥 ==========================
  Future<void> init() async {}

// ========================== 🌍 Public methods and events 🌍 ==========================

// ========================== 🔒 Private methods 🔒 ==========================

  // ========================== 🔥 onTapFavourite 🔥 ========================== //

  void onTapFavourite() {
    print('add to favourite');
  }
// ========================== 🔥 onTapCart 🔥 ========================== //

  Future<void> onTapCart(int bookId) async {
    final res = await CartCubit.i.addToCart(request: AddToCartRequest(productId: bookId, quantity: 1));
    res.fold(
      (failure) => failure.showToast(),
      (cart) => AppBotToast.show(" add to cart Success total: ${cart.data?.total}"),
    );
  }
}
