import 'package:dio/dio.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/logic/common/api_constants.dart';

final dioService = Provider<Dio>(
  (ref) {
    const baseUrl = APIConstants.baseURL;
    final options = BaseOptions(baseUrl: baseUrl);
    return Dio(options)..interceptors.addAll([AuthRequest(ref)]);
  },
  dependencies: const [],
);

class AuthRequest extends Interceptor {
  final ProviderRef<Dio> ref;

  AuthRequest(this.ref);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      debugPrint("Invalid token");
    }

    super.onError(err, handler);
  }
}
