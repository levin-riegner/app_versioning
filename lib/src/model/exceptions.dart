// Exceptions
abstract class AppVersioningException implements Exception {}

/// Error getting versioning from API
class FailedToGetApiVersioning implements AppVersioningException {
  final String error;
  const FailedToGetApiVersioning({this.error});
}
