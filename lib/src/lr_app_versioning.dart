import 'dart:io';

import 'package:lr_app_versioning/src/service/app_update_service.dart';
import 'package:meta/meta.dart';
import 'package:lr_app_versioning/app_versioning.dart';
import 'package:lr_app_versioning/src/service/api_versioning_service.dart';

class LRAppVersioning implements AppVersioning {
  final ApiVersioningService _apiVersioningService;
  final AppUpdateService _appUpdateService;

  LRAppVersioning({
    @required ApiVersioningService apiVersioningService,
    @required AppUpdateService appUpdateService,
  })  : assert(apiVersioningService != null),
        assert(appUpdateService != null),
        _apiVersioningService = apiVersioningService,
        _appUpdateService = appUpdateService;

  @override
  Future<Version> getMinimumApiVersion() async {
    // Get Api Versioning
    final apiVersioning = await _apiVersioningService.getApiVersioning();
    // Check Version by platform
    if (Platform.isIOS) {
      return apiVersioning.minimumIosVersion;
    } else {
      return apiVersioning.minimumAndroidVersion;
    }
  }

  @override
  Future<Version> getCurrentAppVersion() {
    return _appUpdateService.getCurrentVersion();
  }

  @override
  Future<bool> isUpdateRequired() async {
    // Get Minimum Api Version
    final minApiVersion = await getMinimumApiVersion();
    // Get Current Versioning
    final currentVersion = await _appUpdateService.getCurrentVersion();
    if (currentVersion == null) return false;
    // Update required if minimum api version is bigger than current
    return minApiVersion > currentVersion;
  }

  @override
  void launchUpdate() {
    _appUpdateService.launchUpdate();
  }

  @override
  void dispose() {}
}
