part of 'services.dart';

class HistoryPatientServices {
  // call reference document
  static CollectionReference _historyPatientCollection =
      Firestore.instance.collection('historyPatient');

  static CollectionReference _historyDoctorPatientCollection =
      Firestore.instance.collection('historyDoctorPatient');

  // to save patient medical record
  static Future<void> addHistoryToDb({HistoryPatient historyPatient}) async {
    await _historyPatientCollection
        .document(historyPatient.patientId)
        .collection(historyPatient.doctorId)
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

  // to save patient medical record list for doctor access
  static Future<void> addHistoryPatientDoctorToDb(
      {HistoryPatient historyPatient}) async {
    // String historyPatientName = historyPatient.patientName;
    await _historyDoctorPatientCollection
        .document("doctors")
        .collection(historyPatient.doctorId)
        .document(historyPatient.patientId)
        .collection("medrecord")
        .document()
        .setData({
      'patientId': historyPatient.patientId,
      'patientName': historyPatient.patientName,
      'patientAge': historyPatient.patientAge ?? "",
      'patientDiagnose': historyPatient.patientDiagnose ?? "",
      'patientStatus': historyPatient.patientStatus ?? "",
      'doctorId': historyPatient.doctorId,
      'doctorName': historyPatient.doctorName,
      'timeAddedConsultation': historyPatient.timestamp ?? Timestamp.now(),
    });

    await _historyDoctorPatientCollection
        .document("doctors")
        .collection(historyPatient.doctorId)
        .document(historyPatient.patientId)
        .setData({
      'patientName': historyPatient.patientName,
    });
  }

  static Stream<QuerySnapshot> getPatientDataTest(
      {String doctorId, String patientContactId}) {
    return _historyDoctorPatientCollection
        .document("doctors")
        .collection(doctorId)
        .snapshots();
  }

  static Stream<QuerySnapshot> getPatientData(
      {String doctorId, String patientContactId}) {
    return _historyDoctorPatientCollection
        .document("doctors")
        .collection(doctorId)
        .document(patientContactId)
        .collection("medrecord")
        .snapshots();
  }
  // static Future<List<PatientMedRecord>> getAllMedRecord(
  //     String doctorId, String patientId) async {
  //   List<PatientMedRecord> userList = List<PatientMedRecord>();
  //   QuerySnapshot querySnapshot = await _historyDoctorPatientCollection
  //       .document(doctorId)
  //       .collection(patientId)
  //       .getDocuments();
  //   for (var i = 0; i < querySnapshot.documents.length; i++) {
  //     userList.add(PatientMedRecord.fromMap(querySnapshot.documents[i].data));
  //   }
  //   return userList;
  // }
}
