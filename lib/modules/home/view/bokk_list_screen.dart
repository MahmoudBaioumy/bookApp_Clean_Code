import 'package:flutter/material.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flustra_template/modules/best_seller/view/widgets/bestSeller_bookItem_widget.dart';

class BooksListScreen extends StatelessWidget {
  final String title;
  final List<Products> products;

  const BooksListScreen({
    super.key,
    required this.title,
    required this.products,
  });

  @override
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
            onTap: () {
              // navigateTo details or do whatever
            },
          );
        },
      ),
    );
  }
}
