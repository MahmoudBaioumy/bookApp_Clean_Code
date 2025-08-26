import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/Wishist/view/widgets/book_item_widget.dart';
import 'package:flustra_template/modules/Wishist/view/wishist_controller.dart';
import 'package:flustra_template/modules/cart/view/widgets/empty_screen_cart.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_strings_localizations.dart';

class WishistView extends StatefulWidget {
  static const String name = AppRoutes.wishist;

  static void navigateToMe() => navigateTo(name);

  const WishistView({super.key});

  @override
  State<WishistView> createState() => _WishistViewState();
}

class _WishistViewState extends State<WishistView> {
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final WishistController _controller = WishistController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_refresh);
    _controller.init();
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  // -------------------------- Build --------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _controller.FavItems.isEmpty
            ? Center(
                child: EmptyScreen(
                  title: AppStrings.noFavorites.tx(),
                  image: AppAssetsImages.other.emptyFavorite,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _controller.FavItems.length,
                itemBuilder: (context, index) {
                  final book = _controller.FavItems[index];
                  return BookItemWidget(
                    onRemove: () => _controller.onTapRemove(index),
                    product: book,
                  );
                },
              ),
      ),
    );
  }
}
