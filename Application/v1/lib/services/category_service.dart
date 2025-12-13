import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/category_model.dart';

class CategoryService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "${dotenv.env['API_URL']!}/categories/",
      headers: {
        "Content-Type": "application/json",
        "Authorization": dotenv.env['JWT_SECRET']!,
      },
    ),
  );

  final Box _cacheBox = Hive.box('categoriesBox');

  // Fetch Cached Categories
  Future<List<CategoryModel>> getCachedCategories() async {
    final cached = _cacheBox.get('categories');
    if (cached != null) {
      return (jsonDecode(cached) as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  // 🔹 MAIN METHOD — offline-first load
  Future<List<CategoryModel>> getAll() async {
    // 1️⃣ Load cache first (instant)
    final cached = _cacheBox.get('categories');
    List<CategoryModel>? cachedCategories;
    if (cached != null) {
      cachedCategories = (jsonDecode(cached) as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    }

    // 2️⃣ Try online update (but don't block UI)
    try {
      final res = await _dio.get('/');
      final fresh = (res.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      // 3️⃣ Cache update
      _cacheBox.put('categories', jsonEncode(res.data));
      _cacheBox.put('categories_lastUpdated', DateTime.now().toIso8601String());

      return fresh;
    } catch (e) {
      // 4️⃣ On error (offline) → return cache if exists
      if (cachedCategories != null && cachedCategories.isNotEmpty) {
        return cachedCategories;
      } else {
        // 5️⃣ No cache, throw fallback error
        throw Exception('No internet connection and no cached data available');
      }
    }
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
