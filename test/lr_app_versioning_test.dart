import 'package:flutter_test/flutter_test.dart';
import 'package:lr_app_versioning/app_versioning.dart';
import 'package:lr_app_versioning/src/api/service/mock_api_versioning_service.dart';
import 'package:lr_app_versioning/src/device/service/mock_device_versioning_service.dart';
import 'package:lr_app_versioning/src/model/app_update_info.dart';

void main() {
  test('Mandatory Update Required', () async {
    // Init Test Values
    final Version minimumApiVersion = Version.parse("1.2.3");
    final Version currentAppVersion = Version.parse("1.0.0");

    // Setup Mock Service
    final appVersioning = AppVersioning(
      minimumVersioningService: MockMinimumVersioningService(
        minimumIosVersion: minimumApiVersion.toString(),
        minimumAndroidVersion: minimumApiVersion.toString(),
      ),
      appUpdateService: MockDeviceVersioningService(
        currentVersionString: currentAppVersion.toString(),
      ),
    );

    // Get App Update Info
    final appUpdateInfo = await appVersioning.getAppUpdateInfo();
    expect(appUpdateInfo.currentVersion, currentAppVersion);
    expect(appUpdateInfo.isUpdateAvailable, true);
    expect(appUpdateInfo.updateType, AppUpdateType.Mandatory);

    // Get Current Version
    final currentVersion = await appVersioning.getCurrentAppVersion();
    expect(currentVersion, currentAppVersion);

  });

  test('No Update Required', () async {
    // Init Test Values
    final Version minimumApiVersion = Version.parse("0.0.0");
    final Version currentAppVersion = Version.parse("1.0.0");

    // Setup Mock Service
    final appVersioning = AppVersioning(
      minimumVersioningService: MockMinimumVersioningService(
        minimumIosVersion: minimumApiVersion.toString(),
        minimumAndroidVersion: minimumApiVersion.toString(),
      ),
      appUpdateService: MockDeviceVersioningService(
        currentVersionString: currentAppVersion.toString(),
      ),
    );

    // Get App Update Info
    final appUpdateInfo = await appVersioning.getAppUpdateInfo();
    expect(appUpdateInfo.currentVersion, currentAppVersion);
    expect(appUpdateInfo.isUpdateAvailable, false);
  });
}
