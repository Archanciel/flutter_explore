import 'package:get_it/get_it.dart';
import 'package:flutter_mvvm_simple_app/fringilla/repository/fringilla_repo.dart';
import 'package:flutter_mvvm_simple_app/home/repository/home_repo.dart';

import 'pellen/repository/pellen_repo.dart';
import 'shared/services/navigation.service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());

  locator.registerFactory<FringillaRepo>(() => FringillaRepoImpl());
  locator.registerFactory<HomeRepo>(() => HomeRepoImpl());
  locator.registerFactory<PellenRepo>(() => PellenRepoImpl());
}
