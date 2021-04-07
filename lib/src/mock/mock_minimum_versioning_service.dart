import 'package:lr_app_versioning/src/model/minimum_versions.dart';
import 'package:lr_app_versioning/src/service/minimum_versioning_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';

class MockMinimumVersioningService extends MinimumVersioningService {
  final String minimumIosVersion;
  final String minimumAndroidVersion;

  MockMinimumVersioningService({
    this.minimumIosVersion = "1.2.3",
    this.minimumAndroidVersion = "1.2.3",
  });

  @override
  Future<MinimumVersions> getMinimumVersions() async {
    return Future.value(MinimumVersions(
      ios: Version.parse(minimumIosVersion),
      android: Version.parse(minimumAndroidVersion),
    ));
  }
}
