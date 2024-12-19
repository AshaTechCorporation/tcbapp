import 'package:json_annotation/json_annotation.dart';
import 'package:tcbapp/model/treatments.dart';

part 'medicalHistory.g.dart';

@JsonSerializable()
class MedicalHistory {
  String? hospital_name;
  String? diagnosis_date;
  String? icd10_text;
  String? hospital_code;
  List<Treatments>? treatments;

  MedicalHistory(
    this.hospital_name,
    this.diagnosis_date,
    this.icd10_text,
    this.hospital_code,
    this.treatments,
  );

  factory MedicalHistory.fromJson(Map<String, dynamic> json) => _$MedicalHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$MedicalHistoryToJson(this);
}
