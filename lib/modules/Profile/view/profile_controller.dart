import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/Profile/data/request/send_massage_request.dart';
import 'package:flustra_template/modules/Profile/data/response/profile_response.dart';
import 'package:flustra_template/modules/Profile/logic/profile_cubit.dart';
import 'package:flustra_template/modules/Profile/view/widgets/bottom_sheet_edit_profile.dart';
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  // ========================== Constructor ==========================
  ProfileController();

  // ========================== 🔒 Private variables 🔒 ==========================
  ProfileCubit _profileCubit = ProfileCubit.i;
  profileData _profileResponse = profileData();

  // ========================== 🗝️ Public variables 🗝️ ==========================
  String? name;
  String? email;
  String? phone;
  String? city;
  String? address;
  String? profileImage;

  // -------------------------- ContactUs --------------------------//
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController writeMassageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  // ========================== 🔥 initialization 🔥 ==========================
  void init() {
    loadProfile();
  }

  // ========================== 🔥 loadProfile data 🔥 ========================== //

  Future<void> loadProfile() async {
    final result = await _profileCubit.getProfile();

    result.fold(
      (failure) {
        print("Failed to load profile: ${failure.message}");
      },
      (response) {
        name = response.data?.name ?? '';
        email = response.data?.email ?? '';
        phone = response.data?.phone ?? '';
        city = response.data?.city ?? '';
        address = response.data?.address ?? '';
        profileImage = response.data?.image ?? '';
        notifyListeners();
      },
    );
  }

  // ========================== 🌍 Public methods and events 🌍 ==========================
  void onTapEditProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => EditProfileBottomSheet(),
    );
  }

  void onTapSendMassage() async {
    if (!formKey.currentState!.validate()) return;
    var res = await _profileCubit.sendMassage(
      request: ContactRequest(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        subject: subjectController.text.trim(),
        message: writeMassageController.text.trim(),
      ),
    );

    res.fold(
      (l) => l.showToast(),
      (r) {
        if (r.message != null && r.message!.isNotEmpty) {
          AppBotToast.show(r.message!, type: ToastType.success);
        }

        nameController.clear();
        emailController.clear();
        subjectController.clear();
        writeMassageController.clear();
      },
    );
  }

// ========================== 🔒 Private methods 🔒 ==========================
}
