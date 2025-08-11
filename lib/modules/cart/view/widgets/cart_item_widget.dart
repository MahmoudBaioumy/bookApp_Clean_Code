import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/modules/cart/data/cart_response.dart';
import 'package:flustra_template/modules/cart/view/cart_controller.dart';
import 'package:flutter/material.dart';


class CartItemWidget extends StatelessWidget {
  final CartItems item;
  final CartController controller;

  const CartItemWidget({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.itemProductImage ?? '',
                height: 90,
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image), // optional fallback
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.itemProductName??'', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          controller.onIncreaseQuantity(item.itemId??0);
                        }

                      ),
                      Text('${item.itemQuantity}', style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          controller.onDecreaseQuantity(item.itemId??0);
                        }

                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('${item.itemProductPrice} L.E',
                          style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                      const SizedBox(width: 8),
                      Text('${item.itemProductPriceAfterDiscount} L.E',
                          style:  TextStyle(color: AppColors.primary)),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                 controller.onRemoveItem(item.itemId??0);
              }

            ),
          ],
        ),
      ),
    );
  }
}
