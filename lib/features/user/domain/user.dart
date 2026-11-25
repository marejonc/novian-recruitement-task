import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

@CopyWith()
class User extends Equatable {
  const new({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  final String firstName;
  final String lastName;
  final DateTime birthDate;

  @override
  List<Object?> get props => [firstName, lastName, birthDate];
}
