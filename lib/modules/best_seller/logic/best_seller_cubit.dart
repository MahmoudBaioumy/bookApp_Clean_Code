import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/best_seller/data/repo/best_seller_repo.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';

import '../../../core/get_it/get_it.dart';

enum bestSellerCubitTypes {
  none,
  getBestSellerBooks,
}
class bestSellerCubit extends BaseCubit<bestSellerCubitTypes> {
  final bestSellerRepo _repo;

  bestSellerCubit(this._repo) : super(bestSellerCubitTypes.none);

  static bestSellerCubit get i => getIt<bestSellerCubit>();
  bookResponse? _bestSellerBooksResponse;


  List<Products>? get bestSellerBooks => _bestSellerBooksResponse?.data?.products ?? [];


  // ========================== 🔥 getBestSellerBooks 🔥 ==========================
  BaseEitherResponse<bookResponse> getBestSellerBooks() async {
    return await fastFire(
      type: bestSellerCubitTypes.getBestSellerBooks,
      fun: () => _repo.getBestSellerBooks(),
      onSuccess: (x) {
        _bestSellerBooksResponse = x;
      },
      onFailure: (f) => f.printInfo("getBestSellerBooks"),
    );
  }


}