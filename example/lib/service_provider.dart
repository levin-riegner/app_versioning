import 'package:lr_app_versioning/app_versioning.dart';

abstract class ServiceProvider {
  static AppVersioning get appVersioning {
    return AppVersioning.defaultService(
      config: ApiConfig(
        endpoints: ApiVersioningEndpoints("https://api-staging.avenew.org"),
      ),
    );
  }
}
