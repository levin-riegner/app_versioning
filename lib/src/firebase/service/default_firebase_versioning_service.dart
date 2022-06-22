// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:app_versioning/app_versioning.dart';

class DefaultFirebaseVersioningService extends MinimumVersioningService {
  final RemoteConfigKeys remoteConfigKeys;

  DefaultFirebaseVersioningService(this.remoteConfigKeys);

  /// Get minimum remote config versions. Throws [FailedToGetMinimumVersioning].
  @override
  Future<MinimumVersions> getMinimumVersions() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    // Fetch and Activate configs
    try {
      await remoteConfig.fetchAndActivate();
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
