
import 'package:lr_app_versioning/src/service/app_update_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';


class MockAppUpdateService extends AppUpdateService {
  final String currentVersionString;

  MockAppUpdateService({
    this.currentVersionString = "1.2.3",
  });

  @override
  Future<Version> getCurrentVersion() async {
    return Future.value(Version.parse(currentVersionString));
  }

  @override
  void launchUpdate() {
    // Do nothing
  }
}
