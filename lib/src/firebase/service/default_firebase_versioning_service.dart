// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lr_app_versioning/app_versioning.dart';
import 'package:lr_app_versioning/src/firebase/config/remote_config_keys.dart';
import 'package:lr_app_versioning/src/model/minimum_versions.dart';
import 'package:lr_app_versioning/src/service/minimum_versioning_service.dart';

class DefaultFirebaseVersioningService extends MinimumVersioningService {
  final RemoteConfigKeys remoteConfigKeys;

  DefaultFirebaseVersioningService(this.remoteConfigKeys);

  /// Get api versioning. Throws [FailedToGetMinimumVersioning].
  @override
  Future<MinimumVersions> getMinimumVersions() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    // Fetch and Activate configs
    try {
      await remoteConfig.fetch();
      await remoteConfig.activateFetched();
      // Get Version String
      final iosVersionString =
          remoteConfig.getString(remoteConfigKeys.minimumIosVersionKey);
      final androidVersionString =
          remoteConfig.getString(remoteConfigKeys.minimumAndroidVersionKey);
      // Parse Versions
      final iosVersion = Version.parse(iosVersionString);
      final androidVersion = Version.parse(androidVersionString);
      return MinimumVersions(
        ios: iosVersion,
        android: androidVersion,
      );
    } catch (e) {
      throw FailedToGetMinimumVersions(error: e.toString());
    }
  }
}
