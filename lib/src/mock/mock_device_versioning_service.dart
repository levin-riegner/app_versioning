import 'package:lr_app_versioning/src/service/device_versioning_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';

class MockDeviceVersioningService extends DeviceVersioningService {
  final String currentVersionString;

  MockDeviceVersioningService({
    this.currentVersionString = "1.2.3",
  });

  @override
  Future<Version> getCurrentVersion() async {
    return Future.value(Version.parse(currentVersionString));
  }

  @override
  void launchUpdate({required bool updateInBackground}) {
    // Do nothing
  }
}
