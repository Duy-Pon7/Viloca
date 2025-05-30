import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get inConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;
  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> get inConnected async =>
      await internetConnection.hasInternetAccess;
}
