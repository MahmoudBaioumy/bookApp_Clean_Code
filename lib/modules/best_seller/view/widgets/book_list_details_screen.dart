import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/best_seller/view/best_seller_controller.dart';
import 'package:flutter/material.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flustra_template/modules/best_seller/view/widgets/bestSeller_bookItem_widget.dart';

class BooksListScreen extends StatelessWidget {
  final String title;
  final List<Products> products;

  BooksListScreen({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  final BestSellerBooksDetailsController controller = BestSellerBooksDetailsController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, index) {
          final book = products[index];
          return BestSellerBookItemWidget(
            book: book,
            onTapAddToCart: () async{
            await controller.onTapCart(book.id ??0);
            },
            onTapAddToFav: () {
              print('onTapAddToFav');
            },
            onTap: () {
              navigateTo(AppRoutes.BestSellerBooksdetails, arguments: book);
            },
          );
        },
      ),
    );
  }
}
