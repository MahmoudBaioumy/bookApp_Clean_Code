import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/modules/cart/data/cart_response.dart';
import 'package:flustra_template/modules/cart/logic/cart_cubit.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  // ========================== Constructor ==========================
  CartController();

  // ========================== 🔒 Private variables 🔒 ==========================
  final List<CartItems> _cartItems = [];
  final CartCubit _cubit = CartCubit.i;

  // ========================== 🗝️ Public variables 🗝️ ==========================
  List<CartItems> get cartItems => _cartItems;

  // -------------------------- total price -------------------------- //
  double get totalPrice => _cartItems.fold(
        0,
        (sum, item) {
          final price = item.itemProductPriceAfterDiscount ?? 0;
          final qty = item.itemQuantity ?? 1;
          return sum + (price * qty);
        },
      );

  // ========================== 🔥 initialization 🔥 ==========================
  void init() async {
    final response = await _cubit.getCart();
    response.fold(
      (failure) => failure.showToast(),
      (data) {
        _cartItems
          ..clear()
          ..addAll(data.data?.cartItems ?? []);
        notifyListeners();
      },
    );
  }

  // ========================== 🌍 Public methods and events 🌍 ==========================
  // -------------------------- onIncrease(add more) -------------------------- //
  void onIncreaseQuantity(int id) {
    final item = _cartItems.firstWhere((e) => e.itemId == id);
    item.itemQuantity = (item.itemQuantity ?? 0) + 1;
    notifyListeners();
  }

// -------------------------- onDecrease(- more) -------------------------- //
  void onDecreaseQuantity(int id) {
    final item = _cartItems.firstWhere((e) => e.itemId == id);
    if ((item.itemQuantity ?? 1) > 1) {
      item.itemQuantity = (item.itemQuantity ?? 0) - 1;
      notifyListeners();
    }
  }

// -------------------------- onRemove -------------------------- //
  void onRemoveItem(int id) {
    _cartItems.removeWhere((e) => e.itemId == id);
    notifyListeners();
  }

  void onTapCheckout() {
    debugPrint("Checkout Pressed");
    // todo: implement navigation or business logic
  }

// ========================== 🔒 Private methods 🔒 ==========================
}
