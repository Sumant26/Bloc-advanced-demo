import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/api_client.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/domain/repositories/post_repository.dart';
import 'features/posts/presentation/bloc/posts_bloc.dart';

final sl = GetIt.instance; // sl is short for Service Locator

Future<void> init() async {
  // Features - Posts
  // Bloc
  sl.registerFactory(() => PostsBloc(postRepository: sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(sl()),
  );

  // Core
  sl.registerLazySingleton(() => ApiClient(sl()));

  // External
  sl.registerLazySingleton(() => Dio());
}
