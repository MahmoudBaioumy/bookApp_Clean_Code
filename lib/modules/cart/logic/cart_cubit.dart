import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/cart/data/cart_response.dart';
import 'package:flustra_template/modules/cart/data/repo/cart_repo.dart';

enum CartCubitTypes {
  none,
  getCart,
}

class CartCubit extends BaseCubit<CartCubitTypes> {
  CartCubit(this._repo) : super(CartCubitTypes.none);

  final CartRepo _repo;

  static CartCubit get i => getIt<CartCubit>();

  CartResponse? _CartResponse;
  List<CartItems>? get CartBook => _CartResponse?.data?.cartItems ?? [];
  // ========================== 🔥 getCart 🔥 ==========================
  BaseEitherResponse<CartResponse> getCart() async {
    return await fastFire(
      type: CartCubitTypes.getCart,
      fun: () => _repo.getCart(),
      onSuccess: (r) => _CartResponse = r,
      onFailure: (failure) => failure.printInfo("getCart"),

    );
  }
}
