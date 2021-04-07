import 'package:lr_app_versioning/src/util/version.dart';

class MinimumVersioning {
  final String? minimumIosVersionString;
  final String? minimumAndroidVersionString;

  const MinimumVersioning({
    this.minimumIosVersionString,
    this.minimumAndroidVersionString,
  });

  Version get minimumIosVersion =>
      Version.tryParse(minimumIosVersionString) ?? Version.parse("0.0.0");

  Version get minimumAndroidVersion =>
      Version.tryParse(minimumAndroidVersionString) ?? Version.parse("0.0.0");

  factory MinimumVersioning.fromJson(Map<String, dynamic> map) {
    return new MinimumVersioning(
      minimumIosVersionString: map['minimumIosVersion'] as String?,
      minimumAndroidVersionString: map['minimumAndroidVersion'] as String?,
    );
  }
}
