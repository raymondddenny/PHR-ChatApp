part of 'pages.dart';

class PatientListMedicalRecordPage extends StatefulWidget {
  final User user;

  PatientListMedicalRecordPage({@required this.user});
  @override
  _PatientListMedicalRecordPageState createState() =>
      _PatientListMedicalRecordPageState();
}

class _PatientListMedicalRecordPageState
    extends State<PatientListMedicalRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Patient List Medical Record"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: HistoryPatientServices.getPatientDataTest(
              doctorId: widget.user.id,
            ),
            builder: (_, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
              if (dataSnapshot.hasData) {
                var doc = dataSnapshot.data.documents;
                return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PatientMedRecordView(
                                  doc: doc[index].documentID,
                                  currentUser: widget.user,
                                  patientName: doc[index].data['patientName'],
                                );
                              },
                            ));
                          },
                          child: Container(
                            height: 50,
                            child: Card(
                              child: Center(
                                  child: Text(
                                doc[index].data['patientName'],
                                style: blackTextFont.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                            ),
                          ),
                        ));
                  },
                );
              } else {
                return SpinKitFadingCircle(color: accentColor2, size: 100);
              }
            }),
      ),
    );
  }
}

class PatientMedRecordView extends StatefulWidget {
  final doc;
  final patientName;
  final User currentUser;
  PatientMedRecordView({this.doc, this.currentUser, this.patientName});
  @override
  _PatientMedRecordViewState createState() => _PatientMedRecordViewState();
}

class _PatientMedRecordViewState extends State<PatientMedRecordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Medical Record View"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    widget.patientName,
                    style: blackTextFont.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: HistoryPatientServices.getPatientData(
                    doctorId: widget.currentUser.id,
                    patientContactId: widget.doc),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var doc = snapshot.data.documents;
                    return ListView.builder(
                      itemCount: doc.length,
                      itemBuilder: (context, index) {
                        DateTime date =
                            doc[index].data['timeAddedConsultation'].toDate();
                        String formatDate =
                            DateFormat.yMMMMEEEEd().add_jms().format(date);
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  String documentIdIndex =
                                      doc[index].documentID;
                                  return PatientMedRecordDetailPage(
                                    doc: widget.doc,
                                    user: widget.currentUser,
                                    documentId: documentIdIndex,
                                  );
                                },
                              ));
                            },
                            child: Container(
                              height: 80,
                              child: Card(
                                elevation: 5,
                                child: Center(
                                  child: Wrap(
                                    children: [
                                      Text(
                                        formatDate,
                                        style: blackTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    );
                  } else {
                    return SpinKitFadingCircle(color: accentColor2, size: 100);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientMedRecordDetailPage extends StatefulWidget {
  final doc;
  final String documentId;
  final User user;
  PatientMedRecordDetailPage({this.doc, this.user, this.documentId});
  @override
  _PatientMedRecordDetailPageState createState() =>
      _PatientMedRecordDetailPageState();
}

class _PatientMedRecordDetailPageState
    extends State<PatientMedRecordDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Medical Record Detail"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: HistoryPatientServices.getPatientData(
            doctorId: widget.user.id, patientContactId: widget.doc),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var doc = snapshot.data.documents;
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                PatientMedRecord patientMedRecord =
                    PatientMedRecord.fromMap(doc[index].data);
                return Column(
                  children: [
                    MedicalRecordCard(
                      patientMedRecordDataName: patientMedRecord.doctorName,
                      title: "Doctor Name",
                    ),
                    MedicalRecordCard(
                        patientMedRecordDataName: patientMedRecord.patientName,
                        title: "Patient Name"),
                    MedicalRecordCard(
                      patientMedRecordDataName: patientMedRecord.patientAge,
                      title: "Patient Age",
                    ),
                    MedicalRecordCard(
                        patientMedRecordDataName:
                            patientMedRecord.patientStatus,
                        title: "Patient Status"),
                    MedicalRecordCard(
                        patientMedRecordDataName:
                            patientMedRecord.patientDiagnose,
                        title: "Patient Diagnose"),
                  ],
                );
              },
            );
          } else {
            return SpinKitFadingCircle(color: accentColor2, size: 100);
          }
        },
      ),
    );
  }
}

class MedicalRecordCard extends StatelessWidget {
  const MedicalRecordCard({
    Key key,
    @required this.patientMedRecordDataName,
    @required this.title,
  }) : super(key: key);

  final String patientMedRecordDataName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title : ",
                style: blackTextFont.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            (patientMedRecordDataName == "")
                ? Text(
                    "No data",
                    style: blackTextFont.copyWith(
                      fontSize: 16,
                    ),
                  )
                : Text(
                    patientMedRecordDataName,
                    style: blackTextFont.copyWith(
                      fontSize: 16,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

// class MedicalRecordCardTile extends StatelessWidget {
//   const MedicalRecordCardTile({
//     Key key,
//     @required this.patientMedRecordDataName,
//   }) : super(key: key);

//   final String patientMedRecordDataName;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Card(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Doctor Name : ",
//               style: blackTextFont.copyWith(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               )),
//           Text(
//             patientMedRecord,
//             style: blackTextFont.copyWith(
//               fontSize: 16,
//             ),
//           ),
//         ],
//       )),
//     );
//   }
// }
