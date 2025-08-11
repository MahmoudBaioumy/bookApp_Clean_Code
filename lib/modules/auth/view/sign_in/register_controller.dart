// 📁 lib/modules/auth/controllers/register_controller.dart

import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/auth/data/request/register_request.dart';
import 'package:flustra_template/modules/auth/logic/auth_cubit.dart';
import 'package:flutter/material.dart';

/// RegisterController can be used to manage state and notify listeners about changes.
class RegisterController extends ChangeNotifier {
  // ========================== Constructor ==========================
  RegisterController();

  // ========================== 🔒 Private variables 🔒 ==========================
  bool _isPasswordVisible = false;
  final AuthCubit _cubit = AuthCubit.i;

  // ========================== 🗝️ Public variables 🗝️ ==========================
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool get isPasswordVisible => _isPasswordVisible;

  // ========================== 🔥 initialization 🔥 ==========================
  void init() {
    // Any init logic
  }

  // ========================== 🌍 Public methods and events 🌍 ==========================

  void onTapRegister() async {
    var registerRequest = RegisterRequest(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
      city: city.text.trim(),
      phone: phone.text.trim(),
    );

    var res = await _cubit.register(registerRequest: registerRequest);
    res.fold(
      (l) => l.showToast(),
      (r) {
        AppSessionManager.updateUser(r);
        navigateTo(AppRoutes.login);
      },
    );
  }

  void onTapLogin() {
    navigateTo(AppRoutes.login);
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // ========================== 🔒 Private methods 🔒 ==========================

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
