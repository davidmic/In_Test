import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:in_test/core/di.dart';
import 'package:in_test/src/api_result/api_result.dart';
import 'package:in_test/src/services/network_checker.dart';

const defaultIgnoredStatusCodes = [404, 422];

Future<ApiResult<T>> dioInterceptor<T>(
  Future<T> Function() func, {
  List<int> doNotReport = defaultIgnoredStatusCodes,
}) async {
  final _networkInfo = locator<NetworkConnection>();

  if (!await _networkInfo.isDeviceConnected) {
    return const ApiResult.apiFailure(
      error: "No Internet Connection",
    );
  }

  try {
    final result = await func();

    return ApiResult.success(data: result);
  } on DioError catch (exception) {
    return onDioError(exception, doNotReport);
  } on SocketException catch (e, s) {
    return const ApiResult.apiFailure(
      error: "No Internet Connection",
    );
  } on HandshakeException catch (e, s) {
    return const ApiResult.apiFailure(
      error: "No Internet Connection",
    );
  } on Exception catch (e) {
    return const ApiResult.apiFailure(
      error: "No Internet Connection",
    );
  }
}

ApiResult<T> onDioError<T>(
  DioError exception,
  List<int> ignore,
) {
  try {
    if (exception.type == DioErrorType.connectTimeout) {
      return const ApiResult.apiFailure(error: "Connection Timeout");
    }
    if (exception.type == DioErrorType.receiveTimeout) {
      return const ApiResult.apiFailure(error: ("Connection Timeout"));
    }

    if (exception.response == null || exception.response?.data == null) {
      return ApiResult.apiFailure(
        error: (exception.message),
      );
    }
    final response = exception.response!;
    final statusCode = response.statusCode ?? -2;

    var res = response.data;
    var error;
    if (res.runtimeType == String) {
      res = json.decode(res);
    }

    // possible error models that the api can return
    final errorModels = [
      'message',
      'error',
      'error.message',
      'data.message',
      'error.data.message',
    ];

    if (res is Map) {
      switch (statusCode) {
        case 503:
          error = 'Service unavailable. Please try again later.';
          break;
      }
      // Try to find the first message that matches the error model
      if (res.containsKey('fields')) {
        error = json.encode(res['fields']);
      } else {
        for (int i = 0; i < errorModels.length; i++) {
          error = _extractMessage(res, errorModels[i]);
          if (error != null) break; // Found our error message: Break loop
        }
      }
    }

    if (error != null) {
      return ApiResult.apiFailure(
        error: error,
      );
    }

    return ApiResult.apiFailure(
      error: exception.message,
    );
  } on Exception catch (e) {
    return ApiResult.apiFailure(
      error: e.toString(),
    );
  }
}

String? _extractMessage(Map data, String model) {
  final models = model.split('.');

  Map? extracted = data;
  try {
    for (int i = 0; i < models.length; i++) {
      final element = models[i];
      if (extracted![element] is String) return extracted[element];
      extracted = extracted[element];
    }
  } catch (e) {
    return null;
  }

  return null;
}
