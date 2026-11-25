import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/user/domain/user.dart';
import 'package:novian_recruitement_task/features/user/domain/user_repository.dart';

@injectable
class GetUserUseCase {
  const new(this._userRepository);

  final UserRepository _userRepository;

  Future<User> call() => _userRepository.fetchUser();
}
