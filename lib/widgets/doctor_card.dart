part of 'widgets.dart';

class DoctorCard extends StatelessWidget {
  final String doctorType;

  DoctorCard({this.doctorType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: accentColor2.withOpacity(0.4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "images/Icon_dokter_umum.png",
            height: 60,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Saya butuh ",
            style: blackTextFont,
          ),
          Text(
            doctorType,
            style: blackTextFont.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
