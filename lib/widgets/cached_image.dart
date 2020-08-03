part of 'widgets.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;

  CachedImage({@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, urlImage) => Center(
            child: SpinKitFadingCircle(
              size: 30,
              color: accentColor2,
            ),
          ),
        ),
      ),
    );
  }
}
