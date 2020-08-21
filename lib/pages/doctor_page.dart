part of 'pages.dart';

class DoctorPage extends StatefulWidget {
  final DoctorType doctorType;
  DoctorPage(this.doctorType);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  List<String> doctor = [
    "Dokter Umum",
    "Dokter Mata",
    "Dokter Anak",
    "Dokter THT"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PickupLayout(
        scaffold: Scaffold(
          body: ListView(
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
                // get user data from firebase using BlocUser
                child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                  if (userState is UserLoaded) {
                    // // jika ada file profile gambar yang mau di upload dari page registrasi
                    // if (imageFileToUpload != null) {
                    //   uploadImage(imageFileToUpload).then((downloadUrl) {
                    //     imageFileToUpload = null;
                    //     context
                    //         .bloc<UserBloc>()
                    //         .add(UpdateUserData(profileImage: downloadUrl));
                    //   });
                    // }

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToUserProfilePage());
                            // context.bloc<PageBloc>().add(GoDoctorSelectedPage());
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: accentColor3, width: 1),
                            ),
                            child: Stack(
                              children: [
                                SpinKitFadingCircle(
                                  color: accentColor2,
                                  size: 50,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: (userState.user.profileImage ==
                                                "no_pic"
                                            ? AssetImage(
                                                "images/user_default.png")
                                            : NetworkImage(
                                                userState.user.profileImage)),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  78,
                              child: Text(
                                userState.user.fullName,
                                style: blackTextFont.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(userState.user.job),
                          ],
                        )
                      ],
                    );
                  } else {
                    return SpinKitFadingCircle(
                      color: accentColor2,
                      size: 50,
                    );
                  }
                }),
              ),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.doctorType.speciality = doctor[0];
                        context
                            .bloc<PageBloc>()
                            .add(GoToDoctorSelectedPage(widget.doctorType));
                      },
                      child: DoctorCard(
                        doctorType: doctor[0],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.doctorType.speciality = doctor[1];
                        context
                            .bloc<PageBloc>()
                            .add(GoToDoctorSelectedPage(widget.doctorType));
                      },
                      child: DoctorCard(
                        doctorType: doctor[1],
                        // onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.doctorType.speciality = doctor[2];
                        context
                            .bloc<PageBloc>()
                            .add(GoToDoctorSelectedPage(widget.doctorType));
                      },
                      child: DoctorCard(
                        doctorType: doctor[2],
                        // onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.doctorType.speciality = doctor[3];
                        context
                            .bloc<PageBloc>()
                            .add(GoToDoctorSelectedPage(widget.doctorType));
                      },
                      child: DoctorCard(
                        doctorType: doctor[3],
                        // onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "Top Rated Doctors",
                      style: blackTextFont.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                    // TODO : Tambah Top Rate Doctor
                    TopRateDoctorListTile(),
                    TopRateDoctorListTile(),
                    TopRateDoctorListTile(),
                    TopRateDoctorListTile(),
                    SizedBox(height: 20),
                    Text(
                      "Good News",
                      style: blackTextFont.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                    GoodNewsListTile(),
                    GoodNewsListTile(),
                    GoodNewsListTile(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoodNewsListTile extends StatelessWidget {
  const GoodNewsListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      title: Text("Is it safe to stay at home during corona virus ?"),
      subtitle: Text("Today"),
      trailing: Container(
        height: 150,
        width: 50,
        child: Image.network(
          "http://www.pngmart.com/files/12/Coronavirus-Stay-Home-PNG-Clipart.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TopRateDoctorListTile extends StatelessWidget {
  const TopRateDoctorListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      leading: Image.asset("images/doctor.png"),
      title: Text("Alexa Rachel"),
      subtitle: Text("Pediatrician"),
      trailing: RatingBar(
        initialRating: 5,
        direction: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemSize: 28,
        onRatingUpdate: null,
      ),
    );
  }
}
