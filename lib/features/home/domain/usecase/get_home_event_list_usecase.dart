// import 'package:dartz/dartz.dart';


// import '../../../../core/exception/app_exception.dart';
// import '../../../../core/usecase/usecase.dart';
// import '../../data/model/event_item_model.dart';
// import '../repository/home_repository.dart';
// import 'param/home_event_param.dart';

// class GetHomeEventListUseCase extends UseCase<HomeEventParam,
//     Either<AppException, List<EventItemModel>>> {
//   final HomeRepository repository;

//   const GetHomeEventListUseCase({required this.repository});

//   @override
//   Future<Either<AppException, List<EventItemModel>>> execute(
//     HomeEventParam param,
//   ) =>
//       repository.getEventList(param.toJson());
// }
