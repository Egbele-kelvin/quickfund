
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

class ResendOTP extends StatelessWidget {
  const ResendOTP({
    Key key, this.onTap, this.textI, this.textII,
  }) : super(key: key);

  final textI , textII;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(

            textI,
            style: GoogleFonts.robotoMono(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          Text(
            textII,
            style: GoogleFonts.robotoMono(
                color: kTap,
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
