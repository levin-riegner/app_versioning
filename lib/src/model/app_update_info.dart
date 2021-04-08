import 'package:lr_app_versioning/app_versioning.dart';

class AppUpdateInfo {
  final Version? currentVersion;
  final Version? minimumVersion;
  final bool isUpdateAvailable;
  final AppUpdateType? updateType;

  const AppUpdateInfo({
    required this.currentVersion,
    required this.minimumVersion,
    required this.isUpdateAvailable,
    required this.updateType,
  });

  @override
  String toString() {
    return 'AppUpdateInfo{currentVersion: $currentVersion, minimumVersion: $minimumVersion, isUpdateAvailable: $isUpdateAvailable, updateType: $updateType}';
  }
}

enum AppUpdateType { Optional, Mandatory }
