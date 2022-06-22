import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:app_versioning/app_versioning.dart';
import 'package:app_versioning/src/api/model/api_versioning.dart';

class DefaultApiVersioningService extends MinimumVersioningService {
  final ApiConfig config;

  DefaultApiVersioningService(this.config);

  /// Get api versioning. Throws [FailedToGetMinimumVersioning].
  @override
  Future<MinimumVersions> getMinimumVersions() async {
    // Setup API Client
    final client = Client();
    // Send request
    try {
      final response = await client.get(
        Uri.parse(config.endpoints.minimumVersioningEndpoint),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      // Parse response
      final json = jsonDecode(response.body);
      final minimumVersioning = ApiVersioning.fromJson(json);
      // Return api versioning
      return MinimumVersions(
        ios: minimumVersioning.minimumIosVersion,
        android: minimumVersioning.minimumAndroidVersion,
      );
    } catch (e) {
      throw FailedToGetMinimumVersions(error: e.toString());
    } finally {
      client.close();
    }
  }
}
