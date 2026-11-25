import 'package:novian_recruitement_task/features/user/domain/user.dart';

/// Wire format of the user payload; `birthDate` arrives as an ISO-8601 date.
class UserDto {
  const new({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  factory fromJson(Map<String, dynamic> json) => UserDto(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    birthDate: json['birthDate'] as String,
  );

  final String firstName;
  final String lastName;
  final String birthDate;

  User toDomain() => User(
    firstName: firstName,
    lastName: lastName,
    birthDate: DateTime.parse(birthDate),
  );
}
