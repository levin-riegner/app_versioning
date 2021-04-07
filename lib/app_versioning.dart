// Library Entry Point
library lr_app_versioning;

// Library Export Classes
export './src/config/api_config.dart';
export './src/config/update_config.dart';
export './src/config/api_versioning_endpoints.dart';
export './src/service/api_versioning_service.dart';
export './src/defaults/mock_api_versioning_service.dart';
export './src/service/app_update_service.dart';
export './src/defaults/mock_app_update_service.dart';
export './src/util/version.dart';

// Class imports
import 'package:lr_app_versioning/src/config/update_config.dart';
import 'package:lr_app_versioning/src/defaults/default_api_versioning_service.dart';
import 'package:lr_app_versioning/src/defaults/default_app_update_service.dart';
import 'package:lr_app_versioning/src/lr_app_versioning.dart';
import 'package:lr_app_versioning/src/service/api_versioning_service.dart';
import 'package:lr_app_versioning/src/service/app_update_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';
import 'package:lr_app_versioning/src/config/api_config.dart';

abstract class AppVersioning {
  Future<Version?> getMinimumApiVersion();

  Future<Version?> getCurrentAppVersion();

  Future<bool> isUpdateRequired();

  //Future<bool> hasOptionalUpdateAvailable();

  void launchUpdate();

  void dispose();

  factory AppVersioning.defaultService({
    required ApiConfig apiConfig,
    required UpdateConfig updateConfig,
  }) {
    return LRAppVersioning(
      apiVersioningService: DefaultApiVersioningService(apiConfig),
      appUpdateService: DefaultAppUpdateService(updateConfig),
    );
  }

  factory AppVersioning({
    required ApiVersioningService apiVersioningService,
    required AppUpdateService appUpdateService,
  }) {
    return LRAppVersioning(
      apiVersioningService: apiVersioningService,
      appUpdateService: appUpdateService,
    );
  }
}
