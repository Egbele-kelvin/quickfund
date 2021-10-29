
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

import 'activateDeviceUI.dart';

class SelectedCustom extends StatelessWidget {
  const SelectedCustom({
    Key key,
    @required this.size, this.title, this.onTap,
  }) : super(key: key);

  final Size size;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        height: size.height*0.07,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey.withOpacity(0.3)
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),),

            Icon(
              Icons.keyboard_arrow_down,
              color: kPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}

class ActivateDeviceNumberWidget extends StatelessWidget {
  const ActivateDeviceNumberWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ActivateDevice widget;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      softWrap: true,
      text: TextSpan(
        text: 'Enter OTP sent to ',
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w300, fontSize: 12,
            color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: '${widget.phoneNumber}',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 12)),
          TextSpan(
              text: ' \n To Activate Device',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300, fontSize: 12)),
        ],
      ),
    );
  }
}
