library optional_update;

import 'dart:io';

import 'package:in_app_update/in_app_update.dart' as iau;
import 'package:lr_app_versioning/src/device/config/update_config.dart';
import 'package:lr_app_versioning/src/service/optional_update_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';
import 'package:upgrader/upgrader.dart';

export 'default_optional_update_service.dart';

class DefaultOptionalUpdateService implements OptionalUpdateService {
  final UpdateConfig updateConfig;

  DefaultOptionalUpdateService(this.updateConfig);

  @override
  Future<bool> isOptionalUpdateAvailable(Version currentVersion) async {
    try {
      // Check Optional Update on the stores
      if (Platform.isAndroid && updateConfig.appStoreAppId != null) {
        final info = await iau.InAppUpdate.checkForUpdate();
        // Optional Android Update
        return info.updateAvailability ==
            iau.UpdateAvailability.updateAvailable;
      } else if (Platform.isIOS && updateConfig.appStoreAppId != null) {
        // Query AppStore
        final iTunesResults = await ITunesSearchAPI().lookupById(
          updateConfig.appStoreAppId!,
          country: updateConfig.appstoreCountryCode,
        );
        if (iTunesResults != null) {
          // Parse AppStore response
          final iTunesVersionString = ITunesResults.version(iTunesResults);
          final iTunesVersion = Version.tryParse(iTunesVersionString);
          // Check greater version available
          if (iTunesVersion != null) {
            return iTunesVersion > currentVersion;
          }
          return false;
        }
        return false;
      } else {
        print("Cannot get AppUpdate on unsupported platform");
        return false;
      }
    } catch (e) {
      print("Error getting optional update");
      print(e);
      return false;
    }
  }
}
