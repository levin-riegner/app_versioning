import 'dart:convert';

import 'package:lr_app_versioning/src/config/api_config.dart';
import 'package:lr_app_versioning/src/model/api_versioning.dart';
import 'package:lr_app_versioning/src/model/exceptions.dart';
import 'package:lr_app_versioning/src/service/api_versioning_service.dart';
import 'package:lr_core/lr_core.dart';

class DefaultApiVersioningService extends ApiVersioningService {
  final ApiConfig config;

  DefaultApiVersioningService(this.config): assert(config != null);

  /// Get api versioning. Throws [FailedToGetApiVersioning].
  @override
  Future<ApiVersioning> getApiVersioning() async {
    // Setup API Client
    final client = ApiClient(
      contentType: 'application/json',
    );
    // Send request
    try {
      final response = await client.get(
        config.endpoints.apiVersioningEndpoint,
        headers: {'Accept': 'application/json'},
      );
      // Parse response
      final json = jsonDecode(response.body.replaceAll("0.0.0", "2.0.0"));
      final apiVersioning = ApiVersioning.fromJson(json);
      // Return api versioning
      return apiVersioning;
    } on ClientApiClientException catch (e) {
      throw FailedToGetApiVersioning(error: e.body);
    } on ServerApiClientException catch (e) {
      throw FailedToGetApiVersioning(error: e.body);
    } on UnknownApiClientException {
      throw FailedToGetApiVersioning(error: null);
    } finally {
      client.close();
    }
  }
}
