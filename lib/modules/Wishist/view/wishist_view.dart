import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/uti/shimmer_templates.dart';
import 'package:flustra_template/core/helper/widgets/custom_smart_refresher.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/Wishist/logic/fav_cubit.dart';
import 'package:flustra_template/modules/Wishist/view/widgets/book_item_widget.dart';
import 'package:flustra_template/modules/Wishist/view/wishist_controller.dart';
import 'package:flustra_template/modules/cart/view/widgets/empty_screen_cart.dart';
import 'package:flutter/material.dart';

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
final _wishlistCubit = WishlistCubit.i;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomSmartRefresher(
        isLastPage: () => true,
        onLoadMore: () async {},
        onRefresh: () async {
            await Future.wait([
              _wishlistCubit.getWishlist(),
            ]);
          },
        child: Scaffold(
          body: CustomSmartRefresher(
              isLastPage: () => true,
              onLoadMore: () async {},
              onRefresh: () async {
                await Future.wait([
                  _wishlistCubit.getWishlist(),
                ]);
              },
              child: _buildFavouriteBookListener()
          ),
        ),
      ),
    );
  }

// -------------------------- _buildFavouriteBookListener -------------------------- //
  Widget _buildFavouriteBookListener() {
    return BlockBuilderWidget<WishlistCubit, WishlistCubitTypes>(
      types: const [WishlistCubitTypes.getWishlist],
      loading: (_) => _buildListCartView(isLoading: true),
      body: (_) => _buildListCartView(isLoading: false),
      error: (_) => _buildListCartView(isLoading: false),
    );
  }

// -------------------------- _buildListCartView -------------------------- //
  Widget _buildListCartView({required bool isLoading}) {
    final pro = _controller.FavItems;
    if (!isLoading && pro.isEmpty) {
      return Center(
          child: EmptyScreen(
        title: 'Your cart is empty',
        image: AppAssetsImages.other.emptyFavorite,
      ));
    }
    return ListView.separated(
      padding: EdgeInsets.all(10),
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: isLoading ? 5 : _controller.FavItems.length,
      itemBuilder: (context, index) {
        if (isLoading) {
          return SizedBox(
            width: 150,
            child: ShimmerTemplates.productCard(),
          );
        }
        final book = _controller.FavItems[index];
        return BookItemWidget(
          onAddCart: _controller.onTapAddCart,
          onRemove: ()
          async{
            final res=await WishlistCubit.i.removeFromWishlist(bookId: book.id!);
            res.fold((failure) => failure.showToast(), (r) {
              AppBotToast.show("Removed from wishlist", type: ToastType.success);
              _controller.onTapRemove(index);
            });
          },
          product: book,
        );
      },
    );
  }
}
