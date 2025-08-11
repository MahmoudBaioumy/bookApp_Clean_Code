import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/best_seller/view/best_seller_controller.dart';
import 'package:flustra_template/modules/best_seller/view/widgets/bestSeller_bookItem_widget.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_defults_size.dart';
import '../../../core/localization/app_strings_localizations.dart';

class BestSellerBooksScreen extends StatefulWidget {
  static const String name = AppRoutes.bestSellerBooks;
 final List<Products>  products;
  static void navigateToMe() => navigateTo(name);

  const BestSellerBooksScreen({super.key, required this.products});

  @override
  State<BestSellerBooksScreen> createState() => _BestSellerBooksScreenState();
}

class _BestSellerBooksScreenState extends State<BestSellerBooksScreen> {


  late final BestSellerBooksController _controller = BestSellerBooksController();

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(AppDefaults.padding),
          itemCount: widget.products.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppDefaults.padding),
          itemBuilder: (_, index) {
            return BestSellerBookItemWidget(
              book: widget.products[index], onTap: () {},
           //   onTap: () => navigateTo(AppRoutes.bestSellerBooks,arguments: widget.products[index]),
            );
          },
        )
    );
  }
}
