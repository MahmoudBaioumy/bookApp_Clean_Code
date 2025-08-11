import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_defults_size.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flutter/material.dart';
 // Assuming this import

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          const SizedBox(height: AppDefaults.padding / 2),
          Text(
            product.name??'',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 12
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.category??'',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)
          ),
          const Spacer(),
          _buildPriceInfo(context),
        ],
      ),
    );
  }

  // -------------------------- Product Image --------------------------
  Widget _buildProductImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: AppDefaults.borderRadius,
          child: Image.network(
            product.image??'',
            height: 160,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: AppDefaults.padding / 2,
          left: AppDefaults.padding / 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Text(
              '${product.discount}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------- Price Info --------------------------
  Widget _buildPriceInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${product.price??''} L.E',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        Text(
          '${product.priceAfterDiscount ??''} L.E',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}