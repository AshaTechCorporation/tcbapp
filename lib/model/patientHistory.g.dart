// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientHistory _$PatientHistoryFromJson(Map<String, dynamic> json) =>
    PatientHistory(
      json['full_name'] as String?,
      json['sex_name'] as String?,
      json['cid'] as String?,
      json['telephone_1'] as String?,
      json['telephone_2'] as String?,
      json['hospitals'] as String?,
    );

Map<String, dynamic> _$PatientHistoryToJson(PatientHistory instance) =>
    <String, dynamic>{
      'full_name': instance.full_name,
      'sex_name': instance.sex_name,
      'cid': instance.cid,
      'telephone_1': instance.telephone_1,
      'telephone_2': instance.telephone_2,
      'hospitals': instance.hospitals,
    };
