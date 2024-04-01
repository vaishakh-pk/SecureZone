import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';

class TypeFilterItem extends StatelessWidget {
 TypeFilterItem({super.key,required this.item});

  String item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
                // padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                height: 25,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: knavbarselected,
                ),
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 10,)
      ],
    );
  }
}