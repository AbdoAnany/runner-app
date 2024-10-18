import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  NetworkInfo._();
  static final NetworkInfo _instance = NetworkInfo._();
  factory NetworkInfo() => _instance;

  final Connectivity _connectivity = Connectivity();

  // Check the current connectivity status
  Future<ConnectivityResult> getCurrentStatus() async {
    return (await _connectivity.checkConnectivity()).first;
  }

  // Stream to listen for connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }

  // Helper method to determine if the device is connected to a network
  Future<bool> isConnected() async {
    var connectivityResult = await getCurrentStatus();
    return connectivityResult != ConnectivityResult.none;
  }
}