import 'dart:io';

import 'package:dio/dio.dart';

class ProfileUpdateRequest {
  final String name;
  final String email;
  final String city;
  final String phone;
  final File? image;

  ProfileUpdateRequest({
    required this.name,
    required this.email,
    required this.city,
    required this.phone,
    this.image,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "city": city,
      "phone": phone,
    };

    if (image != null) {
      data["image"] = MultipartFile.fromFileSync(image!.path, filename: image!.path.split("/").last);
    }

    return data;
  }
}
