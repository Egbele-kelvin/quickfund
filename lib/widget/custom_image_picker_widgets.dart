import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:quickfund/util/constants.dart';
class CustomImagePicker extends StatelessWidget {

  const CustomImagePicker({
    Key key,
    @required File image, this.icon,
  }) : _image = image, super(key: key);

  final File _image;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return

      Stack(
        children:[
          FDottedLine(
            color: kPrimaryColor.withOpacity(0.3),
            height: MediaQuery.of(context).size.height *  0.15,
            width:MediaQuery.of(context).size.height * 0.35,
            strokeWidth: 2.0,
            dottedLength: 10.0,
            space: 2.0,
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              )
                  : Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 100,
                child: Center(
                  child: FaIcon(
                    icon,size: 30,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            corner: FDottedLineCorner.all(10),
          ),
          Positioned(
            top: 85,
              left: 15,
              child: Text('Take A Selfie',style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w400
              ),))
        ]
      );
  }
}

class CustomImagePickerSignature extends StatelessWidget {
  const CustomImagePickerSignature({
    Key key,
    @required File image, this.icon,
  }) : _signImage = image, super(key: key);

  final File _signImage;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FDottedLine(
          color: kPrimaryColor.withOpacity(0.3),
          height: MediaQuery.of(context).size.height *  0.15,
          width:MediaQuery.of(context).size.height * 0.35,
          strokeWidth: 2.0,
          dottedLength: 10.0,
          space: 2.0,
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            child: _signImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                _signImage,
                width: 100,
                height: 100,
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
              ),
            )
                : Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
              width: 100,
              height: 100,
              child: Center(
                child: FaIcon(
                  icon,size: 30,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          corner: FDottedLineCorner.all(10),
        ),
        Positioned(
            top: 85,
            left: 13,
            child: Text('Your Signature',style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w400
            ),))
      ],
    );
  }
}