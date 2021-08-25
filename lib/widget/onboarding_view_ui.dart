import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardPageViewUI extends StatelessWidget {
  final String vector;
  final String title;
  final String image;
  final bool isImage;
  final String title_description;

  const OnBoardPageViewUI(
      {Key key,
      this.vector,
      this.isImage = false,
      this.image,
      @required this.title,
      @required this.title_description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // DecoratedBox(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        //   ),
        // ),

        // isImage
        //     ? Image.asset(
        //   image,
        //   width: MediaQuery.of(context).size.width / 2.5, //300,
        //   height: MediaQuery.of(context).size.height / 2.5, //300,
        // )
        //     : SvgPicture.asset(vector),
       Spacer(
         flex: 1,
       ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontSize: 25,
                fontWeight: FontWeight.w600,

              )
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title_description,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w300,

              )
            // style: AppTextStyles.h3style.copyWith(fontWeight: FontWeight.normal),
            // textAlign: TextAlign.center,
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
