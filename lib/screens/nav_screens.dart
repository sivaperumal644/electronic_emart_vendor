import 'package:electronic_emart_vendor/components/bottom_bar.dart';
import 'package:electronic_emart_vendor/screens/order_stats/order_stats.dart';
import 'package:electronic_emart_vendor/screens/profile/profile.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';
import 'inventory/inventory.dart';

class NavigateScreens extends StatefulWidget {
  final int selectedIndex;

  const NavigateScreens({this.selectedIndex = 0});
  @override
  _NavigateScreensState createState() => _NavigateScreensState();
}

class _NavigateScreensState extends State<NavigateScreens> {
  int selectedIndex = 0;
  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
      bottomNavigationBar: BottomBar(
        index: selectedIndex,
        icons: [
          FeatherIcons.home,
          FeatherIcons.shoppingCart,
          FeatherIcons.box,
          FeatherIcons.settings
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget layout() {
    switch (selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return InventoryScreen();
      case 2:
        return OrderStatScreen();
      case 3:
        return ProfileScreen();
      default:
        return Container();
    }
  }
}
