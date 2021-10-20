import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

class FundAccountWidget extends StatelessWidget {
  const FundAccountWidget({
    Key key,
    @required this.size,
    this.onTap,
    this.title,
    this.subtitle,
    this.iconData, this.copyIcon,
  }) : super(key: key);

  final Size size;
  final Function onTap;
  final String title, subtitle;
  final IconData iconData , copyIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size.height * 0.095,
          width: double.infinity,
          //padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.withOpacity(0.25),
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: kShadowColor,
              radius: 20,
              child: Icon(
                iconData,
                size: 18,
                color: kPrimaryColor,
              ),
            ),
            title: Text(
              title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                  color: Colors.black),
            ),
            subtitle: Text(
              subtitle,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),

            trailing: copyIcon ==null ? SizedBox() : Icon(copyIcon, size: 10,color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
