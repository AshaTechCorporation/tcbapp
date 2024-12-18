import 'package:flutter/material.dart';
import 'package:tcbapp/model/medicalHistory.dart';
import 'package:tcbapp/model/patientHistory.dart';
import 'package:tcbapp/service/ProjectService.dart';

class ProjectController extends ChangeNotifier {
  ProjectController({this.projcetController = const ProjectService()});
  ProjectService projcetController;

  List<MedicalHistory>? medicalHistorys = [];
  MedicalHistory? medicalHistor;

  PatientHistory? patientHistory;

  List<MedicalHistory>? treatmentHistorys = [];
  MedicalHistory? treatmentHistory;

  getMedicalHistorys() async {
    medicalHistorys?.clear();
    medicalHistorys = await ProjectService.getlistMedicalHistory();

    notifyListeners();
  }

  getPatientHistory() async {
    patientHistory = null;
    patientHistory = await ProjectService.getPatientHistory();

    notifyListeners();
  }

  getlisTreatmenthistory() async {
    treatmentHistorys?.clear();
    treatmentHistorys = await ProjectService.getlisTreatmenthistory();

    notifyListeners();
  }
}
