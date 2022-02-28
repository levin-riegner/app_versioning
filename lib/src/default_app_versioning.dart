import 'dart:io';

import 'package:lr_app_versioning/app_versioning.dart';
import 'package:lr_app_versioning/src/service/optional_update_service.dart';
import 'package:lr_app_versioning/src/util/version_tracker.dart';

class DefaultAppVersioning implements AppVersioning {
  final MinimumVersioningService _minimumVersioningService;
  final DeviceVersioningService _appUpdateService;
  final OptionalUpdateService _optionalUpdateService;

  DefaultAppVersioning({
    required MinimumVersioningService minimumVersioningService,
    required DeviceVersioningService appUpdateService,
    required OptionalUpdateService optionalUpdateService,
  })   : _minimumVersioningService = minimumVersioningService,
        _appUpdateService = appUpdateService,
        _optionalUpdateService = optionalUpdateService;

  @override
  VersionTracker get tracker => VersionTracker.instance;

  @override
  Future<Version> getCurrentAppVersion() {
    return _appUpdateService.getCurrentVersion();
  }

  @override
  Future<AppUpdateInfo> getAppUpdateInfo() async {
    // Get Minimum Version
    final minimumVersion = await _getMinimumVersion();
    // Get Current Versioning
    try {
      final currentVersion = await _appUpdateService.getCurrentVersion();
      // Update required if minimum version is bigger than current
      if (minimumVersion > currentVersion) {
        // Has Mandatory Update
        return AppUpdateInfo(
          currentVersion: currentVersion,
          minimumVersion: minimumVersion,
          isUpdateAvailable: minimumVersion > currentVersion,
          updateType: AppUpdateType.Mandatory,
        );
      } else {
        // Check Optional Update on the stores
        final optionalUpdateAvailable = await _optionalUpdateService
            .isOptionalUpdateAvailable(currentVersion);
        return AppUpdateInfo(
          currentVersion: currentVersion,
          minimumVersion: minimumVersion,
          isUpdateAvailable: optionalUpdateAvailable,
          updateType: AppUpdateType.Optional,
        );
      }
    } on FailedToGetCurrentVersion catch (e) {
      print("Failed to get current app Version");
      print(e);
      return AppUpdateInfo(
        currentVersion: null,
        minimumVersion: null,
        isUpdateAvailable: false,
        updateType: null,
      );
    }
  }

  @override
  void launchUpdate({required bool updateInBackground}) {
    _appUpdateService.launchUpdate(updateInBackground: updateInBackground);
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
    } on FailedToGetMinimumVersions catch (e) {
      print("Failed to get Minimum Version");
      print(e);
      return Version.parse("0.0.0");
    }
  }
// endregion
}
