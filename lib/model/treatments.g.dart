// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Treatments _$TreatmentsFromJson(Map<String, dynamic> json) => Treatments(
      (json['id'] as num?)?.toInt(),
      json['icd10_code'] as String?,
      json['treatment_code'] as String?,
      json['treatment_date'] as String?,
    );

Map<String, dynamic> _$TreatmentsToJson(Treatments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icd10_code': instance.icd10_code,
      'treatment_code': instance.treatment_code,
      'treatment_date': instance.treatment_date,
    };
