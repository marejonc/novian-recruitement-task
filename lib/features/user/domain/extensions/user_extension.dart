import 'package:novian_recruitement_task/features/user/domain/user.dart';

extension UserExtension on User {
  /// Full years lived at [now]; one year is added only once the birthday in
  /// that year has passed.
  int ageAt(DateTime now) {
    final hasHadBirthdayThisYear =
        now.month > birthDate.month ||
        (now.month == birthDate.month && now.day >= birthDate.day);
    final age = now.year - birthDate.year;
    return hasHadBirthdayThisYear ? age : age - 1;
  }
}
