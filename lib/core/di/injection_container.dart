
import 'package:get_it/get_it.dart';
import 'package:jorpi_sac/data/datasources/project_remote_data_source.dart';
import 'package:jorpi_sac/data/repositories/project_repository_impl.dart';
import 'package:jorpi_sac/domain/repositories/project_repository.dart';
import 'package:jorpi_sac/domain/usecases/get_projects.dart';
import 'package:jorpi_sac/presentation/bloc/projects_bloc.dart';

final sl = GetIt.instance;

void init() {
  // BLoC
  sl.registerFactory(() => ProjectsBloc(getProjects: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProjects(sl()));

  // Repositories
  sl.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(),
  );
}
