// 📁 lib/modules/auth/views/screens/register_screen.dart

import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_validators.dart';
import 'package:flustra_template/modules/auth/logic/auth_cubit.dart';
import 'package:flustra_template/modules/auth/view/sign_in/register_controller.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String name = AppRoutes.registerScreen;

  static void navigateToMe() => navigateTo(name);

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final RegisterController _controller = RegisterController();

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
                  Center(child: Image.asset(AppAssetsImages.logo.logo, height: 100)),
                  const SizedBox(height: 16),
                  Text(AppStrings.joinUs.tx(), style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.primary)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.alreadyHaveAccount.tx()),
                      TextButton(
                        onPressed: _controller.onTapLogin,
                        child: Text(AppStrings.login.tx()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // -------------------------- Name Field -------------------------- //
                  TextFormField(
                    validator: AppValidators.fullName,
                    controller: _controller.nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      hintText: AppStrings.name.tx(),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // -------------------------- Email Field -------------------------- //
                  TextFormField(
                    validator: AppValidators.email,
                    controller: _controller.emailController,
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
                    validator: (p) => AppValidators.passwordComplex(p),
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
                  const SizedBox(height: 12),

                  // -------------------------- Confirm Password Field -------------------------- //
                  TextFormField(
                    controller: _controller.confirmPasswordController,
                    validator: (P) => AppValidators.confirmPassword(_controller.passwordController.text, P),
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      hintText: AppStrings.confirmPassword.tx(),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // -------------------------- phone -------------------------- //
                  TextFormField(
                    validator: AppValidators.phone,
                    controller: _controller.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      hintText: AppStrings.phone.tx(),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // -------------------------- city -------------------------- //
                  TextFormField(
                    validator: AppValidators.city,
                    controller: _controller.city,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      hintText: AppStrings.city.tx(),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -------------------------- Register Button --------------------------
                  BlockBuilderWidget<AuthCubit, AuthCubitTypes>(
                    types: const [AuthCubitTypes.register],
                    loading: (_) => const Center(child: CircularProgressIndicator()),
                    body: (_) => buildSizedBoxButton(),
                    error: (_) => buildSizedBoxButton(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBoxButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _controller.onTapRegister,
        child: Text(AppStrings.register.tx()),
      ),
    );
  }
}
