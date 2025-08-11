import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/best_seller/data/repo/best_seller_repo.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flustra_template/modules/new_arrival/data/repo/new_arrivals_repo.dart';

enum HomeCubitTypes {
  none,
  getBestSellerBooks,
  getNewArrivalsBooks,
}

class HomeCubit extends BaseCubit<HomeCubitTypes> {
  final bestSellerRepo _bestSellerRepo;
  final NewArrivalsRepo _newArrivalsRepo;

  HomeCubit(this._bestSellerRepo, this._newArrivalsRepo) : super(HomeCubitTypes.none);

  static HomeCubit get i => getIt<HomeCubit>();

  // ========================== 🔒 Private Responses ==========================
  bookResponse? _bestSellerBooksResponse;
  bookResponse? _newArrivalBooksResponse;

  // ========================== 🟢 Getters ==========================
  List<Products>? get bestSellerBooks => _bestSellerBooksResponse?.data?.products ?? [];
  List<Products>? get newArrivalBooks => _newArrivalBooksResponse?.data?.products ?? [];

  // ========================== 🔥 Get Best Sellers ==========================
  BaseEitherResponse<bookResponse> getBestSellerBooks() async {
    return await fastFire(
      type: HomeCubitTypes.getBestSellerBooks,
      fun: () => _bestSellerRepo.getBestSellerBooks(),
      onSuccess: (res) => _bestSellerBooksResponse = res,
      onFailure: (f) => f.printInfo("getBestSellerBooks"),
    );
  }

  // ========================== 🔥 Get New Arrivals ==========================
  BaseEitherResponse<bookResponse> getNewArrivalsBooks() async {
    return await fastFire(
      type: HomeCubitTypes.getNewArrivalsBooks,
      fun: () => _newArrivalsRepo.getNewArrivalBooks(),
      onSuccess: (res) => _newArrivalBooksResponse = res,
      onFailure: (f) => f.printInfo("getNewArrivalsBooks"),
    );
  }
}
