import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/uti/shimmer_templates.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/Profile/logic/profile_cubit.dart';
import 'package:flustra_template/modules/Profile/view/widgets/build_info_card.dart';
import 'package:flutter/material.dart';

import 'profile_controller.dart';

class ProfileView extends StatefulWidget {
  static const String name = AppRoutes.profile;

  static void navigateToMe() => navigateTo(name);

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final ProfileController _controller = ProfileController();

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

  // -------------------------- Body --------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: _buildColumnProfileListener(),
      ),
    );
  }

  Widget _buildColumnProfileListener() {
    return BlockBuilderWidget<ProfileCubit, ProfileCubitTypes>(
      types: const [ProfileCubitTypes.getProfile],
      loading: (_) => buildColumnBody(isLoading: true),
      body: (_) => buildColumnBody(isLoading: false),
      error: (_) => buildColumnBody(isLoading: false),
    );
  }

  Widget buildColumnBody({required bool isLoading}) {
    if (isLoading) {
      return Column(
        children: List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: ShimmerTemplates.postCard(),
          ),
        ),
      );
    }
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _buildHeader(),
            Positioned(
              bottom: -70,
              left: 0,
              right: 0,
              child: _buildProfileImage(),
            ),
          ],
        ),
        const SizedBox(height: 70),
        BuildInfoCard(
          icon: Icons.person,
          title: AppStrings.name.tx(),
          value: _controller.name ?? '',
        ),
        BuildInfoCard(
          icon: Icons.email,
          title: AppStrings.email.tx(),
          value: _controller.email ?? '',
        ),
        BuildInfoCard(
          icon: Icons.phone,
          title: AppStrings.phone.tx(),
          value: _controller.phone ?? '',
        ),
        BuildInfoCard(
          icon: Icons.location_city,
          title: AppStrings.city.tx(),
          value: _controller.city ?? '',
        ),
        const SizedBox(height: 24),
        _buildEditButton(),
        const SizedBox(height: 24),
      ],
    );
  }

  // -------------------------- Header --------------------------
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, bottom: 30),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            Text(
              AppStrings.profile.tx(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
                onPressed: () {
                  AppSessionManager.updateUser(null);
                  navigateTo(AppRoutes.login, type: NavigationType.finish);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  // -------------------------- Profile Image --------------------------
  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 50,
      child: ClipOval(
        child: _controller.profileImage != null
            ? Image.network(
                _controller.profileImage!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : Image.asset(
                AppAssetsImages.logo.logo,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  // -------------------------- Edit Button --------------------------
  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () => _controller.onTapEditProfile(context),
          child: Text(
            AppStrings.editProfile.tx(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
