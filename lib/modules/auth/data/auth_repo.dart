import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';
import 'package:flustra_template/modules/auth/data/request/register_request.dart';
import 'package:flustra_template/modules/auth/data/responses/auth_response.dart';

import '../../../core/constants/app_api.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthResposne>> login({required String email, required String password});

  Future<Either<Failure, AuthResposne>> register({required RegisterRequest registerRequest});
}

class AuthRepoImpl implements AuthRepo {
  @override
  // -------------------------- Login -------------------------- //
  Future<Either<Failure, AuthResposne>> login({
    required String email,
    required String password,
  }) async {
    return await handleResponse(
      endPoint: ApiConstants.auth.login,
      asObject: (e) => AuthResposne.fromJson(e),
      method: DioMethod.post,
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  // -------------------------- register -------------------------- //
  @override
  Future<Either<Failure, AuthResposne>> register({
    required RegisterRequest registerRequest,
  }) async {
    return await handleResponse(
      endPoint: ApiConstants.auth.register,
      asObject: (e) => AuthResposne.fromJson(e),
      method: DioMethod.post,
      data: await registerRequest.toData(),
    );
  }
}
