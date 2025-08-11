import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/constants/app_api.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/auth/data/responses/auth_response.dart';
import 'package:flustra_template/modules/cart/data/cart_response.dart';

import '../../../../core/helper/shared_methods.dart';


abstract class CartRepo {
  Future<Either<Failure, CartResponse>> getCart();
}

class CartImp implements CartRepo {
  // -------------------------- getCart --------------------------
  @override
  Future<Either<Failure, CartResponse>> getCart() async {
    final token = AppSessionManager.token;
    return await handleResponse(
      endPoint: ApiConstants.cart.getCart,
      method: DioMethod.get,
      asObject: (e) => CartResponse.fromJson(e),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
  }
}