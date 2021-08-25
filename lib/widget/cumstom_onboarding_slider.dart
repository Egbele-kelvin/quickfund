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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 200),
                padding: EdgeInsets.only(left: 28, right: 36),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
