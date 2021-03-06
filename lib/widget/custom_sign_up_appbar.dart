import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom_Sign_up_AppBar extends StatelessWidget {
  const Custom_Sign_up_AppBar({
    Key key,
    this.pageTitle,
    this.imageUrl,
    this.onTap,
  }) : super(key: key);

  final String pageTitle, imageUrl;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 1,
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(25),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              )),
        ),
       // Center(child: SvgPicture.asset(imageUrl)),
        Spacer(
          flex: 1,
        ),
        Text(
          pageTitle,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400, fontSize: 18.0, color: Colors.white),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}


///
/// ----custom appBar
///
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    this.pageTitle,
    this.onTap,
  }) : super(key: key);

  final String pageTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Spacer(
        //   flex: 1,
        // ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: EdgeInsets.all(25),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            pageTitle,
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.w400, fontSize: 13.0, color: Colors.white),
          ),
        ),

        Container(),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
