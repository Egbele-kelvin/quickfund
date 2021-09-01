import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RefrenceContent extends StatelessWidget {
  const RefrenceContent({
    Key key,
    @required this.size, this.tag, this.labelI, this.labelII, this.labelIII,
  }) : super(key: key);

  final Size size;
  final String tag , labelI, labelII, labelIII;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width *.23,
              height: size.height *.08,
              child: Text(tag , style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.black
              ),
              ),
            ),
            Container(
              width: size.width *.7,
              height: size.height *.08,
              child: Column(
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2),
                      child: Text(labelI, style: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                    alignment: Alignment.topRight,
                  ),  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2),
                      child: Text(labelII, style: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                    alignment: Alignment.topRight,
                  ),  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2),
                      child: Text(labelIII, style: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                    alignment: Alignment.topRight,
                  ),
                ],
              ),
            ),

          ],
        ),
        FDottedLine(
          width: double.infinity,
          color: Colors.grey.withOpacity(0.5),
        )
      ],
    );
  }
}


class SummaryRe extends StatelessWidget {
  const SummaryRe({
    Key key,
    @required this.size, this.tag, this.labelI
  }) : super(key: key);

  final Size size;
  final String tag , labelI;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tag , style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.black
            ),
            ),
           Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2),
                child: Text(labelI, style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w400,
                ),),
              ),
              alignment: Alignment.topRight,
            ),

          ],
        ),
        SizedBox(height: size.height *0.02,),
        FDottedLine(
          width: double.infinity,
          color: Colors.grey.withOpacity(0.5),
        )
      ],
    );
  }
}
