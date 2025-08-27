import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/modules/best_seller/view/best_seller_detials.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flutter/material.dart';

class BestSellerBookItemWidget extends StatefulWidget {
  final Products book;
  final Function()? onTap;
  final Future<void> Function()? onTapAddToCart;
  final Future<void> Function()? onTapAddToFav;
  final bool initiallyFav;

  BestSellerBookItemWidget({
    super.key,
    required this.book,
    this.onTap,
    this.onTapAddToCart,
    this.onTapAddToFav,
    this.initiallyFav = false,
  });

  @override
  State<BestSellerBookItemWidget> createState() => _BestSellerBookItemWidgetState();
}

class _BestSellerBookItemWidgetState extends State<BestSellerBookItemWidget> {
  bool isLoadingCart = false;
  bool isLoadingFav = false;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    isFav = widget.initiallyFav;
  }

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
          '${widget.book.discount}%',
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
          child: Image.network(widget.book.image ?? '', height: 120, width: 80, fit: BoxFit.cover),
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
        Text(widget.book.name ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.book.category ?? '', style: const TextStyle(color: Colors.grey)),
        Row(
          children: [
            Text('${widget.book.price} L.E', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
            const SizedBox(width: 8),
            Text('${widget.book.priceAfterDiscount} L.E', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          InkWell(onTap: widget.onTap, child: _buildBookImage()),
          const SizedBox(width: 12),
          Expanded(child: _buildPriceInfo()),
          Column(
            children: [buildIconButtonAddFav(), SizedBox(height: 50), buildIconButtonAddCart()],
          )
        ],
      ),
    );
  }

// -------------------------- buildIconButtonAddFav -------------------------- //
  IconButton buildIconButtonAddFav() {
    return IconButton(
      onPressed: () async {
        await controller.toggleFavourite(widget.book.id ?? 0);
        setState(() {}); // تحدث الـ UI بعد العملية
      },
      icon: Icon(
        controller.favoriteBookIds.contains(widget.book.id ?? 0)
            ? Icons.favorite
            : Icons.favorite_border,
        color: controller.favoriteBookIds.contains(widget.book.id ?? 0)
            ? Colors.red
            : null,
      ),
    );
  }


// -------------------------- buildIconButtonAddCart -------------------------- //
  IconButton buildIconButtonAddCart() {
    return IconButton(
      onPressed: () async {
        // -------------------------- for check to not spam the api request -------------------------- //
        if (isLoadingCart) return;
        isLoadingCart = true;
        setState(() {});
        await widget.onTapAddToCart?.call();
        isLoadingCart = false;
        setState(() {});
      },
      icon: isLoadingCart
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ))
          : const Icon(Icons.shopping_cart_outlined),
    );
  }
}
