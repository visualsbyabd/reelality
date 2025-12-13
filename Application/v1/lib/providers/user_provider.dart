import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import '../controllers/user_controller.dart';

/// Provides an instance of [UserService] for dependency injection.
final userServiceProvider = Provider<UserService>((ref) => UserService());

/// Manages the currently logged-in user’s state reactively.
final currentUserProvider = AsyncNotifierProvider<UserController, UserModel?>(
  () => UserController(),
);
