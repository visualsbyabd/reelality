import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "${dotenv.env['API_URL']!}/auth/",
      headers: {
        "Content-Type": "application/json",
        "Authorization": dotenv.env['JWT_SECRET']!,
      },
    ),
  );

  final Box _cacheBox = Hive.box('categoriesBox');
}
