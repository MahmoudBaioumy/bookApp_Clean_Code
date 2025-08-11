import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _goToNextScreen();
    super.initState();
  }

  Future<void> _goToNextScreen() async {
    int ms = 3000;
    await Future.delayed(Duration(milliseconds: ms));
    if (AppSessionManager.amILogin) {
      navigateTo(AppRoutes.navBarView,type: NavigationType.finish);
      return ;
    }
    navigateTo(AppRoutes.login);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text("Booky Store",
            style: TextStyle(color: AppColors.background, fontSize: 50, fontWeight: FontWeight.bold, fontFamily: 'cairo'),
          )),
        ],
      ),
    );
  }
}
