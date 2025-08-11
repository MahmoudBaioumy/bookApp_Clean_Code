import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';
import 'package:flustra_template/modules/home/data/response/book_response.dart';

import '../../../../core/constants/app_api.dart';

abstract class bestSellerRepo {
  Future<Either<Failure, bookResponse>> getBestSellerBooks();
}

class bestSellerRepoImp implements bestSellerRepo {
  // ========================== 🔥 getBestSellerBooks 🔥 ========================== //
  @override
  Future<Either<Failure, bookResponse>> getBestSellerBooks() async {
    return await handleResponse(
      endPoint: ApiConstants.home.homeBestSeller,
      asObject: (e) => bookResponse.fromJson(e),
      method: DioMethod.get,
    );
  }
}