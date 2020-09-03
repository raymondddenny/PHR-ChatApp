part of 'models.dart';

class HistoryPatient extends Equatable {
  final String patientId;
  final String doctorId;
  final String patientName;
  final String doctorName;
  final String patientAge;
  final String patientDiagnose;
  final String patientStatus;
  final Timestamp timestamp;

  HistoryPatient({
    this.patientId,
    this.doctorId,
    this.patientName,
    this.doctorName,
    this.patientAge,
    this.patientDiagnose,
    this.patientStatus,
    this.timestamp,
  });

  HistoryPatient toMap() => HistoryPatient(
        patientId: patientId ?? this.patientId,
        doctorId: doctorId ?? this.doctorId,
        patientName: patientName ?? this.patientName,
        doctorName: doctorName ?? this.doctorName,
        patientAge: patientAge ?? this.patientAge,
        patientDiagnose: patientDiagnose ?? this.patientDiagnose,
        patientStatus: patientStatus ?? this.patientStatus,
        timestamp: timestamp ?? this.timestamp,
      );

  factory HistoryPatient.fromMap(Map<String, dynamic> mapData) {
    return HistoryPatient(
      patientId: mapData['patientId'],
      doctorId: mapData['doctorId'],
      patientName: mapData['patientName'],
      doctorName: mapData['doctorName'],
      patientAge: mapData['patientAge'],
      patientDiagnose: mapData['patientDiagnose'],
      patientStatus: mapData['patientStatus'],
      timestamp: mapData['timestamp'],
    );
  }

  @override
  List<Object> get props => [
        patientId,
        doctorId,
        patientName,
        patientAge,
        doctorName,
        patientDiagnose,
        patientStatus,
        timestamp
      ];
}
