import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exception/app_exception.dart';
import '../../data/model/category_model.dart';
import '../../domain/usecase/get_all_career_usecase.dart';
import '../../domain/usecase/param/home_event_param.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllCareerUseCase getAllCareerUseCase;
  HomeBloc({
    required this.getAllCareerUseCase,
  }) : super(HomeInitial()) {
    on<HomeEventInit>(_onHomeEventInit);
  }

  _onHomeEventInit(HomeEventInit event, Emitter<HomeState> emit) async {
    emit(GetAllCareerLoading());
    final result = await getAllCareerUseCase.execute(
      HomeEventParam(
       categoryId: event.categoryId,
        page: event.page,
      ),
    );
    result.fold(
      (error) => emit(HomeError(error)),
      (result) => emit(HomeJobGroupListLoaded(result)),
    );
  }
}
