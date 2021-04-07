import 'package:lr_app_versioning/app_versioning.dart';

class AppUpdateInfo {
  final Version? currentVersion;
  final bool isUpdateAvailable;
  final AppUpdateType? updateType;

  const AppUpdateInfo({
    required this.currentVersion,
    required this.isUpdateAvailable,
    required this.updateType,
  });

  @override
  String toString() {
    return 'AppUpdateInfo{currentVersion: $currentVersion, isUpdateAvailable: $isUpdateAvailable, updateType: $updateType}';
  }
}

enum AppUpdateType { Optional, Mandatory }
