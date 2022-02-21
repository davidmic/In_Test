import 'package:cross_connectivity/cross_connectivity.dart';

abstract class NetworkConnection {
  Future<bool> get isDeviceConnected;
}

class NetworkConnectionImpl implements NetworkConnection {
  NetworkConnectionImpl(this._connectivity);
  final Connectivity _connectivity;

  @override
  Future<bool> get isDeviceConnected => _connectivity.checkConnection();
}
