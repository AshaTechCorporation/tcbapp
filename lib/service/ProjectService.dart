import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/model/medicalHistory.dart';
import 'package:http/http.dart' as http;
import 'package:tcbapp/model/patientHistory.dart';
import 'package:tcbapp/model/visitedHospitals.dart';
import 'dart:convert' as convert;

import 'package:tcbapp/utils/apiException.dart';

class ProjectService {
  const ProjectService();

  static Future<List<MedicalHistory>> getlistMedicalHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(publicUrl, '/api/app/cancer', {'cid': '1-0000-01986-99-9'});
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      final list = data["data"] as List;
      return list.map((e) => MedicalHistory.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<PatientHistory> getPatientHistory({String? id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(publicUrl, '/api/app/partient', {'cid': '1000000005999'});
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return PatientHistory.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<List<VisitedHospitals>> getlisTreatmenthistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(publicUrl, '/api/app/hospital', {'cid': '1000000005999', 'hospital': '12250'});
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      final list = data["data"] as List;
      return list.map((e) => VisitedHospitals.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }
}
