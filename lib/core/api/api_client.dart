import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';

class ApiClient {
  final Dio dio;

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
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storage = SecureStorage();
          final userToken = await storage.getToken();
          if (userToken != null) {
            options.headers['Authorization'] = 'Bearer $userToken';
          }
          handler.next(options);
        },
      ),
    );
  }
}
