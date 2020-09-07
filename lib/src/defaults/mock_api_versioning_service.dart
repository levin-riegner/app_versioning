import 'package:lr_app_versioning/src/model/api_versioning.dart';
import 'package:lr_app_versioning/src/service/api_versioning_service.dart';

class MockApiVersioningService extends ApiVersioningService {
  final String minimumIosVersion;
  final String minimumAndroidVersion;

  MockApiVersioningService({
    this.minimumIosVersion = "1.0.0",
    this.minimumAndroidVersion = "1.0.0",
  });

  /// Get api versioning. Throws [FailedToGetApiVersioning].
  @override
  Future<ApiVersioning> getApiVersioning() async {
    return Future.value(ApiVersioning(
      minimumIosVersionString: minimumIosVersion,
      minimumAndroidVersionString: minimumAndroidVersion,
    ));
  }
}
