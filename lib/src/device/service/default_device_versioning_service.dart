import 'dart:io';

import 'package:lr_app_versioning/app_versioning.dart';
import 'package:lr_app_versioning/src/device/config/update_config.dart';
import 'package:lr_app_versioning/src/service/device_versioning_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';
import 'package:package_info/package_info.dart';
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

  @override
  void launchUpdate() {
    if (config.appStoreAppId != null && Platform.isIOS) {
      final appStoreUrl =
          "https://apps.apple.com/us/app/id${config.appStoreAppId}";
      launch(appStoreUrl);
    } else if (config.playStoreAppId != null && Platform.isAndroid) {
      // TODO: Consider using In-App Update
      final playStoreUrl =
          "https://play.google.com/store/apps/details?id=${config.playStoreAppId}";
      launch(playStoreUrl);
    } else {
      print("Unsupported platform or missing config parameters: $config");
    }
  }
}
