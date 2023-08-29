import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/repository/banner_repository.dart';
// import 'package:template/data/repository/auth_repo.dart';
import 'package:template/data/repository/category_news_repository.dart';
import 'package:template/data/repository/category_repository.dart';
import 'package:template/data/repository/context_repository.dart';
import 'package:template/data/repository/district_repository.dart';
import 'package:template/data/repository/educate_repository.dart';
import 'package:template/data/repository/image_repository.dart';
import 'package:template/data/repository/news_repository.dart';
import 'package:template/data/repository/order_item_repository.dart';
import 'package:template/data/repository/order_repository.dart';
import 'package:template/data/repository/personal_honor_repository.dart';
import 'package:template/data/repository/product_repository.dart';
import 'package:template/data/repository/province_repository.dart';
import 'package:template/data/repository/user_repository.dart';
import 'package:template/data/repository/auth_repository.dart';
import 'package:template/helper/network_info.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/banner_provider.dart';
import 'package:template/provider/category_news_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/context_provider.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/educate_provider.dart';
import 'package:template/provider/news_provider.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/personal_honor_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/utils/firebase_service.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'sharedpref/shared_preference_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<FirebaseService>(FirebaseService());

  // Repository
  // sl.registerLazySingleton(() => RegionRepo());
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => CategoryRepository());
  sl.registerLazySingleton(() => CategoryNewsRepository());
  sl.registerLazySingleton(() => ProductRepository());
  sl.registerLazySingleton(() => NewsRepository());
  sl.registerLazySingleton(() => OrderItemRepository());
  sl.registerLazySingleton(() => OrderRepository());
  sl.registerLazySingleton(() => ProvinceRepository());
  sl.registerLazySingleton(() => DistrictRepository());
  sl.registerLazySingleton(() => UserRepository());
  sl.registerLazySingleton(() => ImageUpdateRepository());
  sl.registerLazySingleton(() => PersonalHonorRepository());
  sl.registerLazySingleton(() => BannerRepository());
  sl.registerLazySingleton(() => ContextRepository());
  sl.registerLazySingleton(() => EducateRepository());

  // Provider
  // sl.registerFactory(() => RegionProvider());
  // sl.registerFactory(() => AuthProvider());
  sl.registerFactory(() => CategoryProvider());
  sl.registerFactory(() => CategoryNewsProvider());
  sl.registerFactory(() => ProductProvider());
  sl.registerFactory(() => NewsProvider());
  sl.registerFactory(() => OrderProvider());
  sl.registerFactory(() => ProvinceProvider());
  sl.registerFactory(() => DistrictProvider());
  sl.registerFactory(() => UserProvider());
  sl.registerFactory(() => ImageUpdateProvider());
  sl.registerFactory(() => PersonalHonorProvider());
  sl.registerFactory(() => ContextProvider());
  sl.registerFactory(() => OrderItemProvider());
  sl.registerLazySingleton(() => BannerProvider());
  sl.registerLazySingleton(() => EducateProvider());

  // Provider
  sl.registerFactory(() => AuthProvider());
}
