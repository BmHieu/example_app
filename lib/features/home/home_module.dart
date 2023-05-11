import '../../core/injection/injection.dart';
import 'domain/repository/home_repository.dart';
import 'domain/usecase/get_all_career_usecase.dart';
import 'presentation/bloc/home_bloc.dart';

class HomeModule extends Module {
  const HomeModule();

  @override
  Future<void> inject() async {
    getIt.registerLazySingleton<HomeRepository>(
      HomeRepository.new,
    );

    getIt.registerLazySingleton(
      () => GetAllCareerUseCase(repository: getIt.get()),
    );

    getIt.registerFactory(
      () => HomeBloc(
        getAllCareerUseCase: getIt.get(),
      ),
    );
  }
}
