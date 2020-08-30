part of 'pages.dart';

class HistoryPatientPage extends StatefulWidget {
  final Call call;
  HistoryPatientPage({this.call});
  @override
  _HistoryPatientPageState createState() => _HistoryPatientPageState();
}

class _HistoryPatientPageState extends State<HistoryPatientPage> {
  TextEditingController patientNameController = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController symptomController = TextEditingController();
  TextEditingController currentCondition = TextEditingController();
  String patientStatus = "";

  Timestamp dateTime;
  String formattedDate = "";

  @override
  void initState() {
    super.initState();
    patientNameController =
        TextEditingController(text: widget.call.receiverName);
    doctorNameController = TextEditingController(text: widget.call.callerName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("History Patient Page"),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Please filled up the patient ${widget.call.receiverName} history",
                    style: blackTextFont.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  TextField(
                    controller: patientNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Nama Pasien"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: doctorNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Nama Dokter"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Umur Pasien"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: symptomController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Diagnosa Pasien"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Column(
                      children: [
                        Text("Patient Status"),
                        RadioListTile(
                            title: Text("Berobat Jalan"),
                            value: "Berobat Jalan",
                            groupValue: patientStatus,
                            onChanged: (value) {
                              setState(() {
                                patientStatus = value;
                              });
                            }),
                        RadioListTile(
                            title: Text("Rujuk Internal"),
                            value: "Rujuk Internal",
                            groupValue: patientStatus,
                            onChanged: (value) {
                              setState(() {
                                patientStatus = value;
                              });
                            }),
                        RadioListTile(
                            title: Text("Rujuk Lanjut"),
                            value: "Rujuk Lanjut",
                            groupValue: patientStatus,
                            onChanged: (value) {
                              setState(() {
                                patientStatus = value;
                              });
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: TextEditingController(text: formattedDate),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Tanggal Konsultasi",
                      suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState(() {
                                formattedDate =
                                    DateFormat('dd-MM-yyyy').format(date);
                                dateTime = Timestamp.fromMillisecondsSinceEpoch(
                                    date.millisecondsSinceEpoch);
                              });
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 85,
                    width: 250,
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Submit Patient ${widget.call.receiverName} History",
                        style: whiteTextFont.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      disabledColor: accentColor3,
                      color: mainColor,
                      onPressed: () {
                        var namaPasien = patientNameController.text;
                        var umurPasien = ageController.text;
                        var diagnosaPasien = symptomController.text;

                        HistoryPatient historyPatient = HistoryPatient(
                          patientId: widget.call.receiverId,
                          doctorId: widget.call.callerId,
                          patientAge: umurPasien,
                          doctorName: widget.call.callerName,
                          patientDiagnose: diagnosaPasien,
                          patientStatus: patientStatus,
                          patientName: namaPasien,
                          timestamp: Timestamp.now(),
                        );

                        HistoryPatientServices.addHistoryToDb(
                          historyPatient: historyPatient,
                        );

                        context
                            .bloc<PageBloc>()
                            .add(GoToMainPage(bottomNavBarIndex: 0));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
