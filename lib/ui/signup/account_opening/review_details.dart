import 'dart:io';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';

import 'accountOpeningWidget.dart';
import 'accountWidget.dart';

class ReviewDetails extends StatefulWidget {
  @override
  _ReviewDetailsState createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  int currentView = 0;
  bool showDataplan = false, showPhoneEdit = false;

  List<String> userTitle = ['Mr.', 'Mrs.', 'Miss.'];
  List<String> maritalStatusData = [
    'Single',
    'Married',
    'Widowed',
    'Separated',
    'Divorced'
  ];

  File _image;
  File _signImage;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  _imageFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  _imgFromCameraForSignature() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _signImage = image;
    });
  }

  _imageFromGalleryForSignature() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _signImage = image;
    });
  }

  List<String> genderData = ['Male', 'Female', 'Neuter'];
  String title = 'Title',
      gender = 'Gender',
      maritalStatus = 'Marital Status',
      stateOO;


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_camera),
                      title: Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _imageFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPickerSign(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_camera),
                      title: Text('Camera'),
                      onTap: () {
                        _imgFromCameraForSignature();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _imageFromGalleryForSignature();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> buildShowModalBottomSheetForGenderData(
      BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        useRootNavigator: true,
        barrierColor: Colors.black.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              // listener dismiss
              return true;
            },
            child: CustomBottomSheetMenuItem(
              customWidget: Column(
                children: [
                  CustomDetails(
                    heading: 'Gender',
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomItemWidget(
                              onTap: () {
                                setState(() {
                                  gender = genderData[index];
                                });

                                Navigator.of(context).pop();
                              },
                              descriptionItem: genderData[index],
                            );
                          },
                          separatorBuilder: (context, index) => Container(),
                          itemCount: genderData.length))
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> buildShowModalBottomSheetForMaritalStatus(
      BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        useRootNavigator: true,
        barrierColor: Colors.black.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              // listener dismiss
              return true;
            },
            child: CustomBottomSheetMenuItem(
              customWidget: Column(
                children: [
                  CustomDetails(
                    heading: 'Marital Status',
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomItemWidget(
                              onTap: () {
                                setState(() {
                                  maritalStatus = maritalStatusData[index];
                                });

                                Navigator.of(context).pop();
                              },
                              descriptionItem: maritalStatusData[index],
                            );
                          },
                          separatorBuilder: (context, index) => Container(),
                          itemCount: maritalStatusData.length))
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> buildShowModalBottomSheetForUserTitle(
      BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        useRootNavigator: true,
        barrierColor: Colors.black.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              // listener dismiss
              return true;
            },
            child: CustomBottomSheetMenuItem(
              customWidget: Column(
                children: [
                  CustomDetails(
                    heading: 'Title',
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomItemWidget(
                              onTap: () {
                                setState(() {
                                  title = userTitle[index];
                                });

                                Navigator.of(context).pop();
                              },
                              descriptionItem: userTitle[index],
                            );
                          },
                          separatorBuilder: (context, index) => Container(),
                          itemCount: userTitle.length))
                ],
              ),
            ),
          );
        });
  }

  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        if (showDataplan) {
          showDataplan = false;
        } else {
          currentView = 0;
        }
      });
      print('printght' + currentView.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return onBackPress();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColor,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                //color: kPrimaryColor,
                child: CustomAppBar(
                  onTap: () {
                    onBackPress();
                  },
                  pageTitle: 'Enter/Review Details',
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                //color: Colors.black,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                //
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(10)),
                  child: Stack(
                    children: [
                      Visibility(
                        visible: currentView == 0,
                        child: SingleChildScrollView(
                          child: Column(
                              children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SelectedCustom(
                              size: size,
                              onTap: () {
                                buildShowModalBottomSheetForUserTitle(
                                    context, size);
                              },
                              title: title,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              // onSaved: (newValue) => bvn = newValue,
                              customTextHintStyle: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              inputType: TextInputType.number,
                              labelText: 'First Name',
                              hintText: 'Bolanle',
                              autoCorrect: true,
                              hasFocus: AlwaysDisabledFocusNode(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              customTextHintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'Middle Name',
                              hintText: 'Sandra',
                              autoCorrect: true,
                              hasFocus: AlwaysDisabledFocusNode(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              customTextHintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'Last Name',
                              hintText: 'Samuel',
                              autoCorrect: true,
                              hasFocus: AlwaysDisabledFocusNode(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SelectedCustom(
                              size: size,
                              onTap: () {
                                buildShowModalBottomSheetForGenderData(
                                    context, size);
                              },
                              title: gender,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              customTextHintStyle: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'Birth Date',
                              hintText: '1956',
                              autoCorrect: true,
                              hasFocus: AlwaysDisabledFocusNode(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SelectedCustom(
                              size: size,
                              onTap: () {
                                buildShowModalBottomSheetForMaritalStatus(
                                    context, size);
                              },
                              title: maritalStatus,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              customTextHintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'Email',
                              hintText: 'email@gmail.com',
                              autoCorrect: true,
                              hasFocus: AlwaysDisabledFocusNode(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              customTextHintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'Phone Number',
                              hintText: '+23490897995',
                              autoCorrect: true,
                              hasFocus: AlwaysDisabledFocusNode(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              customTextHintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'Address',
                              hintText:
                                  '19 Wale Adeleye , ipaja-ayobo. lagos state.',
                              autoCorrect: true,
                              hasFocus: AlwaysDisabledFocusNode(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              customTextHintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'State of Origin',
                              hintText: 'oyo',
                              autoCorrect: true,
                              hasFocus: AlwaysDisabledFocusNode(),
                            ),
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            CustomButton(
                              size: size,
                              onTap: () {
                                setState(() {
                                  currentView = 1;
                                });
                              },
                              btnTitle: 'Continue'.toUpperCase(),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                          ]),
                        ),
                      ),

                      Visibility(
                          visible: currentView == 1,
                          child: CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  SelectedCustom(
                                    size: size,
                                    onTap: () {
                                      buildShowModalBottomSheetForMaritalStatus(
                                          context, size);
                                    },
                                    title: 'Bank Sate',
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  SelectedCustom(
                                    size: size,
                                    onTap: () {
                                      buildShowModalBottomSheetForMaritalStatus(
                                          context, size);
                                    },
                                    title: 'Bank Branch',
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ProfilePicAndSignature(size: size, image: _image ,
                                      imgURL: 'assets/f_png/cameraPic.png',
                                      tag: 'Take Selfie',
                                      onTap: (){
                                        _showPicker(context);
                                      },),

                                       ProfilePicAndSignature(size: size, image: _signImage ,
                                      tag: 'Upload signature',
                                      imgURL: 'assets/f_png/signature.png',
                                      onTap: (){
                                        _showPickerSign(context);
                                      },),

                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.04,
                                  ),
                                  CustomButton(
                                    size: size,
                                    onTap: () {
                                      KeyboardUtil.hideKeyboard(context);
                                      Navigator.pushNamed(context, AppRouteName.AccountOpeningUI);
                                    },
                                    btnTitle: 'Proceed',
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                ]),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
