import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/customFile_container.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/custom_selecet_menu.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUI extends StatefulWidget {
  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  int currentView = 0;
  String accountNumber = '0897966945';
  bool _passwordVisible, _confirPasswordVisible;
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
    _passwordVisible = true;
    _confirPasswordVisible = true;
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
      //  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    pageTitle: 'Register',
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
                        Visibility(
                          visible: currentView==0,
                          child: CustomScrollView(
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
                                  Text(
                                    AppStrings.registerLetterHeader,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
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
                                    labelText: 'Pin',
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
                                    labelText: 'Confirm Pin',
                                    maxLen: 6,
                                    hintText: '**********',
                                    autoCorrect: true,
                                    passwordvisible: _confirPasswordVisible,
                                    onSaved: (newValue) =>
                                        conform_password = newValue,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        removeError(error: kPassNullError);
                                      } else if (value.isNotEmpty &&
                                          password == conform_password) {
                                        removeError(error: kMatchPassError);
                                      }
                                      conform_password = value;
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
                                  FormError(errors: errors),
                                  SizedBox(
                                    height: size.height * 0.06,
                                  ),
                                  CustomButton(
                                    size: size,
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        KeyboardUtil.hideKeyboard(context);

                                        setState(() {
                                          currentView = 1;
                                        });
                                      }
                                    },
                                    btnTitle: 'Continue',
                                  ),
                                  Spacer(flex: 6),
                                ]),
                              ),
                            ],
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
                                      height: size.height * 0.04,
                                    ),

                                    Column(
                                      children: [
                                        Text(
                                          'Please enter the OTP we sent to you.',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height *0.02,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50.0, vertical: 15),
                                          child: PinCodeTextField(
                                            controller: transactPin,
                                            textStyle: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400),
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

                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),
                                    CustomButton(
                                      size: size,
                                      onTap: () {
                                        KeyboardUtil.hideKeyboard(context);

                                        // if all are valid then go to success screen
                                        Navigator.pushNamed(
                                            context, AppRouteName.LOG_IN);
                                      },
                                      btnTitle: 'Continue',
                                    ),

                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),

                                    ResendOTP(
                                      textI: 'NO OTP RECEIVED? ',
                                      textII:  'TAP HERE TO RESEND IT',
                                      onTap: (){},
                                    ),

                                  ]),
                                ),
                              ],
                            )),
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
