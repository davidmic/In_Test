import 'package:in_test/core/di.dart';
import 'package:in_test/exhibition/data/datasource/exhibit.dart';
import 'package:in_test/exhibition/data/datasource/implementation/exhibit_impl.dart';
import 'package:in_test/exhibition/data/repo_impl/exhibit_repo_impl.dart';
import 'package:in_test/exhibition/domain/repo/exhibit_repo.dart';
import 'package:in_test/exhibition/domain/usecase/get_exhibit.dart';

void registerExhibitDependencies() {
  // Data sources
  locator.registerLazySingleton<ExhibitsLoader>(
    () => RestExhibitsLoader(
      locator(),
    ),
  );

  //  Repositories
  locator.registerLazySingleton<ExhibitRepo>(() => ExhibitRepoImpl(locator()));

  // Use cases
  locator.registerLazySingleton(() => GetExhibits(locator()));
}
