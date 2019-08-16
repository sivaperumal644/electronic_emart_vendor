import 'package:electronic_emart_vendor/components/app_bar_with_title.dart';
import 'package:electronic_emart_vendor/components/form_process_header.dart';
import 'package:electronic_emart_vendor/components/header_and_subheader.dart';
import 'package:electronic_emart_vendor/components/inventory_list_item.dart';
import 'package:electronic_emart_vendor/components/order_details.dart';
import 'package:electronic_emart_vendor/components/order_list_item.dart';
import 'package:electronic_emart_vendor/components/persistent_bottom_bar.dart';
import 'package:electronic_emart_vendor/components/setting_option.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: AppBarWithTitle(
              title: 'Add new items',
            ),
          ),
          FormProcessHeader(
            currentScreen: 1,
            title: 'Login Credential',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 24, right: 24),
            child: InvetoryListItem(
              currentPrice: 45000,
              discountPrice: 40000,
              stock: 'Mobile Phones',
              stockAvailable: 14,
              inventoryItem: 'Apple iPhone line X- 64 GB / Rose Gold',
            ),
          ),
          SettingsOption(
            title: 'Edit your address',
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomTextField(),
          ),
          PersistentBottomBar(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: HeaderAndSubHeader(
              headerText: 'Contact Information',
              subHeaderText: 'We will use this information to contact you',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: OrderListItem(),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: OrderDetails(),
          )
        ],
      ),
    );
  }
}
