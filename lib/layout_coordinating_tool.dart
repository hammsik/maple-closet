import 'package:flutter/material.dart';
import 'package:maple_closet/my_search_box.dart';
import 'package:maple_closet/my_tools.dart';
import 'package:maple_closet/my_undo_and_redo.dart';

import 'my_item_list.dart';
import 'my_item_menu.dart';
import 'my_selected_item.dart';

class CoordinatingTools extends StatelessWidget {
  const CoordinatingTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [SearchBox(), SizedBox(width: 8), UndoAndRedo()],
        ),
        SizedBox(height: 10),
        MyTools(),
        SizedBox(height: 10),
        Row(
          children: [SelectedItem(), SizedBox(width: 8), ItemMenu()],
        ),
        SizedBox(height: 10),
        Expanded(child: ItemList()),
      ],
    );
  }
}
