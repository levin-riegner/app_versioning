import 'package:lr_app_versioning/app_versioning.dart';

abstract class AppUpdateService {
  Future<Version?> getCurrentVersion();
  void launchUpdate();
}
