import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/best_seller/logic/best_seller_cubit.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flustra_template/modules/new_arrival/logic/new_arrival_cubit.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  // ========================== Constructor ==========================
  HomeController();
  // ========================== 🔒 Private variables 🔒 ==========================

  int _pageIndex = 0;

  // ========================== 🗝️ Public variables 🗝️ ==========================
  final List<String> carouselImages = [
    'assets/carousel/immage1.jpg',
    'assets/carousel/immage2.jpg',
    'assets/carousel/immage3.jpg',
    'assets/carousel/immage4.jpg',
  ];

  // ========================== 🔥 initialization 🔥 ==========================
  void init() {
    //_homeCubit.getNewArrivalsBooks();
  }

  // ========================== 🌍 Public methods and events 🌍 ==========================
  void onTapViewAllBestsellers(List<Products> products) {
    navigateTo(AppRoutes.BooksListScreen, arguments: {
      'title': 'Best Sellers',
      'products': bestSellerCubit.i.bestSellerBooks,
    });

  }

  void onTapViewAllNewArrivals(List<Products> products) {
    navigateTo(AppRoutes.BooksListScreen, arguments: {
      'title': 'New Arrivals',
      'products': newArrivalCubit.i.newArrivalBooks,
    });
  }

  void onCarouselPageChanged(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  // ========================== 🌍 Public Getters 🌍 ==========================

  int get pageIndex => _pageIndex;
}
