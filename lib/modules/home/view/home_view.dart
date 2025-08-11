import 'package:carousel_slider/carousel_slider.dart';
import 'package:flustra_template/core/constants/app_defults_size.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/uti/shimmer_templates.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flustra_template/core/helper/widgets/custom_smart_refresher.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/best_seller/logic/best_seller_cubit.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flustra_template/modules/home/view/home_controller.dart';
import 'package:flustra_template/modules/home/view/widgets/product_card_widget.dart';
import 'package:flustra_template/modules/new_arrival/logic/new_arrival_cubit.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String name = AppRoutes.home;

  static void navigateToMe() => navigateTo(name);

  @override
  State<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeView> {
  late final HomeController _HomeController = HomeController();
  final bestSellerCubit _bestSellerCubit = bestSellerCubit.i;
  final newArrivalCubit _newArrivalCubit = newArrivalCubit.i;

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _bestSellerCubit.getBestSellerBooks();
    _newArrivalCubit.getNewArrivalsBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: CustomSmartRefresher(
        isLastPage: () => true,
        onLoadMore: () async {},
        onRefresh: () async {
          // var b1= _bestSellerCubit.getBestSellerBooks();
          // var b2= _newArrivalCubit.getNewArrivalsBooks();
          // -------------------------- this use to not bestseller data await new arrivals data -------------------------- //
          await Future.wait([
            _bestSellerCubit.getBestSellerBooks(),
            _newArrivalCubit.getNewArrivalsBooks(),
          ]);
          // await b1;
          // await b2;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDefaults.padding),
              // -------------------------- _buildCarousel -------------------------- //
              _buildCarousel(),
              // -------------------------- _buildCarouselIndicator -------------------------- //
              _buildCarouselIndicator(),
              const SizedBox(height: AppDefaults.padding * 1),
              // -------------------------- _buildSectionHeader of row bestsellers -------------------------- //
              _buildSectionHeader(
                onTap: () => _HomeController.onTapViewAllBestsellers(_bestSellerCubit.bestSellerBooks ?? []),
                title: AppStrings.bestSeller.tx(),
              ),
              const SizedBox(height: AppDefaults.padding),
              // -------------------------- build bestsellers list  -------------------------- //
              _buildBestsellersListListener(),
              const SizedBox(height: AppDefaults.padding),
              // -------------------------- _buildSectionHeader of row NewArrivals -------------------------- //
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              _buildSectionHeader(
                onTap: () => _HomeController.onTapViewAllNewArrivals(_newArrivalCubit.newArrivalBooks ?? []),
                title: AppStrings.newArrival.tx(),
              ),
              const SizedBox(height: AppDefaults.padding),
              _buildNewArrivalListListener(),
            ],
          ),
        ),
      ),
    );
  }

// -------------------------- appBar -------------------------- //
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          CachedImageWidget(
            height: 40,
            width: 40,
            isCircle: true,
            imageUrl: AppSessionManager.user?.image ?? '',
          ),
          const SizedBox(width: 10),
          Text(
            'Hi, ${AppSessionManager.user?.name ?? 'Guest'}',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ],
      ),
    );
  }

// -------------------------- _buildCarousel -------------------------- //
  Widget _buildCarousel() {
    return CarouselSlider.builder(
      itemCount: _HomeController.carouselImages.length,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            _HomeController.carouselImages[index],
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      },
      options: CarouselOptions(
        height: 160,
        aspectRatio: 10 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, reason) {
          _HomeController.onCarouselPageChanged(index);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

// -------------------------- _buildCarouselIndicator -------------------------- //
  Widget _buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _HomeController.carouselImages.length,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _HomeController.pageIndex == index ? Theme.of(context).primaryColor : Colors.grey[300],
          ),
        ),
      ),
    );
  }

// -------------------------- _buildSectionHeader of row bestsellers -------------------------- //
  Widget _buildSectionHeader({required String title, required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Widget _buildBestsellersListListener() {
    return BlockBuilderWidget<bestSellerCubit, bestSellerCubitTypes>(
      types: const [bestSellerCubitTypes.getBestSellerBooks],
      loading: (_) => _buildBestsellersList(isLoading: true),
      body: (_) => _buildBestsellersList(isLoading: false),
      error: (_) => _buildBestsellersList(isLoading: false),
    );
  }

// -------------------------- _buildBestsellersList -------------------------- //
  Widget _buildBestsellersList({required bool isLoading}) {
    List<Products> products = _bestSellerCubit.bestSellerBooks ?? [];
    return SizedBox(
      height: 240,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemCount: isLoading ? 5 : products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          if (isLoading) {
            return SizedBox(
              width: 150,
              child: ShimmerTemplates.productCard(),
            );
          }
          return ProductCardWidget(product: products[index]);
        },
      ),
    );
  }

  // -------------------------- _buildBestsellersListListener -------------------------- //
  Widget _buildNewArrivalListListener() {
    return BlockBuilderWidget<newArrivalCubit, newArrivalCubitTypes>(
      types: const [newArrivalCubitTypes.getNewArrivalsBooks],
      loading: (_) => _buildNewArrivalList(isLoading: true),
      body: (_) => _buildNewArrivalList(isLoading: false),
      error: (_) => _buildNewArrivalList(isLoading: false),
    );
  }

// -------------------------- buildNewArrivalList -------------------------- //
  Widget _buildNewArrivalList({required bool isLoading}) {
    List<Products> products = _newArrivalCubit.newArrivalBooks ?? [];
    return SizedBox(
      height: 240,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemCount: isLoading ? 5 : products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          if (isLoading) {
            return SizedBox(
              width: 150,
              child: ShimmerTemplates.productCard(),
            );
          }
          return ProductCardWidget(product: products[index]);
        },
      ),
    );
  }
}
