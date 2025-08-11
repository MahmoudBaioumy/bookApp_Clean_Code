import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  // ========================== Constructor ==========================
  ProfileController();

  // ========================== 🔒 Private variables 🔒 ==========================

  // ========================== 🗝️ Public variables 🗝️ ==========================
  String? name;
  String? email;
  String? phone;
  String? city;
  String? address;
  String? profileImage;

  // ========================== 🔥 initialization 🔥 ==========================
  void init() {
    // todo: Fetch user data from API
  }

  // ========================== 🌍 Public methods and events 🌍 ==========================
  void onTapEditProfile() {
    // todo: handle edit profile tap
    print("Edit Profile tapped");
  }

// ========================== 🔒 Private methods 🔒 ==========================
}
