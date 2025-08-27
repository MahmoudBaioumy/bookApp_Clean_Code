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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.loadFavoriteBooks(), // fetch المفضلة
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        final favoriteBookIds = controller.favoriteBookIds;

        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
              final book = products[index];
              final isAlreadyFav = favoriteBookIds.contains(book.id ?? 0);

              return BestSellerBookItemWidget(
                book: book,
                initiallyFav: isAlreadyFav,
                onTapAddToCart: () async {
                  await controller.onTapCart(book.id ?? 0);
                },
                onTapAddToFav: () async {
                  await controller.toggleFavourite(book.id ?? 0);
                },
                onTap: () {
                  navigateTo(AppRoutes.BestSellerBooksdetails, arguments: book);
                },
              );
            },
          ),
        );
      },
    );
  }

}
