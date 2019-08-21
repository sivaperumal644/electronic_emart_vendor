import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final String itemValue;
  final String hint;
  final List<String> itemList;
  final ValueChanged<String> onChanged;

  DropDownWidget({this.itemValue, this.hint, this.itemList, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: PRIMARY_COLOR.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      width: MediaQuery.of(context).size.width / 1.7,
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: Icon(FeatherIcons.chevronDown, color: PRIMARY_COLOR),
        underline: Container(),
        hint: Text(
          hint,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
          ),
        ),
        style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        items: itemList
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
        value: itemValue,
        //hint: Text('Enter a value'),
      ),
    );
  }
}
