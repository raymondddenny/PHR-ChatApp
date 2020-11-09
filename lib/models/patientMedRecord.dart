part of 'models.dart';

class PatientMedRecord extends Equatable {
  final String doctorId;
  final String patientId;
  final String doctorName;
  final String patientName;
  final String patientDiagnose;
  final String patientStatus;
  final String patientAge;
  final Timestamp timestamp;

  PatientMedRecord({
    this.doctorId,
    this.patientId,
    this.doctorName,
    this.patientAge,
    this.patientDiagnose,
    this.patientName,
    this.patientStatus,
    this.timestamp,
  });

  factory PatientMedRecord.fromMap(Map<String, dynamic> mapData) {
    return PatientMedRecord(
        doctorId: mapData['doctorId'],
        doctorName: mapData['doctorName'],
        patientAge: mapData['patientAge'],
        patientDiagnose: mapData['patientDiagnose'],
        patientId: mapData['patientId'],
        patientName: mapData['patientName'],
        patientStatus: mapData['patientStatus'],
        timestamp: mapData['timeAddedConsultation']);
  }

  @override
  List<Object> get props => [
        doctorId,
        doctorName,
        patientAge,
        patientDiagnose,
        patientId,
        patientName,
        patientStatus,
        timestamp
      ];
}
