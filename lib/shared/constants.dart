part of 'shared.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const double defaultMargin = 24.0;

const mainColor = Color(0xFF3347AE);
const accentColor1 = Color(0xFF6777CA);
const accentColor2 = Color(0xFFFF7F78);
const accentColor3 = Color(0xFF949494);
const accentColor4 = Color(0xFF3E3E3E);
const accentColor5 = Color(0xFFEFE3E2);
const accentColor6 = Color(0xFFd29856);
const accentColor7 = Color(0xFFEEEEEE);
const onlineDotColor = Color(0xFF88D840);
const offlineDotColor = Color(0xFFD8232A);
const awayDotColor = Color(0xFFFFA500);

TextStyle greyTextFont = GoogleFonts.nunito()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);
TextStyle blackTextFont = GoogleFonts.nunito()
    .copyWith(color: accentColor4, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.nunito()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle pinkTextFont = GoogleFonts.nunito()
    .copyWith(color: accentColor2, fontWeight: FontWeight.w500);
