import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/createAccountBvnReq.dart';
import 'package:quickfund/data/model/createAccountBvnResp.dart';
import 'package:quickfund/data/model/listOfState.dart';
import 'package:quickfund/data/model/verifyBvnResp.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/bankStatementWidget.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_search.dart';
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
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final List<String> errors = [];
  final ImagePicker picker = ImagePicker();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  var signature, profilePic;
  SetupAccountViaBVNandViaPhoneProvider authProvider;
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible, _confirPasswordVisible, readOnly = true;

  @override
  void dispose() {
    dateOfBirth.clear();
    firstNameController.clear();
    middleController.clear();
    lastNameController.clear();
    phoneNumberController.clear();

    super.dispose();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void checkIfFLMDNareAllNull() {
    if (firstNameController.text.isEmpty &&
        lastNameController.text.isEmpty &&
        middleController.text.isEmpty &&
        phoneNumberController.text.isEmpty) {
      setState(() {
        readOnly = false;
        firstNameController.clear();
        lastNameController.clear();
        middleController.clear();
        phoneNumberController.clear();
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  _selectDateOfBirth(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePickerForDateOfBirth(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePickerForDateOfBirth(context);
    }
  }

  buildCupertinoDatePickerForDateOfBirth(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SelectDatePickerByFunmi(
            //  maximumDate: DateTime.now(),
            onDateTimeChanged: (picked) {
              if (picked != null) {
                setState(() {
                  dateOfBirth.text = DateFormat('yyyy-MM-dd').format(picked);
                });

                print('date : ${dateOfBirth.text}');
              }
            },
          );
        });
  }

  buildMaterialDatePickerForDateOfBirth(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      cancelText: 'Cancel',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null)
      setState(() {
        dateOfBirth.text = DateFormat('yyyy-MM-dd').format(picked);
        print('issueDate : ${dateOfBirth.text}');
      });
  }

  List<String> genderData = ['Male', 'Female', 'Neuter'];
  String title = 'Title',
      gender = 'Gender',
      responseData = '',
      maritalStatus = 'Marital Status',
      bvn,
      phoneNumber,
      firstName,
      address,
      lastName,
      otherNames,
      dob,
      password,
      confirmPassword,
      email,
      state = 'state of origin';

  bool showDataplan = false, showPhoneEdit = false, isLoading = false;
  List<String> userTitle = ['Mr.', 'Mrs.', 'Miss.'];
  List<String> maritalStatusData = [
    'Single',
    'Married',
    'Widowed',
    'Separated',
    'Divorced'
  ];

  var deviceID, deviceName;

  void getImei() async {
    final deviceInfo = DeviceInfoPlugin();
    phoneNumberController.text =
        await _sharedPreferenceQS.getSharedPrefs(String, 'customPhoneNumber');
    print('username: ${phoneNumberController.text}');
    if (UniversalPlatform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceID = androidInfo.androidId;
      deviceName = androidInfo.brand;
      print('deviceID: $deviceID');
      print('deviceName: $deviceName');
    } else if (UniversalPlatform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor;
      deviceName = iosInfo.name;
      print('deviceID: $deviceID');
      print('deviceName: $deviceName');
    }
  }

  List<StateData> stateList = [];

  @override
  void initState() {
    final postMdl = Provider.of<SetupAccountViaBVNandViaPhoneProvider>(context,
        listen: false);
    postMdl.getListOfState();
    setState(() {
      stateList = postMdl.stateList;
      print('stateListData: ${postMdl.stateList}');
      print('stateListData: $stateList');
    });
    //setState(() {
    // });
    checkIfFLMDNareAllNull();
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
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
      ),
      backgroundColor: color,
    ));
  }

  Future<dynamic> createAccountUsingBVN(dynamic createAccountBvn,
      SetupAccountViaBVNandViaPhoneProvider authProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await authProvider.createAccountViaBvn(createAccountBvn);

      if (authProvider.createAccountUsingBvn != null) {
        final createAccountViaBVNResp =
            CreateAccountBvnResp.fromJson(authProvider.createAccountUsingBvn);
        if (createAccountViaBVNResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = createAccountViaBVNResp.message.toString();
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          Navigator.pushReplacementNamed(
              context, AppRouteName.AccountOpeningUI);
        } else {
          print('trying Data ${createAccountViaBVNResp.error}');
          setState(() {
            isLoading = false;
          });
          responseMessage('${createAccountViaBVNResp.message}', Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // responseMessage('$e', Colors.red);
    }
  }

  void filterSearchResults(String query) {
    final postMdl = Provider.of<SetupAccountViaBVNandViaPhoneProvider>(context,
        listen: false);
    //setState(() {
    if (query.isNotEmpty) {
      stateList = postMdl.stateList;
      print('filteredList: ${stateList.toList()}');
      stateList = postMdl.stateList
          .where((i) => i.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      stateList = stateList = postMdl.stateList;
    }
    print('filter ${stateList.toString()}');
    //});
  }

  parseAuthData(authProvider) {
    try {
      if (authProvider.verifyBvnOtp != null) {
        final userData = VerifyBvnResp.fromJson(authProvider.verifyBvnOtp);
        firstNameController.text = userData.data.firstName.toLowerCase();
        lastNameController.text = userData.data.lastName.toLowerCase();
        phoneNumberController.text = userData.data.phoneNumber.toLowerCase();
        middleController.text = userData.data.otherNames.toLowerCase();
        dateOfBirth.text = userData.data.dob.toLowerCase();
        bvn = userData.data.bvn.toLowerCase();
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  _imgFromCamera() async {
    PickedFile image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(image.path);
      print(_image);
      var bytes = File(image.path).readAsBytesSync();
      profilePic = base64.encode(bytes);
      print('profile pic ------ $profilePic');
    });
  }

  _imageFromGallery() async {
    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(image.path);
      print('_image; $_image');

      var imageBytes = File(image.path).readAsBytesSync();
      profilePic = base64.encode(imageBytes);
      print('profile pic ------ $profilePic \n\n');
    });
  }

  _imgFromCameraForSignature() async {
    PickedFile image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _signImage = File(image.path);
      print(_signImage);
      var bytes = File(image.path).readAsBytesSync();
      signature = base64.encode(bytes);
      print('signature ------ $signature');
    });
  }

  _imageFromGalleryForSignature() async {
    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _signImage = File(image.path);
      print(_signImage);
      var bytes = File(image.path).readAsBytesSync();
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

  Future<dynamic> buildShowModalBottomSheetForListOfState(
      BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.black.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        enableDrag: true,
        builder: (context) {
          return Container(
            height: size.height * 0.8,
            child: Column(
              children: [
                stateList.isEmpty
                    ? Container()
                    : CustomDetails(
                        heading: 'List Of State',
                      ),
                stateList == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 10),
                        child: SearchBoxWidget(
                          searchController: searchController,
                          onChanged: (val) => filterSearchResults(val),
                        ),
                      ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Expanded(
                    child: stateList.isEmpty
                        ? Center(
                            child: Text(
                              'List of State is not Available at the moment!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 21,
                                  color: Colors.black),
                            ),
                          )
                        : ListView(
                            shrinkWrap: true,
                            children: stateList
                                .asMap()
                                .entries
                                .map((e) => CustomItemWidget(
                                    onTap: () {
                                      setState(() {
                                        state = e.value.name;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    descriptionItem: e.value.name))
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
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Consumer<SetupAccountViaBVNandViaPhoneProvider>(
      builder: (context, provider, child) {
        parseAuthData(provider);
        return WillPopScope(
          onWillPop: () {
            return onBackPress();
          },
          child: Form(
            key: _formKey,
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
                          pageTitle: 'Setup Account',
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
                                  child: Column(children: [
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
                                      readOnly: firstNameController.text.isEmpty
                                          ? false
                                          : readOnly,
                                      controller: firstNameController,
                                      inputType: TextInputType.text,
                                      labelText: 'First Name',
                                      autoCorrect: true,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    RoundedInputField(
                                      readOnly: readOnly,
                                      controller: middleController,
                                      inputType: TextInputType.text,
                                      labelText: 'Middle Name',
                                      autoCorrect: true,
                                      onChanged: (val) {
                                        setState(() {
                                          otherNames = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    RoundedInputField(
                                      readOnly: readOnly,
                                      controller: lastNameController,
                                      inputType: TextInputType.text,
                                      labelText: 'Last Name',
                                      autoCorrect: true,
                                      onChanged: (val) {
                                        setState(() {
                                          lastName = val;
                                        });
                                      },
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
                                      readOnly: true,
                                      onTap: () {
                                        _selectDateOfBirth(context);
                                      },
                                      controller: dateOfBirth,
                                      //hasFocus: AlwaysDisabledFocusNode(),
                                      suffixIcon: Icon(
                                        Icons.calendar_today_outlined,
                                        color: Colors.grey.withOpacity(0.5),
                                        size: 20,
                                      ),
                                      inputType: TextInputType.datetime,
                                      labelText: 'Birth Date',
                                      hintText: dob == null
                                          ? 'e.g 11-june-1997'
                                          : '$dob',
                                      autoCorrect: true,
                                      onChanged: (val) {
                                        setState(() {
                                          dob = val;
                                        });
                                      },
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
                                          removeError(
                                              error:
                                                  'Email Address is required');
                                        } else if (value.isNotEmpty) {
                                          removeError(
                                              error:
                                                  'Email Address is required');
                                        }
                                        email = value;
                                      },
                                      validateForm: (value) {
                                        if (value.isEmpty) {
                                          addError(
                                              error:
                                                  'Email Address is required');
                                          return "";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    RoundedInputField(
                                      controller: phoneNumberController,
                                      readOnly: true,
                                      inputType: TextInputType.number,
                                      labelText: 'Phone Number',
                                      maxLen: 11,
                                      autoCorrect: true,
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
                                          removeError(
                                              error: 'Address is required');
                                        } else if (value.isNotEmpty) {
                                          removeError(
                                              error: 'Address is required');
                                        }
                                        address = value;
                                      },
                                      validateForm: (value) {
                                        if (value.isEmpty) {
                                          addError(
                                              error: 'Address is required');
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
                                      onTap: () {
                                        buildShowModalBottomSheetForListOfState(
                                            context, size);
                                      },
                                      readOnly: true,
                                      customTextHintStyle: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      onSaved: (newValue) => state = newValue,
                                      inputType: TextInputType.text,
                                      // labelText: 'State of Origin',
                                      hintText: '$state',
                                      autoCorrect: true,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.06,
                                    ),
                                    CustomSignInButton(
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
                                          color:
                                              Colors.black54.withOpacity(0.3),
                                          fontWeight: FontWeight.w600),
                                      // onSaved: (newValue) => bvn = newValue,
                                      inputType: TextInputType.visiblePassword,
                                      labelText: 'Password',
                                      hintText: '*********',
                                      autoCorrect: true,
                                      onSaved: (newValue) =>
                                          password = newValue,
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
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey[500],
                                            size: 15,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          }),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    RoundedInputField(
                                      customTextHintStyle: GoogleFonts.lato(
                                          fontSize: 12,
                                          color:
                                              Colors.black54.withOpacity(0.3),
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
                                                ? Icons.visibility
                                                : Icons.visibility_off,
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
                                        ProfilePicAndSignature(
                                          size: size,
                                          image: _image,
                                          imgURL: 'assets/f_png/cameraPic.png',
                                          tag: 'Take Selfie',
                                          onTap: () {
                                            _showPicker(context);
                                          },
                                        ),
                                        ProfilePicAndSignature(
                                          size: size,
                                          image: _signImage,
                                          tag: 'Upload signature',
                                          imgURL: 'assets/f_png/signature.png',
                                          onTap: () {
                                            _showPickerSign(context);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),
                                    CustomSignInButton(
                                      size: size,
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();

                                          KeyboardUtil.hideKeyboard(context);
                                          var accountCreation =
                                              CreateAccountBvn(
                                                  phone: phoneNumberController
                                                      .text,
                                                  email: email,
                                                  bvn: bvn == null ? '' : bvn,
                                                  password: password,
                                                  state: state,
                                                  middleName:
                                                      middleController.text,
                                                  lastName:
                                                      lastNameController.text,
                                                  firstName:
                                                      firstNameController.text,
                                                  dob: dateOfBirth.text,
                                                  gender: gender,
                                                  title: title,
                                                  address: address,
                                                  branchId: 1,
                                                  deviceId: deviceID,
                                                  deviceName: deviceName,
                                                  maritalStatus: maritalStatus,
                                                  passwordConfirmation:
                                                      confirmPassword,
                                                  selfie: profilePic,
                                                  signature: signature);
                                          createAccountUsingBVN(
                                              accountCreation, provider);
                                        }
                                      },
                                      btnTitle: 'Proceed',
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                  ]),
                                )
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
          ),
        );
      },
    );
  }
}
