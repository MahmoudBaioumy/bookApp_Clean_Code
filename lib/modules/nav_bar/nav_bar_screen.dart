
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/modules/Profile/view/main_profile_view.dart';
import 'package:flustra_template/modules/Profile/view/profile_view.dart';
import 'package:flustra_template/modules/Wishist/view/wishist_view.dart';
import 'package:flustra_template/modules/cart/view/cart_view.dart';
import 'package:flustra_template/modules/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';



class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

int _selectedIndex = 0;
final List _pages = [
  const HomeView(),
  const CartScreen(),
  const WishistView(),
  const MainProfileView(),
];

class _NavBarViewState extends State<NavBarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2)),
          ],
        ),
        child: GNav(
          curve: Curves.bounceIn,
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 20,
          gap: 3,
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.primary,
          textStyle: TextTheme.of(context).bodyMedium,
          tabs: [
            GButton(
              iconSize: 28,
              icon: Icons.home,
              iconColor: Colors.grey,
            ),
            GButton(
              icon: Icons.shopping_cart_outlined,
              iconColor: Colors.grey,
            ),
            GButton(
              iconSize: 28,
              icon: Icons.favorite_border,
              iconColor: Colors.grey,
            ),
            GButton(
              iconSize: 29,
              icon: Icons.person,
              iconColor: Colors.grey,
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}