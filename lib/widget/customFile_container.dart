import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickfund/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class CustomFileContainerWidget extends StatefulWidget {
  CustomFileContainerWidget({
    Key key,
    @required this.size,
    this.onTap,
    this.imageUrl,
    this.headline,
  }) : super(key: key);

  final Size size;
  final String imageUrl, headline;
  final Function onTap;

  @override
  _CustomFileContainerWidgetState createState() =>
      _CustomFileContainerWidgetState();
}

class _CustomFileContainerWidgetState extends State<CustomFileContainerWidget> {
  File imageFile;
  String imagePath;

  void pickImage() async {
    var selectImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = selectImage;
    });
  }

 void saveImage(path) async {
    SharedPreferences imagePref = await SharedPreferences.getInstance();
    imagePref.setString('imagePref', path);
  }

  Future<void> loadImage() async {
    SharedPreferences imagePref = await SharedPreferences.getInstance();
    setState(() {
      imagePath = imagePref.getString('imagePref');
    });
  }

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FDottedLine(
      color: kPrimaryColor.withOpacity(0.3),
      height: widget.size.height * 0.15,
      width: widget.size.width * 0.35,
      strokeWidth: 2.0,
      dottedLength: 10.0,
      space: 2.0,
      child: GestureDetector(
        onTap: () {
          // pickImage();
          // saveImage(imageFile.path);
        },
        child: Container(
          height: widget.size.height * 0.15,
          width: widget.size.width * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagePath != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(File(imagePath)),
                      radius: 30,
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundImage: imageFile != null
                          ? Image.file(imageFile)
                          : AssetImage(widget.imageUrl),
                    ),
              SizedBox(
                height: widget.size.height * 0.04,
              ),
              Text(
                widget.headline,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),

      /// Set corner
      corner: FDottedLineCorner.all(10),
    );
  }
}
