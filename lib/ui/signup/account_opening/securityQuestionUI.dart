import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/custom_selecet_menu.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';

class SecurityQuestionUI extends StatefulWidget {
  @override
  _SecurityQuestionUIState createState() => _SecurityQuestionUIState();
}

class _SecurityQuestionUIState extends State<SecurityQuestionUI> {
  int currentView = 0;
  String accountNumber = '0897966945';
  bool _passwordVisible , _confirPasswordVisible;
  bool showDataplan = false, showPhoneEdit = false;
  TextEditingController transactPin;
  String _pin, answerToSecurityQuestion;
  List<String> securityQuestion = [
    AppStrings.SecurityQuestionI,
    AppStrings.SecurityQuestionII,
    AppStrings.SecurityQuestionIII,
    AppStrings.SecurityQuestionIV,
    AppStrings.SecurityQuestionV,
    AppStrings.SecurityQuestionVI
  ];
  String title, gender, maritalStatus, stateOO;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String conform_password;
  bool remember = false;
  final List<String> errors = [];

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
                    heading: 'Security Question',
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
                                  title = securityQuestion[index];
                                });

                                Navigator.of(context).pop();
                              },
                              descriptionItem: securityQuestion[index],
                            );
                          },
                          separatorBuilder: (context, index) => Container(),
                          itemCount: securityQuestion.length))
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
  void initState() {
  _passwordVisible = false;
  _confirPasswordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return onBackPress();
      },
      child: Form(
        key: _formKey,
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
                    pageTitle: 'QFMB account no: ${accountNumber}',
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
                    child: Stack(
                      children: [
                        CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(children: [
                                Spacer(
                                  flex: 1,
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                CustomSelectDropdownMenu(
                                  widget: RoundedInputField(
                                    // onSaved: (newValue) => bvn = newValue,
                                    inputType: TextInputType.number,
                                    labelText: 'Enter Security Question',
                                    customTextHintStyle: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    hintText: title,
                                    autoCorrect: true,
                                    hasFocus: AlwaysDisabledFocusNode(),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        buildShowModalBottomSheetForUserTitle(
                                            context, size);
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                RoundedInputField(
                                  // onSaved: (newValue) => bvn = newValue,
                                  onSaved: (newValue) => answerToSecurityQuestion = newValue,
                                  inputType: TextInputType.text,
                                  labelText: 'Enter Answer',
                                  customTextHintStyle: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.black54.withOpacity(0.3),
                                      fontWeight: FontWeight.w600),
                                  hintText: 'Enter your Answer to the Question',
                                  autoCorrect: true,
                                  onChanged: (value){
                                    if (value.isNotEmpty) {
                                      removeError(error: kSecurityNullError);
                                    }
                                    return null;
                                  },

                                  validateForm: (value) {
                                    if (value.isEmpty) {
                                      addError(error: kSecurityNullError);
                                      return "";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                RoundedInputField(
                                  customTextHintStyle: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.black54.withOpacity(0.3),
                                      fontWeight: FontWeight.w600),
                                  // onSaved: (newValue) => bvn = newValue,
                                  inputType: TextInputType.number,
                                  labelText: 'Enter New Pin',
                                  hintText: '*********',
                                  autoCorrect: true,
                                  onSaved: (newValue) => password = newValue,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: kPassNullError);
                                    } else if (value.length >= 8) {
                                      removeError(error: kShortPassError);
                                    }
                                    password = value;
                                  },
                                  validateForm: (value) {
                                    if (value.isEmpty) {
                                      addError(error: kPassNullError);
                                      return "";
                                    } else if (value.length < 8) {
                                      addError(error: kShortPassError);
                                      return "";
                                    }
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
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      }),


                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                RoundedInputField(
                                  customTextHintStyle: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.black54.withOpacity(0.3),
                                      fontWeight: FontWeight.w600),
                                  // onSaved: (newValue) => bvn = newValue,
                                  inputType: TextInputType.number,
                                  labelText: 'Confirm New Pin',
                                  hintText: '**********',
                                  autoCorrect: true,
                                  passwordvisible: _confirPasswordVisible,
                                  onSaved: (newValue) => conform_password = newValue,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: kPassNullError);
                                    } else if (value.isNotEmpty && password == conform_password) {
                                      removeError(error: kMatchPassError);
                                    }
                                    conform_password = value;
                                  },
                                  validateForm: (value) {
                                    if (value.isEmpty) {
                                      addError(error: kPassNullError);
                                      return "";
                                    } else if ((password != value)) {
                                      addError(error: kMatchPassError);
                                      return "";
                                    }
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
                                          _confirPasswordVisible = !_confirPasswordVisible;
                                        });
                                      }),
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Enter OTP',
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60.0, vertical: 15),
                                      child: PinCodeTextField(
                                        controller: transactPin,
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.normal),
                                        obscureText: true,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        enableActiveFill: true,
                                        pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            borderRadius: BorderRadius.circular(10),
                                            fieldHeight: 45,
                                            selectedFillColor:
                                            Colors.grey.withOpacity(0.1),
                                            disabledColor: Colors.white,
                                            selectedColor: Colors.white,
                                            fieldWidth: 45,
                                            activeColor: kPrimaryColor,
                                            inactiveColor:
                                            Colors.grey.withOpacity(0.15),
                                            inactiveFillColor: Colors.white,
                                            activeFillColor: colorPrimaryWhite),
                                        length: 4,
                                        appContext: context,
                                        onChanged: (value) {
                                          setState(() {
                                            _pin = value;
                                          });
                                        },
                                        onCompleted: (value) async {
                                          setState(() {
                                            if (value.isEmpty) {
                                              addError(error: kPinNullError);
                                              return "";
                                            } else if (value.length < 4) {
                                              addError(error: kShortPinError);
                                              return "";
                                            }
                                            return null;
                                          });

                                        },
                                        // validator:(value) {
                                        //   // if (value.isEmpty) {
                                        //   //   addError(error: kPinNullError);
                                        //   //   return "";
                                        //   // } else if (value.length < 4) {
                                        //   //   addError(error: kShortPinError);
                                        //   //   return "";
                                        //   // }
                                        //   // return null;
                                        // } ,
                                      ),
                                    ),
                                  ],
                                ),

                                FormError(errors: errors),

                                SizedBox(
                                  height: size.height *0.02,
                                ),
                                CustomButton(
                                  size: size,
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      KeyboardUtil.hideKeyboard(context);
                                      // if all are valid then go to success screen
                                      Navigator.pushNamed(context, AppRouteName.LOG_IN);
                                    }
                                  },
                                  btnTitle: 'Confirm',
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),

                                ResendOTP(
                                  textI: 'NO OTP RECEIVED? ',
                                  textII:  'TAP HERE TO RESEND IT',
                                  onTap: (){},
                                ),

                                Spacer(flex: 6),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
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