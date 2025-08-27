import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/modules/Wishist/data/response/fav_response.dart';
import 'package:flutter/material.dart';

class BookItemWidget extends StatelessWidget {
  final VoidCallback onRemove;
  final VoidCallback onAddCart;
  final FavData product;

  const BookItemWidget({
    super.key,
    required this.onRemove,
    required this.product, required this.onAddCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image ?? '',
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Book Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    product.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  // Category
                  Text(
                    product.category ?? '',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  // Prices
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        "${product.price ?? 0.toStringAsFixed(1)} L.E",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Favorite Button
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite, color: AppColors.error),
                  onPressed: onRemove,
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: AppColors.primary),
                  onPressed: onAddCart
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
