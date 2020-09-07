import 'package:meta/meta.dart';
import 'package:lr_app_versioning/app_versioning.dart';
import 'package:lr_app_versioning/src/model/api_versioning.dart';
import 'package:lr_app_versioning/src/service/api_versioning_service.dart';

class LRAppVersioning implements AppVersioning {
  final ApiVersioningService _apiVersioningService;

  LRAppVersioning({
    @required ApiVersioningService apiVersioningService,
  })  : assert(apiVersioningService != null),
        _apiVersioningService = apiVersioningService;

  @override
  Future<ApiVersioning> getApiVersioning() {
    return _apiVersioningService.getApiVersioning();
  }

  @override
  void dispose() {

  }
}
