import 'package:flutter_test/flutter_test.dart';
import 'package:lr_app_versioning/app_versioning.dart';

void main() {
  test('Test Api Versioning', () async {
    // Init Test Values
    final String minimumIosVersion = "1.0.0";
    final String minimumAndroidVersion = "1.0.0";

    // Setup Mock Service
    final appVersioning = AppVersioning(
      apiVersioningService: MockApiVersioningService(
        minimumIosVersion: minimumIosVersion,
        minimumAndroidVersion: minimumAndroidVersion,
      ),
    );

    // Request apiVersioning
    final apiVersioning = await appVersioning.getApiVersioning();

    // Check min Versions in response
    expect(apiVersioning.minimumIosVersion, minimumIosVersion);
    expect(apiVersioning.minimumAndroidVersion, minimumAndroidVersion);
  });
}
