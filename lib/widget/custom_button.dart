

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.size, this.btnTitle, this.onTap,
  }) : super(key: key);

  final Size size;
  final String btnTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap:onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),

            color: kPrimaryColor
        ),
        child: Center(
          child: Text(
            btnTitle,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
class CustomSignInButton extends StatelessWidget {
  const CustomSignInButton({
    Key key,
    @required this.size, this.btnTitle, this.onTap,
  }) : super(key: key);

  final Size size;
  final String btnTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap:onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),

            color: kPrimaryColor
        ),
        child: Center(
          child: Text(
            btnTitle,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
