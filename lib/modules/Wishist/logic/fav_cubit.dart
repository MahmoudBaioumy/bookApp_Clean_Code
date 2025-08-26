import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/Wishist/data/repo.dart';
import 'package:flustra_template/modules/Wishist/data/response/fav_response.dart';

enum WishlistCubitTypes {
  none,
  getWishlist,
}

class WishlistCubit extends BaseCubit<WishlistCubitTypes> {
  final WishlistRepo _repo;

  WishlistCubit(this._repo) : super(WishlistCubitTypes.none);

  static WishlistCubit get i => getIt<WishlistCubit>();

  FavoriteResponse? _favoriteResponse;

  // ========================== 🔥 GetWishlist 🔥 ==========================
  BaseEitherResponse<FavoriteResponse> getWishlist() async {
    return await fastFire(
      type: WishlistCubitTypes.getWishlist,
      fun: () => _repo.getWishlist(),
      onSuccess: (x) => _favoriteResponse = x,
      onFailure: (failure) => failure.printInfo("getWishlist"),
    );
  }
}
