import 'dart:io';

import 'package:lr_app_versioning/src/config/update_config.dart';
import 'package:lr_app_versioning/src/service/app_update_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultAppUpdateService extends AppUpdateService {
  final UpdateConfig config;

  DefaultAppUpdateService(this.config) : assert(config != null);

  @override
  Future<Version?> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersionString = packageInfo.version;
    final currentVersion = Version.tryParse(currentVersionString);
    return currentVersion;
  }

  @override
  void launchUpdate() {
    final appStoreUrl = "https://apps.apple.com/us/app/id${config.appStoreAppId}";
    final playStoreUrl = "https://play.google.com/store/apps/details?id=${config.playStoreAppId}";
    print(playStoreUrl);
    if (Platform.isIOS) {
      launch(appStoreUrl);
    } else {
      launch(playStoreUrl);
    }
  }
}
