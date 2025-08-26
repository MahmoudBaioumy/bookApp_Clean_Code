import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/constants/app_api.dart';
import 'package:flustra_template/core/data/network/response/default_response.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/Profile/data/request/edit_profile.dart';
import 'package:flustra_template/modules/Profile/data/request/send_massage_request.dart';
import 'package:flustra_template/modules/Profile/data/response/edit_profile.dart';
import 'package:flustra_template/modules/Profile/data/response/profile_response.dart';
import '../../../core/common/error_handler/failure.dart';

abstract class ProfileRepo {
  Future<Either<Failure, GetProfileResponse>> getProfile();

  Future<Either<Failure, DefaultResponse>> sendMessage({
    required ContactRequest request,
  });

  Future<Either<Failure, EditProfile>> updateProfile({required ProfileUpdateRequest request});
}

class ProfileImp implements ProfileRepo {
  // -------------------------- GetProfile --------------------------
  @override
  Future<Either<Failure, GetProfileResponse>> getProfile() async {
    return await handleResponse(
      endPoint: ApiConstants.profile.getProfile,
      asObject: (e) => GetProfileResponse.fromJson(e),
      method: DioMethod.get,
      headers: {
        'Authorization': 'Bearer ${AppSessionManager.token}',
      },
    );
  }

  @override
  Future<Either<Failure, DefaultResponse>> sendMessage({required ContactRequest request}) async {
    return await handleResponse(
      endPoint: ApiConstants.profile.contactUs,
      asObject: (e) => DefaultResponse.fromJson(e),
      method: DioMethod.post,
      data: request.toJson(),
    );
  }

  // -------------------------- UpdateProfile --------------------------
  @override
  Future<Either<Failure, EditProfile>> updateProfile({required ProfileUpdateRequest request}) async {
    return await handleResponse(
        endPoint: ApiConstants.profile.UpdateProfile,
        asObject: (e) => EditProfile.fromJson(e),
        method: DioMethod.post,
        data: request.toJson(),
        headers: {
          'Authorization': 'Bearer ${AppSessionManager.token}',
          'Content-Type': 'application/json',
        });
  }
}
