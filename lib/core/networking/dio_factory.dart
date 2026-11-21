import 'package:dio/dio.dart';
import 'package:gymsystem/core/helper/constants.dart';
import 'package:gymsystem/core/helper/shared_pref_helper.dart';
import 'package:gymsystem/core/networking/api_constants.dart';
import 'package:gymsystem/core/networking/api_service.dart';
import 'package:gymsystem/env.dart';
import 'package:gymsystem/features/login/data/models/login_response_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  /// بيتنادى لما الـ refresh يفشل (وجّه المستخدم للـ login)
  static void Function()? onSessionExpired;

  static Dio getDio() {
    const timeOut = Duration(seconds: 30);

    if (dio == null) {
      dio = Dio()
        ..options.baseUrl = Env.apiUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioInterceptor();
    }
    return dio!;
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(_AuthInterceptor(dio!));
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }
}

class _AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  _AuthInterceptor(this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    options.headers['Accept'] = 'application/json';
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final is401 = err.response?.statusCode == 401;
    final isAuthCall =
        err.requestOptions.path.contains(ApiConstants.login) ||
        err.requestOptions.path.contains(ApiConstants.refreshToken);

    if (!is401 || isAuthCall) return handler.next(err);

    final refreshToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.refreshToken,
    );
    if (refreshToken.isEmpty) {
      await _logout();
      return handler.next(err);
    }

    // لو request تاني سبقنا وجدد التوكن، استخدمه بدل ما نجدد تاني
    final currentToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    final sentToken = err.requestOptions.headers['Authorization']
        ?.toString()
        .replaceFirst('Bearer ', '');
    if (currentToken.isNotEmpty && currentToken != sentToken) {
      return _retry(err, currentToken, handler);
    }

    try {
      // Dio نضيف من غير interceptors
      final refreshDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl));
      final api = ApiService(refreshDio);

      final res = await api.refreshToken(
        RefreshTokenModel(refreshToken: refreshToken),
      );

      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.userToken,
        res.token!,
      );
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.refreshToken,
        res.refreshToken!,
      );

      return _retry(err, res.token!, handler);
    } catch (_) {
      await _logout();
      return handler.next(err);
    }
  }

  Future<void> _retry(
    DioException err,
    String token,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $token';
      final response = await _dio.fetch(opts);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  Future<void> _logout() async {
    await SharedPrefHelper.clearAllData();
    DioFactory.onSessionExpired?.call();
  }
}
