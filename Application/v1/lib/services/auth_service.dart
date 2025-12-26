import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:v1/models/user_model.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "${dotenv.env['API_URL']!}/auth",
      followRedirects: true,
      headers: {
        "Content-Type": "application/json",
        "Authorization": dotenv.env['JWT_SECRET']!,
      },
    ),
  );

  final Box _cacheBox = Hive.box('categoriesBox');

  Future<Map> login({required String email, required String password}) async {
    // If The Credientials is correct; return 1;
    // If the Credinetials is incorrent; return 0;
    // If the user isn't existed; return -1
    // If their is an error; return -2
    try {
      final res = await _dio.patch(
        "",
        data: {"mode": "LOGIN", "email": email, "password": password},
      );
      switch (res.statusCode) {
        case 200:
          return {
            "statusCode": 1,
            "user": UserModel.fromJson(res.data["user"]),
          };
        case 301:
          return {"statusCode": 0};
        case 404:
          return {"statusCode": -1};
        default:
          return {"statusCode": -2};
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 308) {
        print("Redirect to: ${e.response?.headers['location']}");
      }
      print(e);
      return {"statusCode": -2};
    }
  }
}
