import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/cart/data/responses/cart_response.dart';
import 'package:flustra_template/modules/cart/data/repo/cart_repo.dart';
import 'package:flustra_template/modules/cart/data/request/cart_request.dart';
import 'package:flustra_template/modules/cart/data/responses/remove_response.dart';

enum CartCubitTypes {
  none,
  getCart,
  addCart,
  removeCart,
}

class CartCubit extends BaseCubit<CartCubitTypes> {
  CartCubit(this._repo) : super(CartCubitTypes.none);

  final CartRepo _repo;

  static CartCubit get i => getIt<CartCubit>();

  CartResponse? _CartResponse;
  RemoveCartResponse ?_removeCartResponse;

  List<CartItems>? get CartBook => _CartResponse?.data?.cartItems ?? [];
  List<CartItemsRemove>? get CartBookCount => _removeCartResponse?.data?.cartItems ?? [];

  // ========================== 🔥 getCart 🔥 ==========================
  BaseEitherResponse<CartResponse> getCart() async {
    return await fastFire(
      type: CartCubitTypes.getCart,
      fun: () => _repo.getCart(),
      onSuccess: (r) => _CartResponse = r,
      onFailure: (failure) => failure.printInfo("getCart"),
    );
  }

  // ========================== 🔥 Add Cart 🔥 ========================== //
  BaseEitherResponse<CartResponse> addToCart({required AddToCartRequest request}) async {
    return await fastFire(
      type: CartCubitTypes.addCart,
      fun: () => _repo.addToCart(request: request),
      onSuccess: (r) => _CartResponse = r,
      onFailure: (failure) => failure.printInfo("addToCart"),
    );
  }
  // ========================== 🔥 Remove Cart 🔥 ========================== //
  BaseEitherResponse<RemoveCartResponse> removeItemCart({required int itemId}) async {
    return await fastFire(
      type: CartCubitTypes.removeCart,
      fun: () => _repo.removeItemCart(itemId: itemId),
      onSuccess: (r) => _removeCartResponse = r,
      onFailure: (failure) => failure.printInfo("removeItemCart"),
    );
  }

}
