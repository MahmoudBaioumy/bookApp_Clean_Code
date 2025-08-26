import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/Wishist/data/response/fav_response.dart';
import 'package:flutter/foundation.dart';
import '../../../core/common/error_handler/failure.dart';
import '../../../core/constants/app_api.dart';

abstract class WishlistRepo {
  Future<Either<Failure, FavoriteResponse>> getWishlist();
}
class WishlistImp implements WishlistRepo {
  // -------------------------- GetWishlist --------------------------
  @override
  Future<Either<Failure, FavoriteResponse>> getWishlist() async {
    return await handleResponse(
      endPoint: ApiConstants.favorites.getFavorites,
      asObject: (e) => FavoriteResponse.fromJson(e),
      method: DioMethod.get,
      headers: {
        'Authorization': 'Bearer ${AppSessionManager.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }

    );
  }
}