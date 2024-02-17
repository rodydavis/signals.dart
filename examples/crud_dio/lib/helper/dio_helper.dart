import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      contentType: Headers.jsonContentType,
    ),
  );

  DioClient._();

  static final instance = DioClient._();

  Dio get dio => _dio;
}
