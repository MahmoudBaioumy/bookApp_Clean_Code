import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/home/data/repo/home_repo.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';
import 'package:flustra_template/modules/new_arrival/data/repo/new_arrivals_repo.dart';

enum newArrivalCubitTypes {
  none,
  getNewArrivalsBooks,
}

class newArrivalCubit extends BaseCubit<newArrivalCubitTypes> {
  final NewArrivalsRepo _repo;

  newArrivalCubit(this._repo) : super(newArrivalCubitTypes.none);

  static newArrivalCubit get i => getIt<newArrivalCubit>();
  bookResponse? _newArrivalBooksResponse;


  List<Products>? get newArrivalBooks => _newArrivalBooksResponse?.data?.products ?? [];


  // ========================== 🔥 getNewArrivalsBooks 🔥 ========================== //
  BaseEitherResponse<bookResponse> getNewArrivalsBooks() async {
    return await fastFire(
      type: newArrivalCubitTypes.getNewArrivalsBooks,
      fun: () => _repo.getNewArrivalBooks(),
      onSuccess: (x) {
        _newArrivalBooksResponse=x;
      },
      onFailure: (f) => f.printInfo("getNewArrivalsBooks"),
    );
  }

}
