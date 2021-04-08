abstract class AppVersioningException implements Exception {}

/// Error getting minimum versions constraints
class FailedToGetMinimumVersions implements AppVersioningException {
  final String? error;

  const FailedToGetMinimumVersions({this.error});

  @override
  String toString() {
    return 'FailedToGetMinimumVersions{error: $error}';
  }
}

/// Error getting current version from device
class FailedToGetCurrentVersion implements AppVersioningException {
  final String? error;

  const FailedToGetCurrentVersion({this.error});

  @override
  String toString() {
    return 'FailedToGetCurrentVersion{error: $error}';
  }
}
