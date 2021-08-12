import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetriver {
  late Dio dio;
  late Connectivity connectivity;

  DioConnectivityRequestRetriver({required this.dio, required this.connectivity});

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
          if (connectivityResult != ConnectivityResult.none) {
            streamSubscription.cancel();
            responseCompleter.complete(
              dio.request(
                requestOptions.path,
                cancelToken: requestOptions.cancelToken,
                data: requestOptions.data,
                onReceiveProgress: requestOptions.onReceiveProgress,
                onSendProgress: requestOptions.onSendProgress,
                queryParameters: requestOptions.queryParameters,
                options: requestOptions,
              ),
            );
          }
        });
    return responseCompleter.future;
  }
}