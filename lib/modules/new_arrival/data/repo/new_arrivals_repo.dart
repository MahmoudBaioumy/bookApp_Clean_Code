import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/constants/app_api.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';

abstract class NewArrivalsRepo {
  Future<Either<Failure, bookResponse>> getNewArrivalBooks();
}

class NewArrivalsRepoImp implements NewArrivalsRepo {
// ========================== 🔥 getNewArrivalBooks 🔥 ========================== //
  @override
  Future<Either<Failure, bookResponse>> getNewArrivalBooks() async {
    return await handleResponse(
      endPoint: ApiConstants.home.homeNewArrivals,
      asObject: (e) => bookResponse.fromJson(e),
      method: DioMethod.get,
    );
  }
}