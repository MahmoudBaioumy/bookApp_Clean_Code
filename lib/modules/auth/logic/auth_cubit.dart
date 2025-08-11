// app/modules/auth/controller/auth_cubit.dart

import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/auth/data/auth_repo.dart';
import 'package:flustra_template/modules/auth/data/request/register_request.dart';
import '../../../core/get_it/get_it.dart';
import '../data/responses/auth_response.dart';

enum AuthCubitTypes {
  none,
  login,
  register,
}

class AuthCubit extends BaseCubit<AuthCubitTypes> {
  final AuthRepo _repo;

  AuthCubit(this._repo) : super(AuthCubitTypes.none);

  static AuthCubit get i => getIt<AuthCubit>();

  // ========================== 🔥 login 🔥 ========================== //
  BaseEitherResponse<AuthResposne> login({
    required String email,
    required String password,
  }) async {
    return await fastFire(
      type: AuthCubitTypes.login,
      fun: () => _repo.login(email: email, password: password),
      onSuccess: (x) {},
      onFailure: (failure) => failure.printInfo("login"),
    );
  }

  // ========================== 🔥 register 🔥 ========================== //
  BaseEitherResponse<AuthResposne> register({
    required RegisterRequest registerRequest,
  }) async {
    return await fastFire(
      type: AuthCubitTypes.register,
      fun: () => _repo.register(registerRequest: registerRequest),
      onSuccess: (x) {},
      onFailure: (failure) => failure.printInfo("register"),
    );
  }
}
