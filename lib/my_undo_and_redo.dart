import 'package:flutter/material.dart';

class UndoAndRedo extends StatefulWidget {
  const UndoAndRedo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UndoAndRedo();
  }
}

class _UndoAndRedo extends State<UndoAndRedo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 55,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffF2E5E5),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 55,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffF2E5E5),
          ),
        ),
      ],
    );
  }
}
