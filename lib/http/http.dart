import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_frame/http/sp.dart';
import 'package:flutter_frame/utils/Log.dart';
import 'package:flutter_frame/utils/constant.dart';
import 'package:flutter_frame/utils/utils.dart';
import 'cache.dart';
import 'connectivity_request_retrier.dart';
import 'global.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/net_cache.dart';
import 'interceptors/retry_interceptor.dart';

class Http {
  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static final Http _instance = Http._privateConstrucrot();

  static late Dio dio;

  CancelToken _cancelToken = new CancelToken();

  static Http get instance {
    return _instance;
  }

  Http._privateConstrucrot() {
    if (dio == null) {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions options = new BaseOptions(
          connectTimeout: CONNECT_TIMEOUT,
          // 响应流上前后两次接受到数据的间隔，单位为毫秒。
          receiveTimeout: RECEIVE_TIMEOUT,
          //contentType: Headers.formUrlEncodedContentType,
          // Http请求头.
          headers: {
            "client": "customerApp",
            // Headers.contentTypeHeader: Headers.formUrlEncodedContentType
          });
      dio = new Dio(options);
      //dio.options.headers['content-type'] = Headers.formUrlEncodedContentType;

      // 添加拦截器
      dio.interceptors.add(ErrorInterceptor());
      // 加内存缓存
      dio.interceptors.add(NetCacheInterceptor());
      //dio.interceptors.add(LogInterceptors());
      if (Global.retryEnable) {
        dio.interceptors.add(
          RetryOnConnectionChangeInterceptor(
            requestRetriver: DioConnectivityRequestRetriver(
              dio: dio,
              connectivity: Connectivity(),
            ),
          ),
        );
      }
      dio.interceptors.add(LogInterceptor());

      // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
      /*if (PROXY_ENABLE) {
       (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
           (client) {
         client.findProxy = (uri) {
           return "PROXY $PROXY_IP:$PROXY_PORT";
         };
         //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
         client.badCertificateCallback =
             (X509Certificate cert, String host, int port) => true;
       };
     }*/
    }
  }

  ///初始化公共属性
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init(
      {String? baseUrl,
      int? connectTimeout,
      int? receiveTimeout,
      List<Interceptor>? interceptors}) {
    dio.options = dio.options.merge(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout);
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  ///设置header
  void setHeaders(Map<String, dynamic> map) {
    dio.options.headers.addAll(map);
  }

  ///取消请求
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  ///读取本地配置x
  Map<String, dynamic> getAuthorizationHeader() {
    var headers;
    if (Utils.isString(SpUtil().getString(Constant.accessToken))) {
      headers = {
        "Authorization": "${SpUtil().getString(Constant.accessToken)}"
      };
    }
    return headers;
  }

  ///get请求
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool nocache = !CACHE_ENABLE,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(extra: {
      "refresh": refresh,
      "nocache": nocache,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    Response response;
    response = await dio.get(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post 操作
  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions;
    if (options == null) {
      requestOptions = Options();
      Map<String, dynamic> _authorization = getAuthorizationHeader();
      if (_authorization != null) {
        requestOptions = requestOptions.merge(headers: _authorization);
      }
    } else {
      requestOptions = options;
    }
    Log.d("请求入参：$data");
    var response = await dio.post(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful put 操作
  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.put(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.patch(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.delete(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  String getLang() {
    var lang = "";
    if (Constant.countryCode.isNotEmpty &&
        Constant.countryCode.contains("JP")) {
      lang = "ja_jP";
    } else if (Constant.countryCode.isNotEmpty &&
        Constant.countryCode.contains("CN")) {
      lang = "zh_CN";
    } else if (Constant.countryCode.isNotEmpty &&
        Constant.countryCode.contains("US")) {
      lang = "en_US";
    } else {
      lang = "ja_jP";
    }
    return lang;
  }
}
