import 'package:lr_core/lr_core.dart';

class ApiVersioningEndpoints extends ApiEndpoints {
  // Example: "api/api-compatibility"
  final String _minimumVersioningEndpoint;

  /// Default endpoints can be overridden by passing custom endpoints
  ApiVersioningEndpoints(
    String baseUrl, {
    required String minimumVersioningEndpoint,
  })   : _minimumVersioningEndpoint = minimumVersioningEndpoint,
        super(baseUrl);

  String get minimumVersioningEndpoint =>
      url(endpoint: _minimumVersioningEndpoint);

  @override
  String toString() {
    return 'ApiVersioningEndpoints{minimumVersioningEndpoint: $_minimumVersioningEndpoint}';
  }
}
