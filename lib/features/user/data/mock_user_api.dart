import 'dart:convert';
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/user/data/mock_user_api_exception.dart';

/// Stands in for the users endpoint: waits like a network call, then returns
/// the decoded JSON body with every user. Some calls fail on purpose so the
/// app's error and retry paths get exercised.
@lazySingleton
class MockUserApi {
  const new(this._random);

  final Random _random;

  static const _latency = Duration(milliseconds: 500);
  static const _failureRate = 0.1;
  static const _responseBody = '''
[
  {"firstName": "Anna", "lastName": "Kowalska", "birthDate": "1992-04-17"},
  {"firstName": "Piotr", "lastName": "Nowak", "birthDate": "1985-11-30"},
  {"firstName": "Zofia", "lastName": "Wiśniewska", "birthDate": "2001-07-08"}
]''';

  Future<List<Map<String, dynamic>>> getUsers() =>
      Future<void>.delayed(_latency).then((_) {
        if (_random.nextDouble() < _failureRate) {
          throw const MockUserApiException();
        }
        return (jsonDecode(_responseBody) as List<dynamic>)
            .cast<Map<String, dynamic>>();
      });
}
