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
                padding: EdgeInsets.all(10.0),
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
                    TopRateDoctorListTile(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

class TopRateDoctorListTile extends StatefulWidget {
  @override
  _TopRateDoctorListTileState createState() => _TopRateDoctorListTileState();
}

class _TopRateDoctorListTileState extends State<TopRateDoctorListTile> {
  List<User> userList = [];
  @override
  Widget build(BuildContext context) {
    // int counter = 0;
    String doctorStatus = "Doctor";
    return StreamBuilder(
      stream: UserServices.fetchLastRatingDoctor().asStream(),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          // userList = snapshot.data;
          for (int i = 0; i < snapshot.data.length; i++) {
            if (snapshot.data[i].status == doctorStatus &&
                snapshot.data[i].ratingNum > 3.0) {
              userList.add(snapshot.data[i]);
              // counter++;
              // print(counter);
            }
            if (userList.isNotEmpty) {
              return buildListDoctor(doctorStatus);
            } else {
              return Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "...No doctor found for a moment...",
                    style: blackTextFont.copyWith(
                        fontSize: 18, color: accentColor2),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }
          return Container();
        }
      },
    );
  }

  Widget buildListDoctor(String doctorStatus) {
    final List<User> doctorList = doctorStatus.isEmpty
        ? []
        : userList.where((User user) {
            String _doctorQuery = doctorStatus;
            String _getUserStatus = user.status;
            double _rating = user.ratingNum;
            bool matchStatus = _getUserStatus.contains(_doctorQuery);
            return (matchStatus && _rating > 3);
          }).toList();

    return Container(
      height: 100,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: doctorList.length,
              itemBuilder: (context, index) {
                User doctor = User(
                  doctorList[index].id,
                  doctorList[index].email,
                  fullName: doctorList[index].fullName,
                  job: doctorList[index].job,
                  profileImage: doctorList[index].profileImage,
                  ratingNum: doctorList[index].ratingNum,
                  alumnus: doctorList[index].alumnus,
                  noSIP: doctorList[index].noSIP,
                  state: doctorList[index].state,
                  status: doctorList[index].status,
                  tempatPraktek: doctorList[index].tempatPraktek,
                );
                return Container(
                  child: CustomChatTile(
                    mini: false,
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(doctor.profileImage),
                    ),
                    title: Text(
                      doctor.fullName,
                      style: blackTextFont.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      doctor.job,
                      style: greyTextFont,
                    ),
                    trailing: RatingBar.readOnly(
                      maxRating: 5,
                      isHalfAllowed: true,
                      initialRating: doctor.ratingNum,
                      halfFilledIcon: Icons.star_half,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      size: 28,
                      filledColor: Colors.yellow,
                    ),
                    onTap: () {
                      context.bloc<PageBloc>().add(GoToSeeDoctorPage(doctor));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// userList = snapshot.data;
//             for (int i = 0; i < userList.length; i++) {
//               if (userList[i].status == doctorStatus &&
//                   userList[i].ratingNum > 3.0) {
//                 counter++;
//                 print(counter);
//               } else {
//                 counter--;
//               }
//             }
//             if (counter > 0) {
//               return buildListDoctor(doctorStatus);
//             } else {
//               return Container(
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "...No doctor found for a moment...",
//                     style: blackTextFont.copyWith(
//                         fontSize: 18, color: accentColor2),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               );
//             }

// ListTile(
//         //   contentPadding: EdgeInsets.symmetric(horizontal: 5),
//         //   leading: Image.network("${doctor.profileImage}"),
//         //   title: Text("${doctor.fullName}"),
//         //   subtitle: Text("${doctor.job}"),
// trailing: RatingBar(
//   allowHalfRating: true,
//   initialRating: doctor.ratingNum,
//   direction: Axis.horizontal,
//   itemCount: 5,
//   itemBuilder: (context, _) => Icon(
//     Icons.star,
//     color: Colors.amber,
//   ),
//   itemSize: 28,
//   onRatingUpdate: null,
// ),
//         // );

// return Container(
//                 height: 200,
//                 width: 400,
//                 padding: EdgeInsets.only(),
//                 child: ListView(
//                   children: [
//                     CustomChatTile(
//                         mini: false,
//                         leading: CircleAvatar(
//                           radius: 30,
//                           backgroundImage:
//                               NetworkImage(userList[i].profileImage),
//                         ),
//                         title: Text(
//                           userList[i].fullName,
//                           style: blackTextFont.copyWith(
//                               fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                         subtitle: Text(
//                           userList[i].job,
//                           style: greyTextFont,
//                         ),
//                         trailing: RatingBar(
//                           allowHalfRating: true,
//                           ignoreGestures: true,
//                           tapOnlyMode: true,
//                           initialRating: userList[i].ratingNum,
//                           direction: Axis.horizontal,
//                           itemCount: 5,
//                           itemBuilder: (context, _) => Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                           ),
//                           itemSize: 28,
//                           onRatingUpdate: null,
//                         ),
//                         onTap: () {}),
//                   ],
//                 ),
//               );

// return ListView.builder(
//         itemCount: doctorList.length,
//         itemBuilder: (context, index) {
//           User doctor = User(
//             doctorList[index].id,
//             doctorList[index].email,
//             fullName: doctorList[index].fullName,
//             status: doctorList[index].status,
//             profileImage: doctorList[index].profileImage,
//             ratingNum: doctorList[index].ratingNum,
//             job: doctorList[index].job,
//           );
//           return Container(
//             child: CustomChatTile(
//                 mini: false,
//                 leading: CircleAvatar(
//                   radius: 30,
//                   backgroundImage: NetworkImage(doctor.profileImage),
//                 ),
//                 title: Text(
//                   "dr.${doctor.fullName}",
//                   style: blackTextFont.copyWith(
//                       fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 subtitle: Text(
//                   doctor.job,
//                   style: greyTextFont,
//                 ),
//                 trailing: RatingBar.readOnly(
//                   maxRating: 5,
//                   isHalfAllowed: true,
//                   initialRating: doctor.ratingNum,
//                   halfFilledIcon: Icons.star_half,
//                   filledIcon: Icons.star,
//                   emptyIcon: Icons.star_border,
//                   size: 28,
//                   filledColor: Colors.yellow,
//                 ),
//                 onTap: () {}),
//           );
//         });
