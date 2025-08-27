import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/Wishist/data/response/add_wishlist_response.dart';
import 'package:flustra_template/modules/Wishist/data/response/fav_response.dart';
import 'package:flustra_template/modules/Wishist/data/response/remove_Wishlist_response.dart';
import '../../../core/common/error_handler/failure.dart';
import '../../../core/constants/app_api.dart';

abstract class WishlistRepo {
  Future<Either<Failure, FavoriteResponse>> getWishlist();

  Future<Either<Failure, addWishlistResponse>> addWishlist({required int bookId});
  Future<Either<Failure, removeWishlistResponse>> removeWishlist({required int bookId});
}

class WishlistImp implements WishlistRepo {

  // ========================== 🔥 GetWishlist  🔥 ========================== //
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
        });
  }

// ========================== 🔥 addWishlist 🔥 ========================== //
  @override
  Future<Either<Failure, addWishlistResponse>> addWishlist({required int bookId})async {
    return await handleResponse(
        endPoint: ApiConstants.favorites.addToFavorites,
        asObject: (e) => addWishlistResponse.fromJson(e),
        method: DioMethod.post,
        headers: {
          'Authorization': 'Bearer ${AppSessionManager.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        data: {
          "product_id": bookId
        });
  }

  @override
  Future<Either<Failure, removeWishlistResponse>> removeWishlist({required int bookId}) {
    return handleResponse(
        endPoint: ApiConstants.favorites.removeFromFavorites,
        asObject: (e) => removeWishlistResponse.fromJson(e),
        method: DioMethod.post,
        headers: {
          'Authorization': 'Bearer ${AppSessionManager.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        data: {
          "product_id": bookId
        });
  }
  // ========================== 🔥 remove wishlist 🔥 ========================== //


}
