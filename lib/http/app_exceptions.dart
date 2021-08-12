import 'dart:io';

import 'package:dio/dio.dart';

///自定义异常
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() {
    return '$message';
  }

  factory AppException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.DEFAULT:
        if (error.error is SocketException) {
          return BadRequestException("网络异常，请检查你的网络！");
        }
        if (error.error is FormatException) {
          return BadRequestException('数据解析错误!');
        }
        if (error.error is HttpException) {
          return BadRequestException('服务器异常!');
        }
        return BadRequestException("网络异常，请检查你的网络！");
      case DioErrorType.CANCEL:
        return BadRequestException("请求取消");
      case DioErrorType.CONNECT_TIMEOUT:
        return BadRequestException("连接超时");
      case DioErrorType.SEND_TIMEOUT:
        return BadRequestException("请求超时");
      case DioErrorType.RECEIVE_TIMEOUT:
        return BadRequestException("响应超时");
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
            switch (errCode) {
              case 400:
                {
                  return BadRequestException("请求语法错误");
                }
              case 401:
                {
                  return UnauthorisedException(errCode, "没有权限");
                }
              case 403:
                {
                  return UnauthorisedException(errCode, "服务器拒绝执行");
                }
              case 404:
                {
                  return UnauthorisedException(errCode, "无法连接服务器");
                }
              case 405:
                {
                  return UnauthorisedException(errCode, "请求方法被禁止");
                }
              case 500:
                {
                  return UnauthorisedException(errCode, "服务器内部错误");
                }
              case 502:
                {
                  return UnauthorisedException(errCode, "无效的请求");
                }
              case 503:
                {
                  return UnauthorisedException(errCode, "服务器挂了");
                }
              case 505:
                {
                  return UnauthorisedException(errCode, "不支持HTTP协议请求");
                }
              default:
                {
                  return AppException(error.response.statusMessage);
                }
            }
          } on Exception catch (_) {
            return AppException("未知错误");
          }
        }
      break;
      default:
        return AppException(error.message);
    }
  }
}

///请求错误
class BadRequestException extends AppException {
  BadRequestException(String message) : super(message);
}

/// 未认证异常
class UnauthorisedException extends AppException {
  UnauthorisedException(int code, String message) : super(message);
}
