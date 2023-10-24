import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomAppBar extends StatefulWidget {
  final Function() clickEvent;

  MyCustomAppBar({super.key, required this.clickEvent});

  @override
  State<StatefulWidget> createState() {
    return _MyCustomAppBar();
  }
}

class _MyCustomAppBar extends State<MyCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          child: Icon(
            Icons.info_outlined,
            color: Color(0xfff2f2f2),
            size: 24,
          ),
        ),
        Text(
          "MAPLE CLOSET",
          style: GoogleFonts.nanumMyeongjo(
            color: const Color(0xfff2f2f2),
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: widget.clickEvent,
          child: Icon(
            Icons.account_box,
            color: const Color(0xfff2f2f2),
            size: 24,
          ),
        ),
      ],
    );
  }
}