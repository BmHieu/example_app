part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetAllCareerLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException error;
  const HomeError(this.error);
  @override
  List<Object> get props => [error];
}

class HomeJobGroupListLoaded extends HomeState {
  final List<JobGroup> jobGroupList;
  const HomeJobGroupListLoaded(this.jobGroupList);
  @override
  List<Object> get props => [jobGroupList];
}
