part of 'widgets.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final bool isRounded;
  final double radius;
  final double height;
  final double width;

  final BoxFit fit;

  final String noImageAvailable = "Images/user_default.jpg";

  CachedImage(
    this.imageUrl, {
    this.isRounded = false,
    this.radius = 0,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });
  @override
  Widget build(BuildContext context) {
    try {
      return SizedBox(
        height: isRounded ? radius : height,
        width: isRounded ? radius : width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isRounded ? 20 : radius),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            placeholder: (context, urlImage) => Center(
              child: SpinKitFadingCircle(
                size: 30,
                color: accentColor2,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              noImageAvailable,
              fit: fit,
            ),
          ),
        ),
      );
    } catch (e) {
      print(e);
      return Image.asset(
        noImageAvailable,
        fit: fit,
      );
    }
  }
}
