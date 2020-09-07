import 'package:lr_app_versioning/src/model/api_versioning.dart';

abstract class ApiVersioningService {
  Future<ApiVersioning> getApiVersioning();
}