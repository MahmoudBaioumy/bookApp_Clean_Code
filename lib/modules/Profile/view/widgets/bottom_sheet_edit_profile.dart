import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/Profile/data/request/edit_profile.dart';
import 'package:flustra_template/modules/Profile/logic/profile_cubit.dart';
import 'package:flutter/material.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final TextEditingController nameController = TextEditingController(text: AppSessionManager.user?.name);
  final TextEditingController EmailController = TextEditingController(text: AppSessionManager.user?.email);
  final TextEditingController cityController = TextEditingController(text: AppSessionManager.user?.city);
  final TextEditingController phoneController = TextEditingController(text: AppSessionManager.user?.phone);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.editProfile.tx(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(controller: nameController, decoration: InputDecoration()),
            SizedBox(height: 10),
            TextField(controller: EmailController, decoration: InputDecoration()),
            SizedBox(height: 10),
            TextField(controller: cityController, decoration: InputDecoration()),
            SizedBox(height: 10),
            TextField(controller: phoneController, decoration: InputDecoration()),
            SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: buildElevatedButtonEditProfile(context),
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButtonEditProfile(BuildContext context) {
    return ElevatedButton(
              onPressed: () async {
                final request = ProfileUpdateRequest(
                    name: nameController.text.trim(), email: EmailController.text.trim(), city: cityController.text.trim(), phone: phoneController.text.trim());
                final res=await ProfileCubit.i.updateProfile(request: request);
                res.fold(
                      (failure) {

                    print("Update Failed: ${failure.message}");
                  },
                      (r) {
                        AppSessionManager.updateUserOnly(r.data);
                        AppBotToast.show(r.message!, type: ToastType.success);
                    Navigator.pop(context);
                  },
                );
              },
              child: Text("Save"),
            );
  }
}
