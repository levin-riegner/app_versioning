import 'dart:convert';

import 'package:lr_app_versioning/app_versioning.dart';
import 'package:lr_app_versioning/src/api/model/api_versioning.dart';
import 'package:lr_core/lr_core.dart';

class DefaultApiVersioningService extends MinimumVersioningService {
  final ApiConfig config;

  DefaultApiVersioningService(this.config);

  /// Get api versioning. Throws [FailedToGetMinimumVersioning].
  @override
  Future<MinimumVersions> getMinimumVersions() async {
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
      final minimumVersioning = ApiVersioning.fromJson(json);
      // Return api versioning
      return MinimumVersions(
        ios: minimumVersioning.minimumIosVersion,
        android: minimumVersioning.minimumAndroidVersion,
      );
    } on ClientApiClientException catch (e) {
      throw FailedToGetMinimumVersions(error: e.body);
    } on ServerApiClientException catch (e) {
      throw FailedToGetMinimumVersions(error: e.body);
    } on UnknownApiClientException {
      throw FailedToGetMinimumVersions(error: null);
    } finally {
      client.close();
    }
  }
}
