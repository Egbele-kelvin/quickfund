import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/size_config.dart';

import 'custom_divider.dart';

class CustomQuickFundSelectMenu extends StatelessWidget {
  const CustomQuickFundSelectMenu({
    Key key,
    @required this.size, this.title, this.subTitle, this.onTap,
  }) : super(key: key);

  final Size size;
  final String title, subTitle;
  final Function onTap;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(3),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10),),
        height: size.height *0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),


        child: ListTile(
          title: Text(
           title,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.black
            ),
          ),
          subtitle: Text(
            subTitle.toUpperCase(),
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 13.5,
                color: kSelectMenuColor
            ),
          ),
          trailing: CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.forward,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


///
///
///
class CustomSelectMenu extends StatelessWidget {
  const CustomSelectMenu({
    Key key,
    @required this.size, this.title, this.subTitle, this.onTap,
  }) : super(key: key);

  final Size size;
  final String title, subTitle;
  final Function onTap;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(3),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10),),
        height: size.height *0.085,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),


        child: ListTile(
          title: Text(
           title,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black
            ),
          ),
          subtitle: Text(
            subTitle.toUpperCase(),
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 15.5,
                color: kSelectMenuColor
            ),
          ),
          trailing: Container(
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenHeight(30),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30)
            ),
            child: Icon(
              Icons.forward,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

///
/// ----custom selecet drop down menu -------
///


class CustomSelectDropdownMenu extends StatelessWidget {
  const CustomSelectDropdownMenu({
    Key key, this.widget,
  }) : super(key: key);

  //final Function onTap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}



