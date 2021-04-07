class RemoteConfigKeys {
  final String minimumIosVersionKey;
  final String minimumAndroidVersionKey;

  const RemoteConfigKeys({
    this.minimumIosVersionKey = "minimumIosVersion",
    this.minimumAndroidVersionKey = "minimumAndroidVersion",
  });

  @override
  String toString() {
    return 'RemoteConfigKeys{minimumIosVersionKey: $minimumIosVersionKey, minimumAndroidVersionKey: $minimumAndroidVersionKey}';
  }
}
