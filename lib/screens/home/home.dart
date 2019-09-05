import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/inventory/get_all_inventory_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Home',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          isInventoryEmpty(),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Quick Statastics',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TertiaryButton(text: 'View more')
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              placeHolderContainer(),
              placeHolderContainer(),
              placeHolderContainer()
            ],
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Text(
              'Quick Shortcuts',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          shortCutWidgets(FeatherIcons.shoppingCart, 'Manage your inventory'),
          shortCutWidgets(FeatherIcons.box, 'Manage your inventory'),
          shortCutWidgets(FeatherIcons.userCheck, 'Contact Support'),
        ],
      ),
    );
  }

  Widget placeHolderContainer() {
    return Container(
      color: PRIMARY_COLOR.withOpacity(0.1),
      height: 120,
      width: 110,
    );
  }

  Widget emptyInventoryContainer() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: PRIMARY_COLOR,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: PRIMARY_COLOR.withOpacity(0.5),
            offset: Offset(2.0, 6.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Your inventory is empty!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: WHITE_COLOR,
                ),
              ),
              Icon(
                FeatherIcons.shoppingCart,
                size: 44,
                color: WHITE_COLOR.withOpacity(0.25),
              )
            ],
          ),
          Container(margin: EdgeInsets.only(top: 10)),
          Text(
            'You need to add items that you have in stock, to our inventory listing. Tap here to get started.',
            style: TextStyle(color: WHITE_COLOR, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget shortCutWidgets(icon, text) {
    return Container(
      padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 20.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: PRIMARY_COLOR.withOpacity(0.5)),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: PRIMARY_COLOR,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget isInventoryEmpty() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getVendorInventoryQuery,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.data != null &&
                result.data['getVendorInventory']['inventory'] == null) {
          return emptyInventoryContainer();
        }
        return Container();
      },
    );
  }
}
