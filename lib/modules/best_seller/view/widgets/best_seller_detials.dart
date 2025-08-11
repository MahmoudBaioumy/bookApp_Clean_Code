import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flutter/material.dart';


class BestSellerBooksdetails extends StatefulWidget {
  static const String name = AppRoutes.BestSellerBooksdetails;
  static void navigateToMe() => navigateTo(name);
  final Products? bookdetails;
  const BestSellerBooksdetails({super.key, required this.bookdetails});

  @override
  State<BestSellerBooksdetails> createState() => _BestSellerBooksdetailsState();
}


class _BestSellerBooksdetailsState extends State<BestSellerBooksdetails> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.bookdetails?.name??''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.bookdetails?.image??'',
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.bookdetails?.name??'',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                widget.bookdetails?.category??'',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '${widget.bookdetails?.price} L.E',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.bookdetails?.priceAfterDiscount} L.E',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Description:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                widget.bookdetails?.description??'',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
             SizedBox(height: 50,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Book added to cart!')),
                    );
                  },
                  child: const Text('Add To Cart'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
