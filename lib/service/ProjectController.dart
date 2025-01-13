import 'package:flutter/material.dart';
import 'package:tcbapp/model/advice.dart';
import 'package:tcbapp/model/appointment.dart';
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

  List<Advice>? advicdes = [];
  Advice? advice;

  List<Appointment> appointments = [];

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

  getadvice(String cid) async {
    advicdes?.clear();
    advicdes = await ProjectService.getlisAdvice(cid: cid);

    notifyListeners();
  }

  getadvicebyid(int id) async {
    advice = null;
    advice = await ProjectService.getadvicebyid(id: id);

    notifyListeners();
  }

  getAppointment(String cid) async {
    appointments.clear();
    appointments = await ProjectService.getAppointment(cid: cid);

    notifyListeners();
  }
}
