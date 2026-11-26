import 'package:json_annotation/json_annotation.dart';
import 'package:novian_recruitement_task/features/user/domain/user.dart';

part 'user_dto.g.dart';

/// Wire format of the user payload; `birthDate` arrives as an ISO-8601 date
/// and is parsed into a [DateTime] by the generated `fromJson`.
@JsonSerializable(createToJson: false)
class UserDto {
  const new({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  factory fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  final String firstName;
  final String lastName;
  final DateTime birthDate;

  User toDomain() => User(
    firstName: firstName,
    lastName: lastName,
    birthDate: birthDate,
  );
}
