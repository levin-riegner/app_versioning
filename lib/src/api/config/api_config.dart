import 'api_versioning_endpoints.dart';

class ApiConfig {
  final ApiVersioningEndpoints endpoints;

  const ApiConfig({required this.endpoints});

  @override
  String toString() {
    return 'ApiConfig{endpoints: $endpoints}';
  }
}
