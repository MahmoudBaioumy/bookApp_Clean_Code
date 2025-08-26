import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/constants/app_api.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/auth/data/responses/auth_response.dart';
import 'package:flustra_template/modules/cart/data/responses/cart_response.dart';
import 'package:flustra_template/modules/cart/data/request/cart_request.dart';
import 'package:flustra_template/modules/cart/data/responses/remove_response.dart';

import '../../../../core/helper/shared_methods.dart';

abstract class CartRepo {
  Future<Either<Failure, CartResponse>> getCart();

  Future<Either<Failure, CartResponse>> addToCart({required AddToCartRequest request});
  Future<Either<Failure, RemoveCartResponse>> removeItemCart({required int itemId});
}

class CartImp implements CartRepo {
  // ========================== 🔥 getCart 🔥 ========================== //
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

// ========================== 🔥 addToCart 🔥 ========================== //
  @override
  Future<Either<Failure, CartResponse>> addToCart({required AddToCartRequest request}) async {
    final token = AppSessionManager.token;
    return await handleResponse(
      endPoint: ApiConstants.cart.addCart,
      method: DioMethod.post,
      asObject: (e) => CartResponse.fromJson(e),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      data: request.toJson(),
    );
  }

  @override
  Future<Either<Failure, RemoveCartResponse>> removeItemCart({required int itemId}) {
    final token = AppSessionManager.token;
    return handleResponse(
      endPoint: ApiConstants.cart.removeCart,
      method: DioMethod.post,
      asObject: (e) => RemoveCartResponse.fromJson(e),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      data: {"cart_item_id": itemId},
    );
  }
}
