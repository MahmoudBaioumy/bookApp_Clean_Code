import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_validators.dart';
import 'package:flustra_template/modules/Profile/logic/profile_cubit.dart';
import 'package:flustra_template/modules/Profile/view/profile_controller.dart';
import 'package:flustra_template/modules/Profile/view/widgets/build_containerTypeContact.dart';
import 'package:flutter/material.dart';

class ContactSupport extends StatefulWidget {
  const ContactSupport({super.key});

  static const String name = AppRoutes.ContactSupport;

  static void navigateToMe() => navigateTo(name);

  @override
  State<ContactSupport> createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {
  @override
  void initState() {
    super.initState();

    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final ProfileController controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.primary,
        ),
        title: Text(
          AppStrings.contactUsTitle.tx(),
          style: TextStyle(color: AppColors.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Image.asset(AppAssetsImages.other.contact)),
                SizedBox(
                  height: 5,
                ),
                BuildContainerTypeContact(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.15, color: AppColors.primary),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // -------------------------- name -------------------------- //
                      TextFormField(
                        controller: controller.nameController,
                        validator: AppValidators.username,
                        decoration: InputDecoration(
                          hintText: AppStrings.name.tx(),
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      // -------------------------- email -------------------------- //
                      TextFormField(
                        controller: controller.emailController,
                        validator: AppValidators.email,
                        decoration: InputDecoration(
                          hintText: AppStrings.email.tx(),
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: controller.subjectController,
                        validator: AppValidators.username,
                        decoration: InputDecoration(
                          hintText: AppStrings.subject.tx(),
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: controller.writeMassageController,
                        maxLines: 4,
                        validator: AppValidators.username,
                        decoration: InputDecoration(
                          hintText: AppStrings.writeMessage.tx(),
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      BlockBuilderWidget<ProfileCubit, ProfileCubitTypes>(
                        types: const [ProfileCubitTypes.sendMassage],
                        loading: (_) => Center(child: CircularProgressIndicator()),
                        body: (_) => buildCenterButtonSend(),
                        error: (_) => buildCenterButtonSend(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// -------------------------- buildCenterButtonSend -------------------------- //
  Center buildCenterButtonSend() {
    return Center(
      child: SizedBox(
        width: 150,
        child: ElevatedButton(
          onPressed: () => controller.onTapSendMassage(),
          child: Text(AppStrings.send.tx()),
        ),
      ),
    );
  }
}
