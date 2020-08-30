part of 'services.dart';

class HistoryPatientServices {
  static CollectionReference _historyPatientCollection =
      Firestore.instance.collection('historyPatient');

  static Future<void> addHistoryToDb({HistoryPatient historyPatient}) async {
    await _historyPatientCollection
        .document(historyPatient.doctorId)
        .collection(historyPatient.patientId)
        .add({
      'patientId': historyPatient.patientId,
      'patientName': historyPatient.patientName,
      'patientAge': historyPatient.patientAge ?? "",
      'patientDiagnose': historyPatient.patientDiagnose ?? "",
      'patientStatus': historyPatient.patientStatus ?? "",
      'doctorId': historyPatient.doctorId,
      'doctorName': historyPatient.doctorName,
      'timeAddedConsultation': historyPatient.timestamp ?? Timestamp.now(),
    });
  }
}
