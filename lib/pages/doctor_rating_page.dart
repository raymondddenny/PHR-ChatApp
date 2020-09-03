part of 'pages.dart';

class DoctorRatingPage extends StatefulWidget {
  final Call call;
  DoctorRatingPage({this.call});
  @override
  _DoctorRatingPageState createState() => _DoctorRatingPageState();
}

class _DoctorRatingPageState extends State<DoctorRatingPage> {
  double _rating;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: (widget.call.callerStatus == "Patient")
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "How was the consultation with dr. ${widget.call.receiverName} ?"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: RatingBar(
                    onRatingChanged: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    filledColor: Colors.yellow,
                    emptyColor: Colors.grey[350],
                    halfFilledIcon: Icons.star_half,
                    halfFilledColor: Colors.yellow,
                    isHalfAllowed: true,
                    size: 28,
                    maxRating: 5,
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      color: mainColor,
                      child: Text(
                        "Submit doctor rating",
                        style: greyTextFont.copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        UserServices.setDoctorRating(
                            widget.call.receiverId, _rating.toDouble());
                        context.bloc<PageBloc>().add(GoToMainPage());
                      }),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "How was the consultation with dr. ${widget.call.callerName} ?"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: RatingBar(
                    onRatingChanged: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    filledColor: Colors.yellow,
                    emptyColor: Colors.grey[350],
                    halfFilledIcon: Icons.star_half,
                    halfFilledColor: Colors.yellow,
                    isHalfAllowed: true,
                    size: 28,
                    maxRating: 5,
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      color: mainColor,
                      child: Text(
                        "Submit doctor rating",
                        style: greyTextFont.copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        UserServices.setDoctorRating(
                            widget.call.callerId, _rating.toDouble());
                        context.bloc<PageBloc>().add(GoToMainPage());
                      }),
                ],
              ),
      ),
    );
  }
}
