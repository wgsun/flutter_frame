import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {

  final DioConnectivityRequestRetriver requestRetriver;
  
  RetryOnConnectionChangeInterceptor({this.requestRetriver});

  @override
  Future onError(DioError err) async{
    if (_shouldRetry(err)) {
      try {
        return requestRetriver.scheduleRequestRetry(err.request);
      } catch (e) {
        print(e);
      }
    }
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }
}


