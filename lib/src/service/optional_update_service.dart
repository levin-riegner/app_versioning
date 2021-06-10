import 'package:lr_app_versioning/src/util/version.dart';

abstract class OptionalUpdateService {
  Future<bool> isOptionalUpdateAvailable(Version currentVersion);
}
