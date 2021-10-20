import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/createAccountBvnReq.dart';
import 'package:quickfund/data/model/createAccountBvnResp.dart';
import 'package:quickfund/data/model/verifyBvnResp.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/deviceInfo.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:universal_platform/universal_platform.dart';

import 'accountOpeningWidget.dart';
import 'accountWidget.dart';

class ReviewDetails extends StatefulWidget {
  const ReviewDetails({Key key}) : super(key: key);

  @override
  _ReviewDetailsState createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  int currentView = 0;
  final List<String> errors = [];
  var signature, profilePic;
  bool _passwordVisible, _confirPasswordVisible;
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }
  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  List<String> genderData = ['Male', 'Female', 'Neuter'];
  String title = 'Title', gender = 'Gender', responseData='', maritalStatus = 'Marital Status',
      bvn, phoneNumber, firstName, address, lastName, otherNames, dob,password,confirmPassword, email, state;

  bool showDataplan = false, showPhoneEdit = false,isLoading = false;
  List<String> userTitle = ['Mr.', 'Mrs.', 'Miss.'];
  List<String> maritalStatusData = [
    'Single',
    'Married',
    'Widowed',
    'Separated',
    'Divorced'
  ];

  var deviceID , deviceName;
  void getImei() async {
    final deviceInfo = DeviceInfoPlugin();

    if (UniversalPlatform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceID = androidInfo.androidId;
      deviceName = androidInfo.brand;
      print('deviceID: $deviceID');
      print('deviceName: $deviceName');
    } else if (UniversalPlatform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor;
      deviceName=iosInfo.name;
      print('deviceID: $deviceID');
      print('deviceName: $deviceName');
    }


  }
  @override
  void initState() {
    getImei();
    _passwordVisible = true;
    _confirPasswordVisible = true;
    super.initState();
  }
  File _image;
  File _signImage;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  responseMessage(String message, Color color) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
      ),
      backgroundColor: color,
    ));
  }

  void createAccountUsingBVN(
      CreateAccountBvn createAccountBvn, SetupAccountViaBVNandViaPhone authProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await authProvider.createAccountViaBvn(createAccountBvn);
      if (authProvider.createAccountUsingBvn != null) {
        final createAccountViaBVNResp =
        CreateAccountBvnResp.fromJson(authProvider.createAccountUsingBvn);
        if (createAccountViaBVNResp.status==true) {
          setState(() {
            isLoading = false;
          });
          responseData = createAccountViaBVNResp.message.toString();
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          Navigator.pushReplacementNamed(context, AppRouteName.AccountOpeningUI);
        }else{
          setState(() {
            isLoading=false;
          });
          responseData = createAccountViaBVNResp.message;
          print('responseMessage : $responseData ${createAccountViaBVNResp.data.user}');
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage('Server Auth Error', Colors.red);
    }
  }


  parseAuthData(SetupAccountViaBVNandViaPhone authProvider) {
    try {
      if (authProvider.verifyBvnOtp != null) {
        final userData = VerifyBvnResp.fromJson(authProvider.verifyBvnOtp);
        firstName = userData.data.firstName.toLowerCase();
        lastName = userData.data.lastName.toLowerCase();
        phoneNumber = userData.data.phoneNumber.toLowerCase();
        otherNames = userData.data.otherNames.toLowerCase();
        dob = userData.data.dob.toLowerCase();
        bvn = userData.data.bvn.toLowerCase();
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
      print(_image);
      var bytes = utf8.encode(_image.path);
      profilePic = base64.encode(bytes);
      print('profile pic ------ $profilePic');
    });
  }

  _imageFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
      print(_image);
      var bytes = utf8.encode(_image.path);
      profilePic = base64.encode(bytes);
      print('profile pic ------ $profilePic');
    });
  }

  _imgFromCameraForSignature() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _signImage = image;
      print(_signImage);
      var bytes = utf8.encode(_signImage.path);
      signature = base64.encode(bytes);
      print('signature ------ $signature');
    });
  }

  _imageFromGalleryForSignature() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _signImage = image;
      print(_signImage);
      var bytes = utf8.encode(_signImage.path);
      signature = base64.encode(bytes);
      print('signature ------ $signature');
    });
  }


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
        barrierColor: Colors.black.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        builder: (context) {
          return CustomBottomSheetMenuItem(
            customWidget: Column(
              children: [
                CustomDetails(
                  heading: 'Title',
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Expanded(
                    child: ListView(
                      shrinkWrap: true,
                        children: userTitle
                            .asMap()
                            .entries
                            .map((e) => CustomItemWidget(
                                onTap: () {
                                  setState(() {
                                    title = e.value;
                                  });
                                  Navigator.of(context).pop();
                                },
                                descriptionItem: e.value))
                            .toList()))
              ],
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
    getImei();
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Consumer<SetupAccountViaBVNandViaPhone>(
      builder: (context, provider, child) {
        parseAuthData(provider);
        return WillPopScope(
          onWillPop: () {
            return onBackPress();
          },
          child: LoadingOverlay(
            isLoading: isLoading,
            child: Scaffold(
              key: scaffoldKey,
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
                flex: 9,
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
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Visibility(
                            visible: currentView == 0,
                            // child: SingleChildScrollView(
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
                                      hintText: '$firstName' ?? '',
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
                                      hintText: '$otherNames',
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
                                      hintText: '$lastName' ?? '',
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
                                      hintText: '$dob' ?? '',
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
                                      onSaved: (newValue) => email = newValue,
                                      inputType: TextInputType.emailAddress,
                                      labelText: 'Email',
                                      autoCorrect: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: 'Email Address is required');
                                    } else if (value.isNotEmpty) {
                                      removeError(error: 'Email Address is required');
                                    }
                                    email = value;
                                  },
                                  validateForm: (value) {
                                    if (value.isEmpty) {
                                      addError(error: 'Email Address is required');
                                      return "";
                                    }
                                    return null;
                                  },
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
                                      hintText: '$phoneNumber',
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
                                      onSaved: (newValue) => address = newValue,
                                      inputType: TextInputType.text,
                                      labelText: 'Address',
                                      autoCorrect: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: 'Address is required');
                                    } else if (value.isNotEmpty) {
                                      removeError(error: 'Address is required');
                                    }
                                    address = value;
                                  },
                                  validateForm: (value) {
                                    if (value.isEmpty) {
                                      addError(error: 'Address is required');
                                      return "";
                                    }

                                    return null;
                                  },
                                      // hasFocus: AlwaysDisabledFocusNode(),
                                    ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                RoundedInputField(
                                  customTextHintStyle: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      onSaved: (newValue) => state = newValue,
                                      inputType: TextInputType.text,
                                      labelText: 'State of Origin',
                                      autoCorrect: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: 'State of Origin is required');
                                    } else if (value.isNotEmpty) {
                                      removeError(error: 'State of Origin is required');
                                    }
                                    state = value;
                                  },
                                  validateForm: (value) {

                                    if (value.isEmpty) {
                                      addError(error: 'State of Origin is required');
                                      return "";
                                    }

                                    return null;
                                  },
                                    ),
                                SizedBox(
                                  height: size.height * 0.06,
                                ),
                                CustomButton(
                                  size: size,
                                  onTap: () {
                                    KeyboardUtil.hideKeyboard(context);
                                    setState(() {

                                      currentView = 1;
                                    });
                                  },
                                  btnTitle: 'Continue',
                                ),
                                SizedBox(
                                  height: size.height * 0.3,
                                ),
                              ]),
                            // ),
                          ),

                          Visibility(
                              visible: currentView == 1,
                              child: Column(children: [
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                RoundedInputField(
                                  maxLen: 6,
                                  passwordvisible: _passwordVisible,
                                  customTextHintStyle: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.black54.withOpacity(0.3),
                                      fontWeight: FontWeight.w600),
                                  // onSaved: (newValue) => bvn = newValue,
                                  inputType: TextInputType.visiblePassword,
                                  labelText: 'Password',
                                  hintText: '*********',
                                  autoCorrect: true,
                                  onSaved: (newValue) => password = newValue,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: kPinNullError);
                                    } else if (value.length >= 4) {
                                      removeError(error: kShortPinError);
                                    }
                                    password = value;
                                  },
                                  validateForm: (value) {

                                    setState(() {
                                      if (value.isEmpty) {
                                        addError(error: kPinNullError);
                                        return "";
                                      } else if (value.length < 4) {
                                        addError(error: kShortPinError);
                                        return "";
                                      }

                                    });

                                    return null;
                                  },
                                  suffixIcon: InkWell(
                                      child: Icon(
                                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Colors.grey[500],
                                        size: 15,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      }),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                RoundedInputField(

                                  customTextHintStyle: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.black54.withOpacity(0.3),
                                      fontWeight: FontWeight.w600),
                                  // onSaved: (newValue) => bvn = newValue,
                                  inputType: TextInputType.visiblePassword,
                                  labelText: 'Confirm Password',
                                  maxLen: 6,
                                  hintText: '**********',
                                  autoCorrect: true,
                                  passwordvisible: _confirPasswordVisible,
                                  onSaved: (newValue) =>
                                  confirmPassword = newValue,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: kPassNullError);
                                    } else if (value.isNotEmpty &&
                                        password == confirmPassword) {
                                      removeError(error: kMatchPassError);
                                    }
                                    confirmPassword = value;
                                  },
                                  validateForm: (value) {

                                    setState(() {
                                      if (value.isEmpty) {
                                        addError(error: kPassNullError);
                                        return "";
                                      } else if ((password != value)) {
                                        addError(error: kMatchPassError);
                                        return "";
                                      }

                                    });

                                    return null;
                                  },
                                  suffixIcon: InkWell(
                                      child: Icon(
                                        _confirPasswordVisible
                                            ?  Icons.visibility : Icons.visibility_off ,
                                        color: Colors.grey[500],
                                        size: 15,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _confirPasswordVisible =
                                          !_confirPasswordVisible;
                                        });
                                      }),
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
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
                                    var accountCreation=CreateAccountBvn(
                                        phone: phoneNumber,
                                        email: email,
                                        bvn: bvn,
                                        password: password,
                                        state: state,
                                        middleName: otherNames,
                                        lastName: lastName,
                                        firstName: firstName,
                                        dob: dob,
                                        gender: gender,
                                        title: title,
                                        address: address,
                                        branchId: 1,
                                        deviceId: deviceID,
                                        deviceName: deviceName,
                                        maritalStatus: maritalStatus,
                                        passwordConfirmation: confirmPassword,
                                        selfie: profilePic,
                                        signature: signature
                                    );
                                    createAccountUsingBVN(accountCreation , provider);
                                  },
                                  btnTitle: 'Proceed',
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                              ]),)
                            ],
                          ),
                    ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

