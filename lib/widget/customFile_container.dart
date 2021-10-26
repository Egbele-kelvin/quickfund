
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickfund/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class CustomFileContainerWidget extends StatefulWidget {
  CustomFileContainerWidget({
    Key key,
    @required this.size,
    @required this.onTap,
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
  final ImagePicker picker = ImagePicker();
  void pickImage() async {
    PickedFile image = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile =  File(image.path);
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
      strokeWidth: 1.0,
      dottedLength: 10.0,
      space: 2.0,
      child: GestureDetector(
        onTap:widget.onTap,
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
                height: widget.size.height * 0.02,
              ),
              Text(
                widget.headline,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
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