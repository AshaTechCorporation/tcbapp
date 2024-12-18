import 'package:json_annotation/json_annotation.dart';

part 'patientHistory.g.dart';

@JsonSerializable()
class PatientHistory {
  String? full_name;
  String? sex_name;
  String? cid;
  String? telephone_1;
  String? telephone_2;
  String? hospitals;

  PatientHistory(
    this.full_name,
    this.sex_name,
    this.cid,
    this.telephone_1,
    this.telephone_2,
    this.hospitals,
  );

  factory PatientHistory.fromJson(Map<String, dynamic> json) => _$PatientHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$PatientHistoryToJson(this);
}
