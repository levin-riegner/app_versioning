import 'package:lr_app_versioning/src/api/model/minimum_versioning.dart';
import 'package:lr_app_versioning/src/service/minimum_versioning_service.dart';

class MockMinimumVersioningService extends MinimumVersioningService {
  final String minimumIosVersion;
  final String minimumAndroidVersion;

  MockMinimumVersioningService({
    this.minimumIosVersion = "1.2.3",
    this.minimumAndroidVersion = "1.2.3",
  });

  /// Get api versioning. Throws [FailedToGetMinimumVersioning].
  @override
  Future<MinimumVersioning> getMinimumVersioning() async {
    return Future.value(MinimumVersioning(
      minimumIosVersionString: minimumIosVersion,
      minimumAndroidVersionString: minimumAndroidVersion,
    ));
  }
}
