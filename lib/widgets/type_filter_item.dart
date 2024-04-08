import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:securezone/screens/google_maps_screen.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeFilterItem extends StatefulWidget {
  TypeFilterItem({
    Key? key,
    required this.item,
    required this.role,
    required this.activeFilter,
    required this.onFilterSelected,
  }) : super(key: key);

  final String item;
  final String role;
  final String activeFilter;
  final Function(String) onFilterSelected; // Callback to update active filter

  @override
  State<TypeFilterItem> createState() => _TypeFilterItemState();
}

class _TypeFilterItemState extends State<TypeFilterItem> {
  Color activeColor = knavbarselected;

  @override
  void initState() {
    super.initState();
    // checkActive();
  }

  void checkActive() {
    setState(() {
      activeColor =
          widget.item == widget.activeFilter ? knavbartheme : knavbarselected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // Update active filter and notify parent
            widget.onFilterSelected(widget.item);
          },
          child: Container(
            alignment: Alignment.center,
            height: 25,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: activeColor,
            ),
            child: Text(
              widget.item,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
