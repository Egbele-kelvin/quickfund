import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardGetStartedComponent extends StatelessWidget {
  const DashBoardGetStartedComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Get Started',
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.black),
        ),
      ),
      alignment: Alignment.topLeft,
    );
  }
}
