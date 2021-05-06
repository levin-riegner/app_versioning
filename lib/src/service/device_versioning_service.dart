import 'package:lr_app_versioning/src/util/version.dart';

abstract class DeviceVersioningService {
  Future<Version> getCurrentVersion();

  void launchUpdate({required bool updateInBackground});
}
