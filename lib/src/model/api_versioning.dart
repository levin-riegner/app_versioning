import 'package:json_annotation/json_annotation.dart';

part 'api_versioning.g.dart';

@JsonSerializable()
class ApiVersioning {

  final String minimumIosVersion;
  final String minimumAndroidVersion;

  const ApiVersioning({this.minimumIosVersion, this.minimumAndroidVersion});


  factory ApiVersioning.fromJson(Map<String, dynamic> json) => _$ApiVersioningFromJson(json);
  Map<String, dynamic> toJson() => _$ApiVersioningToJson(this);

}