import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // số dòng stacktrace
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyDate,
    ),
  );

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void warning(dynamic message) {
    _logger.w(message);
  }

  static void error(dynamic message) {
    _logger.e(message);
  }

  static void prettyJson(dynamic jsonObject, {String? tag}) {
    try {
      if (jsonObject is Map || jsonObject is List) {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        final prettyString = encoder.convert(jsonObject);
        _logger.i('${tag != null ? '[$tag]' : ''}\n$prettyString');
      } else {
        _logger.i('${tag != null ? '[$tag] ' : ''}${jsonObject.toString()}');
      }
    } catch (e) {
      warning('prettyJson error: $e');
      info(jsonObject.toString());
    }
  }

  // Gắn interceptor để log toàn bộ request/response/error
  static void attachDioLogger(dynamic dioInstance) {
    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('[DIO Request] ${options.method} ${options.uri}');
          _logger.i('Headers: ${options.headers}');
          if (options.data != null) {
            prettyJson(options.data, tag: 'Request Data');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i(
            '[DIO Response] ${response.requestOptions.method} ${response.requestOptions.uri}',
          );
          prettyJson(response.data, tag: 'Response Data');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e('[DIO Error] ${e.requestOptions.uri}');
          if (e.response != null) {
            prettyJson(e.response?.data, tag: 'Error Response');
          } else {
            _logger.e('Error message: ${e.message}');
          }
          return handler.next(e);
        },
      ),
    );
  }
}
