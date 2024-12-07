import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_admin/presentation/pages/main/news/data/firebase_service.dart';
import 'package:news_admin/presentation/pages/main/users/data/repository.dart';
import '../../presentation/pages/login/data/repository.dart';
import '../../presentation/pages/login/data/service.dart';
import '../../presentation/pages/main/category/data/repository.dart';
import '../../presentation/pages/main/category/data/service.dart';
import '../../presentation/pages/main/news/data/repository.dart';
import '../../presentation/pages/main/news/data/service.dart';
import '../../presentation/pages/main/users/data/service.dart';
import '../constants/config.dart';
import 'interceptor.dart';
import 'secure_storage.dart';

final getIt = GetIt.instance;

final dioWithoutToken = Dio()
  ..interceptors.add(AuthInterceptor())
  ..options = BaseOptions(
    baseUrl: Config.baseUrl,
    followRedirects: false,
    validateStatus: (status) => status! < 500,
  );
final dio = Dio()
  ..interceptors.add(JwtInterceptor())
  ..options = BaseOptions(
    baseUrl: Config.baseUrl,
    followRedirects: false,
    validateStatus: (status) {
      // getIt<LoginCubit>().checkAuthentication(status);
      return status! < 500;
    },
  );

Future<void> initializeDependencies() async {
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  getIt.registerLazySingleton<INewsRepository>(
    () => NewsRepository(dioWithoutToken),
  );
  getIt.registerLazySingleton<FirebaseService>(
    () => FirebaseService(),
  );
  getIt.registerLazySingleton<INewsService>(() => NewsService(getIt()));

  getIt.registerLazySingleton<ICategoryRepository>(
    () => CategoryRepository(dioWithoutToken),
  );
  getIt.registerLazySingleton<ICategoryService>(() => CategoryService(getIt()));

  getIt.registerLazySingleton<IUserRepository>(() => UserRepository());
  getIt.registerLazySingleton<IUserService>(() => UserService(getIt()));

  getIt.registerLazySingleton<IAuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<IAuthService>(() => AuthService(getIt()));
}
