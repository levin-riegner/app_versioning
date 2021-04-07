import 'dart:convert';

import 'package:lr_app_versioning/src/api/config/api_config.dart';
import 'package:lr_app_versioning/src/api/model/exceptions.dart';
import 'package:lr_app_versioning/src/api/model/minimum_versioning.dart';
import 'package:lr_app_versioning/src/service/minimum_versioning_service.dart';
import 'package:lr_core/lr_core.dart';

class DefaultApiVersioningService extends MinimumVersioningService {
  final ApiConfig config;

  DefaultApiVersioningService(this.config);

  /// Get api versioning. Throws [FailedToGetMinimumVersioning].
  @override
  Future<MinimumVersioning> getMinimumVersioning() async {
    // Setup API Client
    final client = ApiClient(
      contentType: 'application/json',
    );
    // Send request
    try {
      final response = await client.get(
        Uri.parse(config.endpoints.minimumVersioningEndpoint),
        headers: {'Accept': 'application/json'},
      );
      // Parse response
      final json = jsonDecode(response.body);
      final minimumVersioning = MinimumVersioning.fromJson(json);
      // Return api versioning
      return minimumVersioning;
    } on ClientApiClientException catch (e) {
      throw FailedToGetMinimumVersioning(error: e.body);
    } on ServerApiClientException catch (e) {
      throw FailedToGetMinimumVersioning(error: e.body);
    } on UnknownApiClientException {
      throw FailedToGetMinimumVersioning(error: null);
    } finally {
      client.close();
    }
  }
}
