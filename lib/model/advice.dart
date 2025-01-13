import 'package:json_annotation/json_annotation.dart';

part 'advice.g.dart';

@JsonSerializable()
class Advice {
  int? id;
  int? patient_id;
  String? icd10_code;
  String? description;
  String? created_at;
  String? updated_at;
  int? created_by;
  int? updated_by;

  Advice(
    this.id,
    this.patient_id,
    this.icd10_code,
    this.description,
    this.created_at,
    this.updated_at,
    this.created_by,
    this.updated_by,
  );

  factory Advice.fromJson(Map<String, dynamic> json) => _$AdviceFromJson(json);
  Map<String, dynamic> toJson() => _$AdviceToJson(this);
}
