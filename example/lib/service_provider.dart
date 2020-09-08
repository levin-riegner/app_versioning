import 'package:lr_app_versioning/app_versioning.dart';

abstract class ServiceProvider {
  static AppVersioning get appVersioning {
    return AppVersioning.defaultService(
      apiConfig: ApiConfig(
        endpoints: ApiVersioningEndpoints("https://api-staging.avenew.org"),
      ),
      updateConfig: UpdateConfig(
        appStoreAppId: "1529797327",
        playStoreAppId: "org.avenew.activist",
      )
    );
  }
}
