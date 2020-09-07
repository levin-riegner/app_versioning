// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_versioning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiVersioning _$ApiVersioningFromJson(Map<String, dynamic> json) {
  return ApiVersioning(
    minimumIosVersion: json['minimumIosVersion'] as String,
    minimumAndroidVersion: json['minimumAndroidVersion'] as String,
  );
}

Map<String, dynamic> _$ApiVersioningToJson(ApiVersioning instance) =>
    <String, dynamic>{
      'minimumIosVersion': instance.minimumIosVersion,
      'minimumAndroidVersion': instance.minimumAndroidVersion,
    };
