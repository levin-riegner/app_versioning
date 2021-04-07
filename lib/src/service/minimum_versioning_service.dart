import 'package:lr_app_versioning/src/api/model/minimum_versioning.dart';

abstract class MinimumVersioningService {
  Future<MinimumVersioning> getMinimumVersioning();
}