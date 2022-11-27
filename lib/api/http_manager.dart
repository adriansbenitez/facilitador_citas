import 'package:dio/dio.dart';
import 'package:facilitador_citas/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

import '../config/config.dart';
import '../utils/utils.dart';

class HTTPManager {
  late final Dio _dio;

  HTTPManager() {
    ///Dio
    _dio = Dio(
      BaseOptions(
        baseUrl: Application.domain,
        connectTimeout: 50000,
        receiveTimeout: 50000,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    ///Interceptors dio
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          final regName = RegExp('[^A-Za-z0-9 ]');
          Map<String, dynamic> headers = {
            "uuid": Application.device?.uuid,
            "name": Application.device?.name?.replaceAll(regName, '*'),
            "model": Application.device?.model,
            "version": Application.device?.version,
            "appVersion": Application.packageInfo?.version,
            "type": Application.device?.type,
            "token": Application.device?.token,
          };
          String? token = AppBloc.userCubit.state?.accessToken;
          if (token != null) {
            headers["Authorization"] = "Bearer $token";
          }
          options.headers.addAll(headers);
          _printRequest(options);
          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          if (error.type != DioErrorType.response) {
            return handler.next(error);
          }


          /// Something went wrong with network
          if (error.type == DioErrorType.connectTimeout){
            AppBloc.messageCubit.onShow("No se pudo conectar a los servidores, revise su conexión e intente de nuevo.", MessageStatusType.error);
          }

          if ([401, 403].contains(error.response?.statusCode)) {
            AppBloc.loginCubit.onLogout();
          }

          final response = Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
          );
          return handler.resolve(response);
        },
      ),
    );
  }

  void _buildSVProgressHUD() {
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
    SVProgressHUD.setBackgroundColor(UtilColor.getColorFromHex("#1c4c72").withOpacity(0.80));
    SVProgressHUD.setForegroundColor(Colors.white);
  }

  ///Post method
  Future<dynamic> post({
    required String url,
    dynamic data,
    FormData? formData,
    Options? options,
    Function(num)? progress,
    bool? loading,
  }) async {
    if (loading == true) {
      _buildSVProgressHUD();
      SVProgressHUD.show();
    }
    try {
      final response = await _dio.post(
        url,
        data: data ?? formData,
        options: options,
        onSendProgress: (received, total) {
          if (progress != null) {
            progress((received / total) / 0.01);
          }
        },
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Get method
  Future<dynamic> get({
    required String url,
    dynamic params,
    Options? options,
    bool? loading,
  }) async {
    try {
      if (loading == true) {
        _buildSVProgressHUD();
        SVProgressHUD.show();
      }
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Put method
  Future<dynamic> put({
    required String url,
    dynamic data,
    Options? options,
    bool? loading,
  }) async {
    try {
      if (loading == true) {
        _buildSVProgressHUD();
        SVProgressHUD.show();
      }
      final response = await _dio.put(
        url,
        data: data,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Post method
  Future<dynamic> download({
    required String url,
    required String filePath,
    dynamic params,
    Options? options,
    Function(num)? progress,
    bool? loading,
  }) async {
    if (loading == true) {
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
      SVProgressHUD.show();
    }
    try {
      final response = await _dio.download(
        url,
        filePath,
        options: options,
        queryParameters: params,
        onReceiveProgress: (received, total) {
          if (progress != null) {
            progress((received / total) / 0.01);
          }
        },
      );
      /*if (response.statusCode == 200) {
        return {
          "success": true,
          "data": File(filePath),
          "message": 'download_success',
        };
      }*/
      return {
        "success": false,
        "message": 'download_fail',
      };
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }


  ///Print request info
  void _printRequest(RequestOptions options) {
    UtilLogger.log("BEFORE REQUEST ====================================");
    UtilLogger.log("${options.method} URL", options.uri);
    UtilLogger.log("HEADERS", options.headers);
    if (options.method == 'GET') {
      UtilLogger.log("PARAMS", options.queryParameters);
    } else {
      UtilLogger.log("DATA", options.data);
    }
  }

  ///Error common handle
  Map<String, dynamic> _errorHandle(DioError error) {
    String message = "unknown_error";
    Map<String, dynamic> data = {};

    switch (error.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        message = "request_time_out";
        break;

      default:
        message = "cannot_connect_server";
        break;
    }

    return {
      "success": false,
      "message": message,
      "data": data,
    };
  }
}
