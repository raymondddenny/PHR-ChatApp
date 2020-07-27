part of 'pages.dart';

class DoctorSelectedPageList extends StatefulWidget {
  final DoctorType doctorType;

  DoctorSelectedPageList(this.doctorType);

  @override
  _DoctorSelectedPageListState createState() => _DoctorSelectedPageListState();
}

class _DoctorSelectedPageListState extends State<DoctorSelectedPageList> {
  @override
  Widget build(BuildContext context) {
    // set Theme
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.bloc<PageBloc>().add(GoToMainPage());
              }),
          title: Text("Pilih ${widget.doctorType.speciality}"),
          centerTitle: true,
        ),
        body: ChatListPage(widget.doctorType.speciality),
      ),
    );
  }
}
