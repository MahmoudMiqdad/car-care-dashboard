import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:dio/dio.dart';

class ErrorFailureInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
  
    if (err.error is Failure) {
      return handler.next(err);
    }

    try {
      
      handelDioExcptions(err);

    
      return handler.next(err);
    } on ServerExpcptions catch (e) {
      return handler.next(
        err.copyWith(error: e.error),
      );
    } catch (_) {
      return handler.next(
        err.copyWith(
          error: const Failure(message: "حدث خطأ غير متوقع"),
        ),
      );
    }
  }
}