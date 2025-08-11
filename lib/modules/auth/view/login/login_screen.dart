// 📁 lib/modules/auth/views/screens/login_screen.dart

import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_validators.dart';
import 'package:flustra_template/modules/auth/logic/auth_cubit.dart';
import 'package:flustra_template/modules/auth/view/login/login_controller.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static final String name = AppRoutes.login;

  static void navigateToMe() => navigateTo(name);

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final LoginController _controller = LoginController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _controller.formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Center(child: Image.asset(AppAssetsImages.logo.logo, height: 200)),
                  const SizedBox(height: 16),
                  Text(AppStrings.login.tx(),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.primary,
                            fontSize: 40,
                          )),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(AppStrings.dontHaveAccount.tx(), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary)),
                      TextButton(
                        onPressed: _controller.onTapRegister,
                        child: Text(
                          AppStrings.register.tx(),
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  // -------------------------- Email Field -------------------------- //
                  TextFormField(
                    controller: _controller.emailController,
                    validator: AppValidators.email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      hintText: AppStrings.email.tx(),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // -------------------------- Password Field -------------------------- //
                  TextFormField(
                    controller: _controller.passwordController,
                    obscureText: !_controller.isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      hintText: AppStrings.password.tx(),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        onPressed: _controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -------------------------- Login Button --------------------------
                  BlockBuilderWidget<AuthCubit, AuthCubitTypes>(
                    types: const [AuthCubitTypes.login],
                    loading: (_) => const Center(child: CircularProgressIndicator()),
                    body: (_) => buildSizedBox(),
                    error: (_) => buildSizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
// -------------------------- Build SizeBox ButtonLogin  -------------------------- //
  SizedBox buildSizedBox() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
        onPressed: _controller.onTapLogin,
        child: Text(AppStrings.login.tx()),
      ),
    );
  }
}
