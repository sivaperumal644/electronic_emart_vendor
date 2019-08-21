import 'package:electronic_emart_vendor/components/bottom_bar.dart';
import 'package:electronic_emart_vendor/screens/home_screen/home_screen.dart';
import 'package:electronic_emart_vendor/screens/inventory_screen/inventory_screen.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class NavigateScreens extends StatefulWidget {
  @override
  _NavigateScreensState createState() => _NavigateScreensState();
}

class _NavigateScreensState extends State<NavigateScreens> {
  int selectedIndex = 0;
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
        return Container();
      case 3:
        return Container();
      default:
        return Container();
    }
  }
}
