// Library Entry Point
library lr_app_versioning;

// Class imports
import 'package:lr_app_versioning/src/api/config/api_config.dart';
import 'package:lr_app_versioning/src/api/service/default_api_versioning_service.dart';
import 'package:lr_app_versioning/src/default_app_versioning.dart';
import 'package:lr_app_versioning/src/device/config/update_config.dart';
import 'package:lr_app_versioning/src/device/service/default_device_versioning_service.dart';
import 'package:lr_app_versioning/src/firebase/config/remote_config_keys.dart';
import 'package:lr_app_versioning/src/firebase/service/default_firebase_versioning_service.dart';
import 'package:lr_app_versioning/src/model/app_update_info.dart';
import 'package:lr_app_versioning/src/optional/default_optional_update_service.dart';
import 'package:lr_app_versioning/src/service/device_versioning_service.dart';
import 'package:lr_app_versioning/src/service/minimum_versioning_service.dart';
import 'package:lr_app_versioning/src/service/optional_update_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';
import 'package:lr_app_versioning/src/util/version_tracker.dart';

// Library Export Classes
export 'src/api/exports.dart';
export 'src/device/exports.dart';
export 'src/firebase/exports.dart';
export 'src/model/app_update_info.dart';
export 'src/model/exceptions.dart';
export 'src/model/minimum_versions.dart';
export 'src/optional/default_optional_update_service.dart';
export 'src/service/device_versioning_service.dart';
export 'src/service/minimum_versioning_service.dart';
export 'src/util/version.dart';

abstract class AppVersioning {
  VersionTracker get tracker;

  Future<Version> getCurrentAppVersion();

  Future<AppUpdateInfo> getAppUpdateInfo();

  void launchUpdate({required bool updateInBackground});

  void dispose();

  factory AppVersioning.apiService({
    required ApiConfig apiConfig,
    required UpdateConfig updateConfig,
  }) {
    return DefaultAppVersioning(
      minimumVersioningService: DefaultApiVersioningService(apiConfig),
      appUpdateService: DefaultDeviceVersioningService(updateConfig),
      optionalUpdateService: DefaultOptionalUpdateService(updateConfig),
    );
  }

  factory AppVersioning.firebaseService({
    required RemoteConfigKeys remoteConfigKeys,
    required UpdateConfig updateConfig,
  }) {
    return DefaultAppVersioning(
      minimumVersioningService:
          DefaultFirebaseVersioningService(remoteConfigKeys),
      appUpdateService: DefaultDeviceVersioningService(updateConfig),
      optionalUpdateService: DefaultOptionalUpdateService(updateConfig),
    );
  }

  factory AppVersioning({
    required MinimumVersioningService minimumVersioningService,
    required DeviceVersioningService appUpdateService,
    required OptionalUpdateService optionalUpdateService,
  }) {
    return DefaultAppVersioning(
      minimumVersioningService: minimumVersioningService,
      appUpdateService: appUpdateService,
      optionalUpdateService: optionalUpdateService,
    );
  }
}
