import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    @required this.btnColor,@required this.btnName, this.onTap,
  });
  final Color btnColor;
  final Function onTap;
  final String btnName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
        width: 320,
        height: 60,
        decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Container(
          margin: EdgeInsets.only(top: 16,bottom: 16),
          alignment: Alignment.center,
          child: Text(btnName,
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),),
        ),
      ),
    );
  }
}


class DotIndicator extends StatefulWidget {
  final bool isActive;

  DotIndicator(this.isActive);

  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 8.0,
        width: 30.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: widget.isActive ? kPrimaryColor : Colors.grey),
      ),
    );
  }
}
