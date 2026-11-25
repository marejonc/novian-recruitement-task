import 'dart:convert';
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/user/data/mock_user_api_exception.dart';

/// Stands in for the user endpoint: waits like a network call, then returns
/// the decoded JSON body of one of a few users, picked at random. Some calls
/// fail on purpose so the app's error and retry paths get exercised.
@lazySingleton
class MockUserApi {
  const new(this._random);

  final Random _random;

  static const _latency = Duration(milliseconds: 1200);
  static const _failureRate = 0.2;
  static const _responseBodies = [
    '''
{"firstName": "Anna", "lastName": "Kowalska", "birthDate": "1992-04-17"}''',
    '''
{"firstName": "Piotr", "lastName": "Nowak", "birthDate": "1985-11-30"}''',
    '''
{"firstName": "Zofia", "lastName": "Wiśniewska", "birthDate": "2001-07-08"}''',
  ];

  Future<Map<String, dynamic>> getUser() =>
      Future<void>.delayed(_latency).then((_) {
        if (_random.nextDouble() < _failureRate) {
          throw const MockUserApiException();
        }
        final body = _responseBodies[_random.nextInt(_responseBodies.length)];
        return jsonDecode(body) as Map<String, dynamic>;
      });
}
