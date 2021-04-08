import 'package:lr_app_versioning/app_versioning.dart';

class MinimumVersions {
  final Version ios;
  final Version android;

  const MinimumVersions({
    required this.ios,
    required this.android,
  });

  @override
  String toString() {
    return 'MinimumVersions{ios: $ios, android: $android}';
  }
}
