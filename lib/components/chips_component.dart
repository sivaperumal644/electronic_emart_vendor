import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class ChipsComponent extends StatefulWidget {
  final List<String> itemList;
  final String selectedChips;
  final ValueChanged<String> onChanged;

  ChipsComponent({this.itemList, this.selectedChips, this.onChanged});

  @override
  _ChipsComponentState createState() => _ChipsComponentState();
}

class _ChipsComponentState extends State<ChipsComponent> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.itemList.map((item) {
        setState(() {
          if (widget.selectedChips == item) {
            isSelected = true;
          } else {
            isSelected = false;
          }
        });
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ChoiceChip(
            label: Text(
              item,
              style: TextStyle(
                color: isSelected ? WHITE_COLOR : PRIMARY_COLOR,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            selected: isSelected,
            selectedColor: PRIMARY_COLOR,
            onSelected: (value) => widget.onChanged(item),
            backgroundColor: PRIMARY_COLOR.withOpacity(0.13),
            avatar: isSelected
                ? Icon(FeatherIcons.checkCircle, color: WHITE_COLOR, size: 16)
                : null,
          ),
        );
      }).toList(),
    );
  }
}
