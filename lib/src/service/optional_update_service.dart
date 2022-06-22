import 'package:app_versioning/src/util/version.dart';

abstract class OptionalUpdateService {
  Future<bool> isOptionalUpdateAvailable(Version currentVersion);
}
