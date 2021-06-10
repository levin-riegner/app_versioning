import 'package:lr_app_versioning/src/service/optional_update_service.dart';
import 'package:lr_app_versioning/src/util/version.dart';

class MockOptionalUpdateService implements OptionalUpdateService {
  final bool updateAvailable;

  const MockOptionalUpdateService({
    required this.updateAvailable,
  });

  @override
  Future<bool> isOptionalUpdateAvailable(Version currentVersion) async {
    return updateAvailable;
  }
}
