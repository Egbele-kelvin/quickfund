import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    Key key,
    @required this.size, this.detail,
  }) : super(key: key);

  final Size size;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: size.height *0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(

            color: Colors.black.withOpacity(0.08),
          )
      ),
      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(detail, style: GoogleFonts.robotoMono(
                fontWeight: FontWeight.w300,
                fontSize: 10,
                color: Colors.black

            ),),
          ),

          Icon(Icons.check_circle_sharp, color: Colors.green,size: 14,)
        ],),
    );
  }
}
