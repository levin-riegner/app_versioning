import 'package:lr_app_versioning/src/model/exceptions.dart';

/// Error getting versioning from API
class FailedToGetMinimumVersioning implements AppVersioningException {
  final String? error;

  const FailedToGetMinimumVersioning({this.error});
}