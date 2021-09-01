
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';

class GetHelp_widget extends StatelessWidget {
  const GetHelp_widget({
    Key key,
    @required this.size, this.title, this.leadingIcon, this.trailingIcon, this.onTap,
  }) : super(key: key);

  final Size size;
  final String title;
  final Function onTap;
  final IconData leadingIcon, trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.067,
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 1),
          height: size.height * 0.05,
          width: size.width * 0.11,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: kPrimaryColor,
                width: 1,
              )),
          child: Icon(
            leadingIcon,
            size: 20,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
        title,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        trailing: Icon(Icons.arrow_forward,
          size: 20,
          color: Colors.black,),
      ),
    );
  }
}


class BillWidget extends StatelessWidget {
  const BillWidget({
    Key key,
    @required this.size, this.title, this.leadingIcon, this.trailingIcon, this.onTap,
  }) : super(key: key);

  final Size size;
  final String title;
  final Function onTap;
  final IconData leadingIcon, trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.064,
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(8),
        vertical: getProportionateScreenHeight(8),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 1),
          height: size.height * 0.04,
          width: size.width * 0.09,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: kPrimaryColor.withOpacity(0.6),
                width: 1,
              ),
          ),
          child: Icon(
            leadingIcon,
            size: 20,
            color: kPrimaryColor.withOpacity(0.7),
          ),
        ),
        title: Text(
        title,
          style: GoogleFonts.lato(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        trailing: Icon(Icons.arrow_forward,
          size: 16,
          color: Colors.black,),
      ),
    );
  }
}


class CustomAirtimeWidget extends StatelessWidget {
  const CustomAirtimeWidget({
    Key key,
    @required this.size, this.title, this.leadingIcon, this.trailingIcon, this.onTap, this.imgURL,
  }) : super(key: key);

  final Size size;
  final String title , imgURL;
  final Function onTap;
  final IconData leadingIcon, trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.064,
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(8),
        vertical: getProportionateScreenHeight(8),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 1),
          height: size.height * 0.04,
          width: size.width * 0.09,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(40),
          //     border: Border.all(
          //       color: kPrimaryColor.withOpacity(0.6),
          //       width: 1,
          //     ),
          // ),
          child: SvgPicture.asset(imgURL),
        ),
        title: Text(
        title,
          style: GoogleFonts.lato(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        trailing: Icon(Icons.arrow_forward,
          size: 16,
          color: Colors.black,),
      ),
    );
  }
}
