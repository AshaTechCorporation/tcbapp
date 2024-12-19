import 'package:json_annotation/json_annotation.dart';

part 'visitedHospitals.g.dart';

@JsonSerializable()
class VisitedHospitals {
  String? hospital_name;
  String? hospital_code;

  VisitedHospitals(this.hospital_name, this.hospital_code);

  factory VisitedHospitals.fromJson(Map<String, dynamic> json) => _$VisitedHospitalsFromJson(json);
  Map<String, dynamic> toJson() => _$VisitedHospitalsToJson(this);
}
