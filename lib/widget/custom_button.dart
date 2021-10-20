

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            style: GoogleFonts.poppins(
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


class CalenderPickWidget extends StatelessWidget {
  const CalenderPickWidget({
    Key key,
    @required this.size, this.titleMessage, this.onSelect,
  }) : super(key: key);

  final Size size;
  final Function onSelect;
  final String titleMessage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: size.height * 0.075,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.grey.withOpacity(0.2))),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleMessage,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
            ),
            SvgPicture.asset('assets/f_svg/calender.svg' , color: kPrimaryColor,)
          ],
        ),
      ),
    );
  }
}



class FileTypeWidget extends StatelessWidget {
  const FileTypeWidget({
    Key key,
    @required this.selectFileType,
    @required this.size, this.onTap,
  }) : super(key: key);

  final List selectFileType;
  final Size size;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: selectFileType
          .asMap()
          .entries
          .map((e) => Padding(
        padding: const EdgeInsets.only(top: 18.0, right: 30 ,left: 5),
        child: InkResponse(
          onTap: onTap,
          child: SvgPicture.asset(
            'assets/f_svg/${e.value}.svg',
            width: size.width * 0.06,
          ),
        ),
      ))
          .toList(),
    );
  }
}
