import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/category_model.dart';

class CategoryService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          "${dotenv.env['API_URL']!}/categories/", // ← Change to production URL later
      headers: {
        "Content-Type": "application/json",
        'Authorization': dotenv.env['JWT_SECRET']!,
      },
    ),
  );

  Future<List<CategoryModel>> getAll() async {
    final res = await _dio.get('/');
    return (res.data as List).map((e) => CategoryModel.fromJson(e)).toList();
  }

  Future<List<CategoryModel>> getFeatured() async {
    final res = await _dio.get('/featured');
    return (res.data as List).map((e) => CategoryModel.fromJson(e)).toList();
  }

  Future<CategoryModel> followCategory(String categoryId, String userId) async {
    final res = await _dio.post(
      '/$categoryId/follow',
      data: {"userId": userId},
    );
    return CategoryModel.fromJson(res.data);
  }

  Future<CategoryModel> unfollowCategory(
    String categoryId,
    String userId,
  ) async {
    final res = await _dio.delete(
      '/$categoryId/follow',
      data: {"userId": userId},
    );
    return CategoryModel.fromJson(res.data);
  }
}
