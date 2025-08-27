import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/Wishist/data/repo.dart';
import 'package:flustra_template/modules/Wishist/data/response/add_wishlist_response.dart';
import 'package:flustra_template/modules/Wishist/data/response/fav_response.dart';
import 'package:flustra_template/modules/Wishist/data/response/remove_Wishlist_response.dart';

enum WishlistCubitTypes {
  none,
  getWishlist,
  addWishlist,
  removeWishlist,
}

class WishlistCubit extends BaseCubit<WishlistCubitTypes> {
  final WishlistRepo _repo;

  WishlistCubit(this._repo) : super(WishlistCubitTypes.none);

  static WishlistCubit get i => getIt<WishlistCubit>();

  FavoriteResponse? _favoriteResponse;
  addWishlistResponse? _addWishlistResponse;
  removeWishlistResponse? _removeWishlistResponse;

  // ========================== 🔥 GetWishlist 🔥 ==========================
  BaseEitherResponse<FavoriteResponse> getWishlist() async {
    return await fastFire(
      type: WishlistCubitTypes.getWishlist,
      fun: () => _repo.getWishlist(),
      onSuccess: (x) => _favoriteResponse = x,
      onFailure: (failure) => failure.printInfo("getWishlist"),
    );
  }

  // ========================== 🔥 add to wishlist 🔥 ========================== //
  BaseEitherResponse<addWishlistResponse> addToWishlist({required int bookId}) async {
    return await fastFire(
      type: WishlistCubitTypes.addWishlist,
      fun: () => _repo.addWishlist(bookId: bookId),
      onSuccess: (r) => _addWishlistResponse = r,
      onFailure: (failure) => failure.printInfo("addToWishlist"),
    );
  }

  // ========================== 🔥 remove wishlist 🔥 ========================== //
  BaseEitherResponse<removeWishlistResponse> removeFromWishlist({required int bookId}) async {
    return await fastFire(
      type: WishlistCubitTypes.removeWishlist,
      fun: () => _repo.removeWishlist(bookId: bookId),
      onSuccess: (r) => _removeWishlistResponse = r,
      onFailure: (failure) => failure.printInfo("removeFromWishlist"),
    );
  }
}
