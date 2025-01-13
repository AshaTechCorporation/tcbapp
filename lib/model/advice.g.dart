// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advice _$AdviceFromJson(Map<String, dynamic> json) => Advice(
      (json['id'] as num?)?.toInt(),
      (json['patient_id'] as num?)?.toInt(),
      json['icd10_code'] as String?,
      json['description'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      (json['created_by'] as num?)?.toInt(),
      (json['updated_by'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdviceToJson(Advice instance) => <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patient_id,
      'icd10_code': instance.icd10_code,
      'description': instance.description,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'created_by': instance.created_by,
      'updated_by': instance.updated_by,
    };
