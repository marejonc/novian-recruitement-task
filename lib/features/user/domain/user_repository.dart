import 'package:novian_recruitement_task/features/user/domain/user.dart';

abstract interface class UserRepository {
  Future<List<User>> fetchUsers();
}
