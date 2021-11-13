
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'custom_button.dart';

class ResponseMessage extends StatelessWidget {
  const ResponseMessage({
    Key key,
    @required this.size, this.lotteError, this.msgTitle, this.textColor, this.subtitle,
  }) : super(key: key);

  final Size size;
  final Color textColor;
  final String lotteError, msgTitle, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
     //height: size.height*0.1,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
           lotteError ,
            height: size.height*0.2,
            fit:BoxFit.contain,
            repeat: false,
            reverse: false,
          ),
          SizedBox(height: size.height*0.05,),
          Container(
            width: size.width*0.7,
            height: size.height*0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 40),
            child: Column(
              children: [
                Text(msgTitle.toUpperCase(),  style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: textColor
                )),
                SizedBox(
                  height: size.height*0.03,
                ),
                Text(subtitle,
                  textAlign:TextAlign.center,
                  style: GoogleFonts.nunito(
                      decoration: TextDecoration.none,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
