class UpdateConfig {
  final String? appStoreAppId;
  final String? playStoreAppId;
  final String appstoreCountryCode;

  const UpdateConfig({this.appStoreAppId, this.playStoreAppId, this.appstoreCountryCode = 'US'});

  @override
  String toString() {
    return 'UpdateConfig{appStoreAppId: $appStoreAppId, playStoreAppId: $playStoreAppId, appstoreCountryCode: $appstoreCountryCode}';
  }
}
