import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
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
        child: Column(
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
            _buildInfoCard(
              icon: Icons.person,
              title: AppStrings.name.tx(),
              value: _controller.name ?? '',
            ),
            _buildInfoCard(
              icon: Icons.email,
              title: AppStrings.email.tx(),
              value: _controller.email ?? '',
            ),
            _buildInfoCard(
              icon: Icons.phone,
              title: AppStrings.phone.tx(),
              value: _controller.phone ?? '',
            ),
            _buildInfoCard(
              icon: Icons.location_city,
              title: AppStrings.city.tx(),
              value: _controller.city ?? '',
            ),
            _buildInfoCard(
              icon: Icons.location_on,
              title: AppStrings.address.tx(),
              value: _controller.address ?? '',
            ),
            const SizedBox(height: 24),
            _buildEditButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // -------------------------- Header --------------------------
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.profile.tx(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  // -------------------------- Profile Image --------------------------
  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 50,
      backgroundImage:
          _controller.profileImage != null ? NetworkImage(_controller.profileImage!) : AssetImage(AppAssetsImages.logo.logo) as ImageProvider,
    );
  }

  // -------------------------- Info Card --------------------------
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    value.isNotEmpty ? value : "-",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
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
          onPressed: _controller.onTapEditProfile,
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
