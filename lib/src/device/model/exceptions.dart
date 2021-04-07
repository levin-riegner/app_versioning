import 'package:lr_app_versioning/src/model/exceptions.dart';

/// Error getting current version from device
class FailedToGetCurrentVersion implements AppVersioningException {
  final String? error;

  const FailedToGetCurrentVersion({this.error});
}