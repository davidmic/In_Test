import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:in_test/exhibition/exhibit.dart';
import 'package:in_test/src/services/dio_service.dart';
import 'package:in_test/src/services/network_checker.dart';

GetIt locator = GetIt.I;
void setup() {
  if (!locator.isRegistered<NetworkConnection>()) {
    locator.registerLazySingleton<NetworkConnection>(
        () => NetworkConnectionImpl(Connectivity()));
  }
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  registerExhibitDependencies();
}
