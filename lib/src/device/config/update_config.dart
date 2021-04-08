class UpdateConfig {
  final String? appStoreAppId;
  final String? playStoreAppId;

  const UpdateConfig({this.appStoreAppId, this.playStoreAppId});

  @override
  String toString() {
    return 'UpdateConfig{appStoreAppId: $appStoreAppId, playStoreAppId: $playStoreAppId}';
  }
}
