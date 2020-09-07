import 'package:lr_core/lr_core.dart';

class ApiVersioningEndpoints extends ApiEndpoints {
  final String _apiVersioningEndpoint;

  /// Default endpoints can be overridden by passing custom endpoints
  ApiVersioningEndpoints(
    String baseUrl, {
    String apiVersioningEndpoint,
  })  : _apiVersioningEndpoint = apiVersioningEndpoint,
        super(baseUrl);

  String get apiVersioningEndpoint => url(endpoint: _apiVersioningEndpoint ?? 'api/api-compatibility');
}
