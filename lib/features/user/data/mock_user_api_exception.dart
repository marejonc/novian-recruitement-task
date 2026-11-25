/// Thrown by `MockUserApi` to simulate a failed request.
class MockUserApiException implements Exception {
  const new();

  @override
  String toString() => 'MockUserApiException: simulated network failure';
}
