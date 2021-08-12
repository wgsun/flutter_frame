import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/login/login_router.dart';
import 'package:flutter_frame/routers/router_global.dart';
import 'package:flutter_frame/utils/Log.dart';
import 'package:flutter_frame/utils/toast.dart';
import '../app_exceptions.dart';
import '../http.dart';

/// 错误处理拦截器
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err) {
    // error统一处理
    AppException appException = AppException.create(err);
    // 错误提示
    debugPrint('DioError===: ${appException.toString()}');
    err.error = appException;
    Toast.show(err.message);
    return super.onError(err);
  }

  @override
  onResponse(Response response) async {
    var data = response.data;
    Log.d("接口返回数据：$data");
    // if (data is String) {
    try {
      // data = json.decode(data);
      String code = data['code'].toString();

      ///登录失效
      if (code == '1001') {
        RouterGlobal.navigatorKey.currentState.pushNamedAndRemoveUntil(
            LoginRouter.loginPage, ModalRoute.withName("/"));
        //BuildContext? context = RouterGlobal.navigatorKey.currentContext;
        return Http.dio
            .reject("登录信息失效，请重新登录");
      }
    } catch (err) {
      print("----出错了-----$err");
      return Http.dio.reject('Json格式异常'); // 完成和终止请求/响应
    }
    // }
    // data = response.statusCode
    // var statusCode = response.statusCode;
    // print("statusCode:" + statusCode.toString());
    // print('请求返回的数据：${data.toString()}');
    // if (statusCode == 401) {
    //   SpUtil.putString(Constant.accessToken, "");
    //   print("登录失效");
    //   RouterGlobal.navigatorKey.currentState.pushNamedAndRemoveUntil(
    //       LoginRouter.loginPage, ModalRoute.withName("/"));
    // }
    // if (data is String) {
    //   print('请求返回的数据：${data.toString()}');
    //   try {
    //     data = json.decode(data);
    //     String code = data['code'];
    //
    //     ///登录失效
    //     if (code == '-1') {
    //       // RouterGlobal.navigatorKey.currentState.pushNamedAndRemoveUntil(
    //       //     LoginRouter.loginPage, ModalRoute.withName("/"));
    //     }
    //   } catch (err) {
    //     showToast('Json格式异常');
    //     return Http.dio.reject('Json格式异常'); // 完成和终止请求/响应
    //   }
    // }
    // print('===1111===${data}');
    // if (data is Map) {
    //   int code = data['code'] ?? 0; // 表示如果data['errorCode']为空的话把 0赋值给errorCode
    //   String errorMsg = data['code'] ?? '请求失败[$code]';
    //   if (code == 0) {
    //     // 正常
    //     return response;
    //   } else {
    //     showToast(errorMsg);
    //     return Http.dio.reject(errorMsg); // 完成和终止请求/响应
    //   }
    // }
    return response;
  }
}
