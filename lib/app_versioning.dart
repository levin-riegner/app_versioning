// Library Entry Point
library lr_app_versioning;

// Library Export Classes
export './src/config/api_config.dart';
export './src/config/api_versioning_endpoints.dart';
export './src/service/api_versioning_service.dart';
export './src/defaults/mock_api_versioning_service.dart';
export './src/util/version.dart';

// Class imports
import 'package:lr_app_versioning/src/defaults/default_api_versioning_service.dart';
import 'package:lr_app_versioning/src/lr_app_versioning.dart';
import 'package:lr_app_versioning/src/service/api_versioning_service.dart';
import 'package:meta/meta.dart';
import 'package:lr_app_versioning/src/config/api_config.dart';
import 'package:lr_app_versioning/src/model/api_versioning.dart';

abstract class AppVersioning {
  Future<ApiVersioning> getApiVersioning();

  void dispose();

  factory AppVersioning.defaultService({
    @required ApiConfig config,
    String domain,
  }) {
    return LRAppVersioning(
      apiVersioningService: DefaultApiVersioningService(config),
    );
  }

  factory AppVersioning({
    @required ApiVersioningService apiVersioningService,
  }) {
    return LRAppVersioning(
      apiVersioningService: apiVersioningService,
    );
  }
}
