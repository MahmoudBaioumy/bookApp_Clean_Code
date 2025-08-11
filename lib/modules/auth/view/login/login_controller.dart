// 📁 lib/modules/auth/controllers/login_controller.dart

import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/auth/logic/auth_cubit.dart';
import 'package:flutter/material.dart';

/// LoginController can be used to manage state and notify listeners about changes.
class LoginController extends ChangeNotifier {
  // ========================== Constructor ==========================
  LoginController();

  // ========================== 🔒 Private variables 🔒 ==========================
  bool _isPasswordVisible = false;
  final AuthCubit _cubit = AuthCubit.i;

  // ========================== 🗝️ Public variables 🗝️ ==========================
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  bool get isPasswordVisible => _isPasswordVisible;

  // ========================== 🔥 initialization 🔥 ==========================
  void init() {}

  // ========================== 🌍 Public methods and events 🌍 ==========================

  void onTapLogin() async {
    var res = await _cubit.login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    res.fold(
      (l) => l.showToast(),
      (r){
        AppSessionManager.updateUser(r);
        navigateTo(AppRoutes.navBarView,type: NavigationType.finish);
      },
    );
  }

  void onTapRegister() {
    navigateTo(AppRoutes.registerScreen);
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // ========================== 🔒 Private methods 🔒 ==========================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
