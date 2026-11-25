import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/user/data/mock_user_api.dart';
import 'package:novian_recruitement_task/features/user/data/user_dto.dart';
import 'package:novian_recruitement_task/features/user/domain/user.dart';
import 'package:novian_recruitement_task/features/user/domain/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const new(this._api);

  final MockUserApi _api;

  @override
  Future<User> fetchUser() =>
      _api.getUser().then((json) => UserDto.fromJson(json).toDomain());
}
