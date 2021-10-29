import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/otpResp.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/provider/securityQuestionProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/form_error.dart';

import 'forgotpassII.dart';

class ForgotPasswordUI extends StatefulWidget {
  @override
  _ForgotPasswordUIState createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  int currentView = 0,
      selectedIndex;
  String password, phoneNum, answer, responseData;
  bool _passwordVisible,
      _answer,
      _confirmPasswordVisible,
      isLoading = false;
  String confirmPassword;
  bool showDataplan = false,
      showPhoneEdit = false,
      _btnEnabled = false;
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  TextEditingController transactPin;
  String _pin, answerToSecurityQuestion;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();



  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        if (showDataplan) {
          showDataplan = false;
        } else if (currentView == 1) {
          //  isEnabled = true;
          currentView = 0;
        }
      });
      print('printght' + currentView.toString());
    }
  }

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

  void verifyOtp(OtpReq otpReq, OtpProvider otpProvider) async {
    setState(() {
      isLoading = true;
    });
    try {
      await otpProvider.otpVerificationForAll(otpReq);
      if (otpProvider.otpVerificate != null) {
        final otpResp =
        OtpResp.fromJson(otpProvider.otpVerificate);
        if (otpResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          setState(() {
            currentView = 1;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          responseData = otpResp.message;
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery
        .of(context)
        .size;
    return Consumer<OtpProvider>(
        builder: (context, provider, child) {
          return LoadingOverlay(
              isLoading: isLoading,
              child: WillPopScope(
                onWillPop: () {
                  return onBackPress();
                },
                child: Scaffold(
                  key: scaffoldKey,
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
                              child:SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child:  Column(
                                  children: [
                                    Visibility(
                                      visible: currentView == 0,
                                      child: Column(children: [
                                        SizedBox(height:size.height* 0.1,),
                                        Text(
                                          'Please provide your phone number to get you started',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                          ),),
                                        SizedBox(
                                          height: size.height * 0.05,
                                        ),
                                        RoundedInputField(
                                          onSaved: (newValue) =>
                                          phoneNum = newValue,
                                          inputType: TextInputType.phone,
                                          maxLen: 11,
                                          labelText: 'Phone Number',
                                          hintText: 'e.g 09024585850',
                                          autoCorrect: true,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              removeError(
                                                  error: kPhoneNumberNullError);
                                            } else if (value.length >= 11) {
                                              removeError(
                                                  error: kShortPhoneNumberError);
                                            }
                                            return null;
                                          },
                                          validateForm: (value) {
                                            if (value.isEmpty) {
                                              addError(
                                                  error: kPhoneNumberNullError);
                                              return "";
                                            } else if (value.length < 11) {
                                              addError(
                                                  error: kShortPhoneNumberError);
                                              return "";
                                            }
                                            return null;
                                          },
                                        ),

                                        SizedBox(height: size.height * 0.2,),
                                        CustomSignInButton(
                                          size: size,
                                          onTap: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
                                              KeyboardUtil.hideKeyboard(
                                                  context);
                                              var verifyParams = OtpReq(
                                                  phone: phoneNum);
                                              verifyOtp(
                                                  verifyParams, provider);
                                            }
                                          },
                                          btnTitle: 'Continue',
                                        ),
                                      ]),
                                    ),
                                    Visibility(
                                      visible: currentView == 1,
                                      child: ForgotPassII(phoneNumber: phoneNum,),
                                    ),
                                  ],
                                ),
                              )
                            )),
                      )
                    ]),
                  ),
                ),
              )
          );
        }
    );
  }
}
