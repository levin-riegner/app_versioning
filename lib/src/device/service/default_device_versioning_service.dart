import 'dart:io';

import 'package:in_app_update/in_app_update.dart' as iau;
import 'package:lr_app_versioning/app_versioning.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultDeviceVersioningService extends DeviceVersioningService {
  final UpdateConfig config;

  DefaultDeviceVersioningService(this.config);

  /// Get api versioning. Throws [FailedToGetCurrentVersion].
  @override
  Future<Version> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersionString = packageInfo.version;
    try {
      final currentVersion = Version.parse(currentVersionString);
      return currentVersion;
    } catch (e) {
      throw FailedToGetCurrentVersion(error: e.toString());
    }
  }

  /// Launches App Update.
  @override
  void launchUpdate({required bool updateInBackground}) async {
    try {
      if (config.appStoreAppId != null && Platform.isIOS) {
        // Open AppStore URL
        final appStoreUrl =
            "https://apps.apple.com/${config.appstoreCountryCode}/app/id${config.appStoreAppId}";
        launch(appStoreUrl);
      } else if (config.playStoreAppId != null && Platform.isAndroid) {
        // Use Android In-App Update
        if (updateInBackground) {
          await iau.InAppUpdate.startFlexibleUpdate();
          await iau.InAppUpdate.completeFlexibleUpdate();
        } else {
          await iau.InAppUpdate.performImmediateUpdate();
        }
      } else {
        print("Unsupported platform or missing config parameters: $config");
      }
    } catch (e) {
      print("Error launching app update");
      print(e);
    }
  }
}
