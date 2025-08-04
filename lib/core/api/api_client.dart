import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';
import '../utils/app_logger.dart'; // import logger

class ApiClient {
  final Dio dio;
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) {
    return dio.post(path, data: data, options: options);
  }

  Future<Response> put(String path, {dynamic data}) {
    return dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return dio.delete(path);
  }

  ApiClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://airbnbnew.cybersoft.edu.vn/api',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json-patch+json',
            'tokenCybersoft':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJGbHV0dGVyIDAxIiwiSGV0SGFuU3RyaW5nIjoiMDkvMTEvMjAyNSIsIkhldEhhblRpbWUiOiIxNzYyNjQ2NDAwMDAwIiwibmJmIjoxNzM2MTIxNjAwLCJleHAiOjE3NjI4MTkyMDB9.We_FRRLkEJB271FX0Gcjbsfxsnl5YAym7uhkcKXulSQ',
          },
        ),
      ) {
    // Gắn interceptor để log
    AppLogger.attachDioLogger(dio);

    // Gắn interceptor để thêm Authorization token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storage = SecureStorage();
          final userToken = await storage.readToken();
          if (userToken != null) {
            options.headers['Authorization'] = 'Bearer $userToken';
          }
          handler.next(options);
        },
      ),
    );
  }
}
