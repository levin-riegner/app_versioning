import 'package:lr_core/lr_core.dart';

class ApiVersioningEndpoints extends ApiEndpoints {
  final String _minimumVersioningEndpoint;

  /// Default endpoints can be overridden by passing custom endpoints
  ApiVersioningEndpoints(
    String baseUrl, {
    String minimumVersioningEndpoint = "api/api-compatibility",
  })  : _minimumVersioningEndpoint = minimumVersioningEndpoint,
        super(baseUrl);

  String get minimumVersioningEndpoint =>
      url(endpoint: _minimumVersioningEndpoint);

  @override
  String toString() {
    return 'ApiVersioningEndpoints{minimumVersioningEndpoint: $_minimumVersioningEndpoint}';
  }
}
