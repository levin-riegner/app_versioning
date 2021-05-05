import 'package:lr_app_versioning/app_versioning.dart';

abstract class ServiceProvider {
  static AppVersioning get appVersioning {
    return AppVersioning.apiService(
      apiConfig: ApiConfig(
        endpoints: ApiVersioningEndpoints(
          "https://api.example.org",
          minimumVersioningEndpoint: "api/api-compatibility",
        ),
      ),
      updateConfig: UpdateConfig(
        appStoreAppId: "1234567890",
        playStoreAppId: "org.example.versioning",
      ),
    );
  }
}
