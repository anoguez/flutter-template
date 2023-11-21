import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

Dio dioService({String baseUrl = ''}) {
  final options = BaseOptions(baseUrl: baseUrl, preserveHeaderCase: true);
  return Dio(options)..interceptors.addAll([AuthRequest()]);
}

class AuthRequest extends Interceptor {
  static final _log = Logger('DioService');

  AuthRequest();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    _log.severe("onError", err);
    super.onError(err, handler);
  }
}
