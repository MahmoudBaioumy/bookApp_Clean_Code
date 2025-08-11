import 'package:flustra_template/modules/best_seller/logic/best_seller_cubit.dart';
import 'package:flutter/material.dart';

class BestSellerBooksController extends ChangeNotifier {
  // ========================== Constructor ==========================
  BestSellerBooksController();

  final bestSellerCubit _bestSellerCubit = bestSellerCubit.i;

  // ========================== 🔒 Private variables 🔒 ==========================


  // ========================== 🗝️ Public variables 🗝️ ==========================


  // ========================== 🔥 initialization 🔥 ==========================
  Future<void> init() async{}

// ========================== 🌍 Public methods and events 🌍 ==========================

// ========================== 🔒 Private methods 🔒 ==========================
  void onTapFavourite() {
    print('add to favourite');
  }

  void onTapCart() {
    print('add to Cart');
  }

}
