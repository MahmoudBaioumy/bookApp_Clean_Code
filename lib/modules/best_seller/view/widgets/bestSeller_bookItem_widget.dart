import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flutter/material.dart';

class BestSellerBookItemWidget extends StatelessWidget {
  final Products book;
  final Function()? onTap;
  BestSellerBookItemWidget({super.key, required this.book, required this.onTap,});


  // -------------------------- Discount Badge --------------------------
  Widget _buildDiscountBadge() {
    return Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '${book.discount}%',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // -------------------------- Book Image --------------------------
  Widget _buildBookImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(book.image??'', height: 120, width: 80, fit: BoxFit.cover),
        ),
        _buildDiscountBadge(),
      ],
    );
  }

  // -------------------------- Price Info --------------------------
  Widget _buildPriceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(book.name??'', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(book.category??'', style: const TextStyle(color: Colors.grey)),
        Row(
          children: [
            Text('${book.price} L.E', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
            const SizedBox(width: 8),
            Text('${book.priceAfterDiscount} L.E', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            _buildBookImage(),
            const SizedBox(width: 12),
            Expanded(child: _buildPriceInfo()),
            Column(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                    )),
                SizedBox(height: 50),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
