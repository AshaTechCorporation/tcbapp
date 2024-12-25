import 'package:flutter/material.dart';
import 'package:tcbapp/model/medicalHistory.dart';
import 'package:tcbapp/model/patientHistory.dart';
import 'package:tcbapp/model/visitedHospitals.dart';
import 'package:tcbapp/service/ProjectService.dart';

class ProjectController extends ChangeNotifier {
  ProjectController({this.projcetController = const ProjectService()});
  ProjectService projcetController;

  List<MedicalHistory>? medicalHistorys = [];
  MedicalHistory? medicalHistor;

  PatientHistory? patientHistory;

  List<VisitedHospitals>? treatmentHistorys = [];
  VisitedHospitals? treatmentHistory;

  getMedicalHistorys(String cid) async {
    medicalHistorys?.clear();
    medicalHistorys = await ProjectService.getlistMedicalHistory(cid: cid);

    notifyListeners();
  }

  getPatientHistory(String cid) async {
    patientHistory = null;
    patientHistory = await ProjectService.getPatientHistory(cid: cid);

    notifyListeners();
  }

  getlisTreatmenthistory(String cid) async {
    treatmentHistorys?.clear();
    treatmentHistorys = await ProjectService.getlisTreatmenthistory(cid: cid);

    notifyListeners();
  }
}
