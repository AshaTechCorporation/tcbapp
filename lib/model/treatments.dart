import 'package:json_annotation/json_annotation.dart';

part 'treatments.g.dart';

@JsonSerializable()
class Treatments {
  int? id;
  String? icd10_code;
  String? treatment_code;
  String? treatment_date;

  Treatments(this.id, this.icd10_code, this.treatment_code, this.treatment_date);

  factory Treatments.fromJson(Map<String, dynamic> json) => _$TreatmentsFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentsToJson(this);
}
