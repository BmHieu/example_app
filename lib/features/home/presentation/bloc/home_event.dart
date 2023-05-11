part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventInit extends HomeEvent {
  final int categoryId;
  final int page;
  const HomeEventInit({
    required this.categoryId,
    required this.page,
  });
  @override
  List<Object> get props => [
        categoryId,
        page,
      ];
}
