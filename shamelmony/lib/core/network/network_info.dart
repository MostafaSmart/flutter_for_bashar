import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:injectable/injectable.dart';

/// واجهة للتحقق من حالة الاتصال بالإنترنت
abstract class NetworkInfo {
  /// التحقق من وجود اتصال بالإنترنت
  Future<bool> get isConnected;
}

/// تنفيذ للتحقق من حالة الاتصال بالإنترنت
@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
