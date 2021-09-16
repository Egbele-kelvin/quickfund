import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSlider extends StatelessWidget {
  //const CustomSlider({Key? key}) : super(key: key);

  final String backgroundImage;
  final String title;
  final String desc;

  const CustomSlider(
      {Key key,
      @required this.backgroundImage,
      @required this.title,
      @required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: size.height,
                color: Colors.black.withOpacity(0.78),
              ),
              Column(
                children: [
                  Spacer(flex: 2,),
                  Container(
                    margin: EdgeInsets.only(top: 200),
                    padding: EdgeInsets.only(left: 28, right: 36),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 40, bottom: 90),
                      padding: EdgeInsets.only(left: 28, right: 36),
                      child: Text(
                        desc,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 3,),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
