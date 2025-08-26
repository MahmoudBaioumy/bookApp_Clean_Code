import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/Profile/view/widgets/build_container_header_main_profile_view.dart';
import 'package:flustra_template/modules/Profile/view/widgets/build_row_cart_item.dart';
import 'package:flutter/material.dart';

class MainProfileView extends StatelessWidget {
  const MainProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              BuildContainerHeaderMainProfileView(
                onTap: () {
                  navigateTo(AppRoutes.profile);
                },
              ),
              Divider(
                thickness: 0.5,
                endIndent: 20,
                indent: 20,
              ),
              SizedBox(
                height: 50,
              ),
              BuildRowCartItem(
                title: AppStrings.contactUsTitle.tx(),
                iconCircle: Icons.contact_support_outlined,
                iconContainer: Icons.arrow_forward_ios_outlined,
                onTap: () {
                  navigateTo(AppRoutes.ContactSupport);
                },
              ),
              SizedBox(
                height: 50,
              ),
              BuildRowCartItem(
                title: AppStrings.lang.tx(),
                iconCircle: Icons.language,
                iconContainer: Icons.arrow_forward_ios_outlined,
                onTap: () {
                  navigateTo(AppRoutes.languageSelectionScreen);
                },
              ),
              SizedBox(
                height: 50,
              ),
              BuildRowCartItem(
                title: AppStrings.about.tx(),
                iconCircle: Icons.warning_amber_rounded,
                iconContainer: Icons.arrow_forward_ios_outlined,
                onTap: () {},
              ),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      AppSessionManager.updateUser(null);
                      navigateTo(AppRoutes.login, type: NavigationType.finish);
                    },
                    child: Text(
                      "Logout",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.background),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
