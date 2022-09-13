class ApiVersioningEndpoints {
  final String _baseUrl;
  final String _minimumVersioningEndpoint;

  /// Default endpoints can be overridden by passing custom endpoints
  ApiVersioningEndpoints(
    this._baseUrl, {
    String minimumVersioningEndpoint = "api/api-compatibility",
  }) : _minimumVersioningEndpoint = minimumVersioningEndpoint;

  String get minimumVersioningEndpoint =>
      "$_baseUrl/$_minimumVersioningEndpoint";

  @override
  String toString() {
    return 'ApiVersioningEndpoints{minimumVersioningEndpoint: $_minimumVersioningEndpoint}';
  }
}
