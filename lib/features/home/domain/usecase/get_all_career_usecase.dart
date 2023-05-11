import 'package:dartz/dartz.dart';

import '../../../../core/exception/app_exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/category_model.dart';
import '../repository/home_repository.dart';
import 'param/home_event_param.dart';

class GetAllCareerUseCase
    extends UseCase<HomeEventParam, Either<AppException, List<JobGroup>>> {
  final HomeRepository repository;

  const GetAllCareerUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppException, List<JobGroup>>> execute(HomeEventParam param) =>
      repository.getAllCareer(
        param: param.toJson(),
      );
}
