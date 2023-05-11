import 'package:dartz/dartz.dart';

import '../../../../core/api/api.dart';
import '../../../../core/exception/app_exception.dart';
import '../../data/model/category_model.dart';

class HomeRepository {
  const HomeRepository();

  Future<Either<AppException, List<JobGroup>>> getAllCareer({
    required Map<String, dynamic> param,
  }) async {
    try {
      final response = await API().dio.get(
            '/api/career-bank/all-career',
            queryParameters: param,
          );

      return Right(
        ((response.data as Map<String, dynamic>)['data'] as List<dynamic>)
            .map((e) => JobGroup.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException(error: e));
    }
  }
}
