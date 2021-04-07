import 'dart:io';

import 'package:lr_app_versioning/app_versioning.dart';
import 'package:lr_app_versioning/src/model/app_update_info.dart';
import 'package:lr_app_versioning/src/service/device_versioning_service.dart';
import 'package:lr_app_versioning/src/service/minimum_versioning_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';

class DefaultAppVersioning implements AppVersioning {
  final MinimumVersioningService _minimumVersioningService;
  final DeviceVersioningService _appUpdateService;

  DefaultAppVersioning({
    required MinimumVersioningService minimumVersioningService,
    required DeviceVersioningService appUpdateService,
  })   : _minimumVersioningService = minimumVersioningService,
        _appUpdateService = appUpdateService;

  @override
  Future<Version> getCurrentAppVersion() {
    return _appUpdateService.getCurrentVersion();
  }

  @override
  Future<AppUpdateInfo> getAppUpdateInfo() async {
    // Get Minimum Version
    final minimumVersion = await _getMinimumVersion();
    // TODO: Consider retrieving current app store version for optional update
    // Get Current Versioning
    try {
      final currentVersion = await _appUpdateService.getCurrentVersion();
      // Update required if minimum version is bigger than current
      return AppUpdateInfo(
        currentVersion: currentVersion,
        isUpdateAvailable: minimumVersion > currentVersion,
        updateType: AppUpdateType.Mandatory,
      );
    } on FailedToGetCurrentVersion {
      print("Failed to get current app Version");
      return AppUpdateInfo(
        currentVersion: null,
        isUpdateAvailable: false,
        updateType: null,
      );
    }
  }

  @override
  void launchUpdate() {
    _appUpdateService.launchUpdate();
  }

  @override
  void dispose() {}

  // region Private
  Future<Version> _getMinimumVersion() async {
    // Get Minimum Versioning
    try {
      final minimumVersions =
          await _minimumVersioningService.getMinimumVersions();
      // Check Version by platform
      if (Platform.isIOS) {
        return minimumVersions.ios;
      } else {
        return minimumVersions.android;
      }
    } on FailedToGetMinimumVersions {
      print("Failed to get Minimum Version");
      return Version.parse("0.0.0");
    }
  }
// endregion
}
