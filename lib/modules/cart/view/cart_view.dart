import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/uti/shimmer_templates.dart';
import 'package:flustra_template/core/helper/widgets/custom_smart_refresher.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/cart/logic/cart_cubit.dart';
import 'package:flustra_template/modules/cart/view/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'cart_controller.dart';

class CartScreen extends StatefulWidget {
  static const String name = AppRoutes.cartScreen;

  static void navigateToMe() => navigateTo(name);

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final CartController _controller = CartController();
  final CartCubit _cubit = CartCubit.i;

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Column(
            children: [
              Expanded(flex: 7, child: _buildCartBookListener()),
              if (_controller.cartItems.isNotEmpty)
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: AppColors.primary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'total price: ${_controller.totalPrice} L.E',
                          style: const TextStyle(color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: _controller.onTapCheckout,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                          child: Text('CheckOut', style: TextStyle(color: AppColors.primary)),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }


// -------------------------- _buildListCartView -------------------------- //

  Widget _buildCartBookListener() {
    return BlockBuilderWidget<CartCubit, CartCubitTypes>(
      types: const [CartCubitTypes.getCart],
      loading: (_) => _buildListCartView(isLoading: true),
      body: (_) => _buildListCartView(isLoading: false),
      error: (_) => _buildListCartView(isLoading: false),
    );
  }

  Widget _buildListCartView({required bool isLoading}) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: isLoading ? 5 : _controller.cartItems.length,
      itemBuilder: (context, index) {
        if (isLoading) {
          return SizedBox(
            width: 150,
            child: ShimmerTemplates.productCard(),
          );
        }
        return CartItemWidget(
          item: _controller.cartItems[index],
          controller: _controller,
        );
      },
    );
  }
}
