import 'package:dio/dio.dart';

class RegisterRequest {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? phone;
  String? city;

  RegisterRequest({
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.phone,
    this.city,
  });

  Future<FormData> toData() async => FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'phone': phone,
        'city': city,
      });
}
