import 'package:app_versioning/src/model/minimum_versions.dart';

abstract class MinimumVersioningService {
  Future<MinimumVersions> getMinimumVersions();
}
