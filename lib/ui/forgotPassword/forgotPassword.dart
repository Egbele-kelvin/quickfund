import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:quickfund/widget/transactionPinUI.dart';

class ForgotPasswordUI extends StatefulWidget {
  @override
  _ForgotPasswordUIState createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  int currentView = 0, selectedIndex;
  String password, phoneNum, answer;
  bool _passwordVisible, _answer, _confirPasswordVisible;
  String conform_password;
  List<String> airtimeProvider = ['Airtel', 'MTN', 'GLO', '9Mobile'];
  bool showDataplan = false, showPhoneEdit = false, _btnEnabled = false;
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  TextEditingController transactPin;
  String _pin, answerToSecurityQuestion;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    print(tfDate);
    _passwordVisible = true;
    _answer = true;
    _confirPasswordVisible = true;
    super.initState();
  }

  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 0) {
       Navigator.pop(context);
      //Navigator.pushReplacementNamed(context, AppRouteName.DASHBOARD);
    } else {
      setState(() {
        if (showDataplan) {
          showDataplan = false;
        } else if (currentView == 1) {
          //  isEnabled = true;
          currentView = 0;
        } else if (currentView == 2) {
          // isEnabled = false;
          currentView = 1;
        }
      });
      print('printght' + currentView.toString());
    }
  }

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return onBackPress();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColor,
        body: Form(
          key: _formKey,
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Container(
                //color: kPrimaryColor,
                child: CustomAppBar(
                  onTap: () {
                    onBackPress();
                  },
                  pageTitle: 'Forgot Password',
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
                      vertical: getProportionateScreenHeight(10),
                    ),
                    child: CustomScrollView(slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Visibility(
                              visible: currentView == 0,
                              child: Column(children: [
                                Text(
                                  'Please provide your phone number to get you started',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black
                                ),),
                                SizedBox(
                                  height: size.height *0.05,
                                ),
                                RoundedInputField(
                                  // onSaved: (newValue) => bvn = newValue,
                                  onSaved: (newValue) => phoneNum = newValue,
                                  inputType: TextInputType.number,
                                  maxLen: 11,
                                  labelText: 'Phone Number',
                                  customTextHintStyle: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.black54.withOpacity(0.3),
                                      fontWeight: FontWeight.w600),
                                  hintText: 'Phone Number',
                                  autoCorrect: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: kPhoneNumberNullError);
                                    } else if (value.length >= 11) {
                                      removeError(
                                          error: kShortPhoneNumberError);
                                    }
                                    return null;
                                  },

                                  validateForm: (value) {
                                    if (value.isEmpty) {
                                      addError(error: kPhoneNumberNullError);
                                      return "";
                                    } else if (value.length < 11) {
                                      addError(error: kShortPhoneNumberError);
                                      return "";
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: size.height*0.2,),
                                CustomSignInButton(
                                  size: size,
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      // if all are valid then go to success screen
                                      KeyboardUtil.hideKeyboard(context);
                                      // Navigator.pushReplacementNamed(
                                      //     context, AppRouteName.DASHBOARD);

                                      setState(() {
                                        currentView = 1;
                                      });
                                    }
                                  },
                                  btnTitle: 'Continue',
                                ),
                              ]),
                            ),
                            Visibility(
                              visible: currentView == 1,
                              child: Column(
                                children: [
                                  Text('Kindly enter the OTP sent to +23490694930' , style: GoogleFonts.poppins(
                                    fontSize:11,
                                    fontWeight:FontWeight.w400,
                                    color:Colors.black,
                                  ),),
                                  SizedBox(height:size.height *0.05),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
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
                                    ),
                                  ),

                                  SizedBox(height: size.height *0.1,),
                                  CustomSignInButton(
                                    size: size,
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        // if all are valid then go to success screen
                                        KeyboardUtil.hideKeyboard(context);
                                        // Navigator.pushReplacementNamed(
                                        //     context, AppRouteName.DASHBOARD);

                                        setState(() {
                                          currentView = 2;
                                        });
                                      }
                                    },
                                    btnTitle: 'Continue',
                                  ),

                                  SizedBox(
                                    height: size.height*0.07,
                                  ),

                              GestureDetector(
                                onTap: (){},
                                child: RichText(
                                  text: TextSpan(
                                    text: 'No OTP Received ? ',
                                    style: GoogleFonts.robotoMono(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Tap here to resend it'.toUpperCase(),
                                          style: GoogleFonts.robotoMono(
                                            fontSize: 10,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w500
                                          ))
                                    ],
                                  ),
                                ),
                              )
                                ],
                              )
                            ),
                            Visibility(
                              visible: currentView == 2,
                              child:Column(
                                children: [
                                  Text('Please answer the question and enter your pin', style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 12
                                  ),),

                                  SizedBox(height: size.height *0.05,),
                                  RoundedInputField(
                                    // onSaved: (newValue) => bvn = newValue,
                                    customTextHintStyle: GoogleFonts.lato(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    inputType: TextInputType.number,
                                    labelText: 'First Name',
                                    hintText: 'What is the name of your girl friend??',
                                    autoCorrect: true,
                                    hasFocus: AlwaysDisabledFocusNode(),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  RoundedInputField(
                                    passwordvisible: _answer,
                                    customTextHintStyle: GoogleFonts.lato(
                                        fontSize: 12,
                                        color: Colors.black54.withOpacity(0.3),
                                        fontWeight: FontWeight.w600),
                                    // onSaved: (newValue) => bvn = newValue,
                                    inputType: TextInputType.visiblePassword,
                                    labelText: 'Enter Answer',
                                    hintText: '',
                                    autoCorrect: true,
                                    onSaved: (newValue) => answer = newValue,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        removeError(error: kPinNullError);
                                      } else if (value.length >= 4) {
                                        removeError(error: kShortPinError);
                                      }
                                      answer = value;
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
                                          _answer ? Icons.visibility : Icons.visibility_off,
                                          color: Colors.grey[500],
                                          size: 15,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _answer = !_passwordVisible;
                                          });
                                        }),
                                  ),
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

                                        Navigator.pushReplacementNamed(context, AppRouteName.LOG_IN);
                                        // setState(() {
                                        //   currentView = 1;
                                        // });
                                      }
                                    },
                                    btnTitle: 'Continue',
                                  ),
                                ],
                              ),
                            ),
                            Spacer(
                              flex: 8,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
