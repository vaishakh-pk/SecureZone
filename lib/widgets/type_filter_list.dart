import 'package:flutter/material.dart';
import 'package:securezone/widgets/type_filter_item.dart';

class TypeFilterList extends StatelessWidget {
TypeFilterList({super.key});

List<String> typesItems = ['Type-1','Type-2','Type-3','Type-4'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          for(final item in typesItems)
            TypeFilterItem(item: item)
        ],
      ),
    );
  }
}
