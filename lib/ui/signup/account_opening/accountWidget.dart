import 'dart:io';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

class ProfilePicAndSignature extends StatelessWidget {
  const ProfilePicAndSignature({
    Key key,
    @required this.size,
    @required File image,
    this.onTap, this.tag, this.imgURL,
  })  : _image = image,
        super(key: key);

  final Size size;
  final File _image;
  final Function onTap;
  final String tag  , imgURL;

  @override
  Widget build(BuildContext context) {
    return FDottedLine(
      color: _image == null ? kPrimaryColor.withOpacity(0.3) : Colors.white,
      height: size.height * 2,
      width: size.width * 4,
      strokeWidth: 1.0,
      dottedLength: 7.0,
      space: 2.0,
      corner: FDottedLineCorner.all(10),
      child: InkResponse(
        onTap: onTap,
        child: Container(
          height: size.height * 0.15,
          width: size.width * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: size.height * 0.1,
                width: size.width * 0.4,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: _image == null
                //           ? AssetImage(
                //           'assets/f_png/avatar.png')
                //           : FileImage(File(_image.path)),
                //     )),

                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: _image == null
                      ? Image.asset(imgURL,width: size.width *0.1,)
                      : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius:60,
                      backgroundImage: FileImage(File(_image.path))),
                ),
              ),
              Text(
                _image == null ? tag : '',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class AccountContainerwIDGET extends StatelessWidget {
  const AccountContainerwIDGET({
    Key key, this.accountName, this.accountNum, this.onTap,
  }) : super(key: key);
  final String accountName, accountNum;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          onTap:onTap,
          title: Text(accountName, style: GoogleFonts.nunito(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Colors.grey
          ),),
          subtitle: Text(accountNum, style: GoogleFonts.nunito(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),),
        ),
        Divider(thickness: 0.5,)
      ],
    );
  }
}
