import 'package:json_annotation/json_annotation.dart';
import 'package:lr_app_versioning/src/util/version.dart';

part 'api_versioning.g.dart';

@JsonSerializable()
class ApiVersioning {

  @JsonKey(name: 'minimumIosVersion')
  final String minimumIosVersionString;
  @JsonKey(name: 'minimumAndroidVersion')
  final String minimumAndroidVersionString;

  const ApiVersioning({this.minimumIosVersionString, this.minimumAndroidVersionString});

  Version get minimumIosVersion => Version.tryParse(minimumIosVersionString);
  Version get minimumAndroidVersion => Version.tryParse(minimumAndroidVersionString);

  factory ApiVersioning.fromJson(Map<String, dynamic> json) => _$ApiVersioningFromJson(json);
  Map<String, dynamic> toJson() => _$ApiVersioningToJson(this);



}