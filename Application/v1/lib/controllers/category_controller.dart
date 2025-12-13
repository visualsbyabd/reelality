import 'dart:async';

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
    return await _service.getAll();
  }

  Future<void> refreshCategories() async {
    state = const AsyncLoading();
    final categories = await _service.getAll();
    state = AsyncData(categories);
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
