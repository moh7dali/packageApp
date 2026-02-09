import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class SDKNetworkInfo {
  Future<bool> get isConnected;
}

class SDKNetworkInfoImpl implements SDKNetworkInfo {
  final InternetConnectionChecker connectionChecker;

  SDKNetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
