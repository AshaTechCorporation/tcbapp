// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicalHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalHistory _$MedicalHistoryFromJson(Map<String, dynamic> json) =>
    MedicalHistory(
      json['hospital_name'] as String?,
      json['diagnosis_date'] as String?,
      json['icd10_text'] as String?,
      json['hospital_code'] as String?,
      json['last_entrance_date'] as String?,
      (json['treatments'] as List<dynamic>?)
          ?.map((e) => Treatments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MedicalHistoryToJson(MedicalHistory instance) =>
    <String, dynamic>{
      'hospital_name': instance.hospital_name,
      'diagnosis_date': instance.diagnosis_date,
      'icd10_text': instance.icd10_text,
      'hospital_code': instance.hospital_code,
      'last_entrance_date': instance.last_entrance_date,
      'treatments': instance.treatments,
    };
