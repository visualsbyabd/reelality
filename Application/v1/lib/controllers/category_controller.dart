import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

final categoryServiceProvider = Provider<CategoryService>(
  (ref) => CategoryService(),
);

final categoryControllerProvider =
    AsyncNotifierProvider<CategoryController, List<CategoryModel>>(
      () => CategoryController(),
    );

class CategoryController extends AsyncNotifier<List<CategoryModel>> {
  late CategoryService _service;

  @override
  FutureOr<List<CategoryModel>> build() async {
    _service = ref.read(categoryServiceProvider);

    // 1️⃣ Get cached data immediately
    final cached = await _service.getCachedCategories();

    // 2️⃣ If we have cached data, show it right away
    if (cached.isNotEmpty) {
      // Render cached instantly
      state = AsyncData(cached);

      // 3️⃣ Try to refresh in background (non-blocking)
      unawaited(_refreshInBackground());
      return cached;
    }

    // 4️⃣ No cache? Then wait for network normally
    final fresh = await _service.getAll();
    return fresh;
  }

  Future<void> _refreshInBackground() async {
    try {
      final fresh = await _service.getAll();
      // Update state silently if new data exists
      if (fresh.isNotEmpty) state = AsyncData(fresh);
    } catch (_) {
      // Don’t throw or interrupt UI
    }
  }

  Future<void> followCategory(String id, String userId) async {
    final updated = await _service.followCategory(id, userId);
    final current = state.value ?? [];
    final newList = current.map((cat) => cat.id == id ? updated : cat).toList();
    state = AsyncData(newList);
  }

  Future<void> unfollowCategory(String id, String userId) async {
    final updated = await _service.unfollowCategory(id, userId);
    final current = state.value ?? [];
    final newList = current.map((cat) => cat.id == id ? updated : cat).toList();
    state = AsyncData(newList);
  }
}
