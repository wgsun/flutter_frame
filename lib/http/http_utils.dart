import 'package:dio/dio.dart';
import 'cache.dart';
import 'http.dart';

class HttpUtils {
  static void init(
      {String baseUrl,
      int connectTimeout,
      int receiveTimeout,
      List<Interceptor> interceptors}) {
    Http.instance.init(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        interceptors: interceptors);
  }

  static void setHeaders(Map<String, dynamic> map) {
    Http.instance.setHeaders(map);
  }

  static void cancelRequests({CancelToken token}) {
    Http.instance.cancelRequests(token: token);
  }

  static Future get(
    String path, {
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    String cacheKey,
    bool cacheDisk = false,
  }) async {
    return await Http.instance.get(path,
        params: params,
        options: options,
        cancelToken: cancelToken,
        refresh: refresh,
        nocache: noCache,
        cacheKey: cacheKey,
        cacheDisk: cacheDisk);
  }

  static Future post(
    String path, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Http.instance.post(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future put(
    String path, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Http.instance.put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future patch(
    String path, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Http.instance.patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future delete(
    String path, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Http.instance.delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future postForm(
    String path, {
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Http.instance.postForm(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
