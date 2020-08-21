part of 'widgets.dart';

class CustomChatTile extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget icon;
  final Widget subtitle;
  final Widget trailing;
  final EdgeInsets margin;
  // mini to determine custom tile is larger or smaller
  final bool mini;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  CustomChatTile({
    @required this.leading,
    @required this.title,
    @required this.subtitle,
    this.trailing,
    this.icon,
    this.margin = const EdgeInsets.all(0),
    this.mini = true,
    @required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mini ? 10 : 0),
        margin: margin,
        child: Row(
          children: [
            leading,
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: mini ? 10 : 15),
              padding: EdgeInsets.symmetric(vertical: mini ? 5 : 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
                color: accentColor3.withOpacity(0.2),
              ))),
              // user name & chat message
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            icon != null ? icon : Container(),
                            subtitle,
                          ],
                        )
                      ],
                    ),
                  ),
                  trailing ?? Container(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
