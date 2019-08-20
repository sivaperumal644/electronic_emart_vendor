import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final int index;
  List<Map<String, Object>> iconData;

  BottomBar({this.onTap, this.index, List<IconData> icons}) {
    this.iconData = icons
        .asMap()
        .map((index, icon) => MapEntry(index, {"index": index, "value": icon}))
        .values
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return bottomBar();
  }

  Widget bottomBar() {
    return Container(
      height: 70,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          onTap: onTap,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          items: iconData.map((icon) => barItem(icon)).toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem barItem(Map<String, Object> iconData) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.all(7),
        child: Icon(iconData['value'],
            color:
                iconData['index'] == index ? PRIMARY_COLOR : PRIMARY_COLOR.withOpacity(0.03)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: iconData['index'] == index
              ? PRIMARY_COLOR.withOpacity(0.03)
              : null,
        ),
      ),
      title: Container(),
    );
  }
}
