import 'package:flutter/material.dart';
import 'package:maple_closet/models/skeleton_myCharacter.dart';

class SelectedItem extends StatefulWidget {
  final MyCharacter currentCharacter;
  final Function clickCloseButton;
  final String subCategory;

  const SelectedItem(
      {super.key,
      required this.currentCharacter,
      required this.clickCloseButton,
      required this.subCategory});

  @override
  State<StatefulWidget> createState() {
    return _SelectedItem();
  }
}

class _SelectedItem extends State<SelectedItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 230, 222, 218),
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget.currentCharacter.itemMap[widget.subCategory][0] ==
                    'null' ||
                widget.currentCharacter.itemMap[widget.subCategory][0] ==
                    '1040036' ||
                widget.currentCharacter.itemMap[widget.subCategory][0] ==
                    '1060026'
            ? const Text('아이템을 선택해주세요')
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.network(
                    'https://maplestory.io/api/KMST/1157/item/${widget.currentCharacter.itemMap[widget.subCategory][0]}/icon',
                    width: 25,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported_outlined);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                          widget.currentCharacter.itemMap[widget.subCategory]
                              [1],
                          style: const TextStyle(fontSize: 9))),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FilledButton(
                    onPressed: () =>
                        widget.clickCloseButton(widget.subCategory),
                    style: FilledButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 60, 58, 78),
                        backgroundColor:
                            const Color.fromARGB(255, 201, 191, 191),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.all(0),
                        fixedSize: const Size(30, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 20,
                    ),
                  ),
                  // child: const ,
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
      ),
    );
  }
}
