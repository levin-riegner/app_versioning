import 'package:flutter_test/flutter_test.dart';
import 'package:lr_app_versioning/app_versioning.dart';

void main() {
  test('Update Required', () async {
    // Init Test Values
    final Version minimumApiVersion = Version.parse("1.2.3");
    final Version currentAppVersion = Version.parse("1.0.0");

    // Setup Mock Service
    final appVersioning = AppVersioning(
      apiVersioningService: MockApiVersioningService(
        minimumIosVersion: minimumApiVersion.toString(),
        minimumAndroidVersion: minimumApiVersion.toString(),
      ),
      appUpdateService: MockAppUpdateService(
        currentVersionString: currentAppVersion.toString(),
      ),
    );

    // Get Min Api Version
    final minApiVersion = await appVersioning.getMinimumApiVersion();
    expect(minApiVersion, minimumApiVersion);

    // Get Current Version
    final currentVersion = await appVersioning.getCurrentAppVersion();
    expect(currentVersion, currentAppVersion);

    // Assert update is required
    final isUpdateRequired = await appVersioning.isUpdateRequired();
    expect(isUpdateRequired, true);
  });

  test('No Update Required', () async {
    // Init Test Values
    final Version minimumApiVersion = Version.parse("0.0.0");
    final Version currentAppVersion = Version.parse("1.0.0");

    // Setup Mock Service
    final appVersioning = AppVersioning(
      apiVersioningService: MockApiVersioningService(
        minimumIosVersion: minimumApiVersion.toString(),
        minimumAndroidVersion: minimumApiVersion.toString(),
      ),
      appUpdateService: MockAppUpdateService(
        currentVersionString: currentAppVersion.toString(),
      ),
    );

    // Assert update is required
    final isUpdateRequired = await appVersioning.isUpdateRequired();
    expect(isUpdateRequired, false);
  });
}
