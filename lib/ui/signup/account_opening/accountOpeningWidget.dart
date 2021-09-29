
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

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
        height: size.height*0.075,
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

