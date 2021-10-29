import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/forgotPasswordReq.dart';
import 'package:quickfund/data/model/listOfSecurityQuestionResp.dart';
import 'package:quickfund/data/model/loginResp.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/securityQuestionProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/form_error.dart';

import 'forgetPassParams.dart';

class ForgotPassII extends StatefulWidget {
  final String phoneNumber;

  const ForgotPassII({Key key, this.phoneNumber}) : super(key: key);

  @override
  _ForgotPassIIState createState() => _ForgotPassIIState();
}

class _ForgotPassIIState extends State<ForgotPassII> {
  String password,
      phoneNum,
      answer1,
      answer2,
      idQuestion1,
      idQuestion2,
      responseData,
      confirmPassword,
      _pin;
  bool _passwordVisible,
      _answer,
      _confirmPasswordVisible,
      isLoading = false,
      showDataplan = false,
      showPhoneEdit = false;
  TextEditingController transactPin;
  TextEditingController question1 = TextEditingController();
  TextEditingController question2 = TextEditingController();
  int currentView = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  List<ListedQuestionData> securityQuestionList = [];

  Future<dynamic> buildShowModalBottomSheetForQuestion1(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
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
          final postMdl =
              Provider.of<SecurityQuestionProvider>(context, listen: false);
          postMdl.getListOfSecurityQuestion();

          var size = MediaQuery.of(context).size;
          return QuestionListedOut(
            size: size,
            postMdl: postMdl,
            question1: question1,
            idQuestion1: idQuestion1,
          );
        });
  }

  Future<dynamic> buildShowModalBottomSheetForQuestion2(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
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
          final postMdl =
              Provider.of<SecurityQuestionProvider>(context, listen: false);
          postMdl.getListOfSecurityQuestion();

          var size = MediaQuery.of(context).size;
          return QuestionListedOut2(
            size: size,
            postMdl: postMdl,
            question2: question2,
            idQuestion2: idQuestion2,
          );
        });
  }

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

  @override
  void initState() {
    setState(() {
      phoneNum = widget.phoneNumber;
    });
    _passwordVisible = true;
    _answer = true;
    _confirmPasswordVisible = true;
    super.initState();
  }

  void responseMessage(BuildContext context, String message, Color color) {
    Flushbar(
      margin: EdgeInsets.symmetric(vertical: 20),
      backgroundColor: color,
      message: message,
      leftBarIndicatorColor: Colors.grey,
      duration: Duration(seconds: 3),
    )..show(context);
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

  void forgotPassword(
      ForgotPasswordReq forgotPasswordReq, AuthProvider authProvider) async {
    try {
      setState(() {
        print('printing Loader');
        isLoading = true;
        print('isLoading $isLoading');
      });
      await authProvider.forgotPassword(forgotPasswordReq);
      if (authProvider.forgot != null) {
        final loginResp = LoginResp.fromJson(authProvider.forgot);
        if (loginResp.status == true) {
          setState(() {
            responseData = loginResp.message;
            isLoading = false;
          });
          Navigator.of(context).pushReplacementNamed(AppRouteName.LOG_IN);
        } else {
          responseData = loginResp.message;
          print('responseMessage : $responseData');
          setState(() {
            isLoading = false;
          });
          responseMessage(context, '${loginResp.message}', Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage(context, '$responseData', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            Visibility(
              visible: currentView == 0,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    'Enter OTP sent to the $phoneNum',
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 15),
                      child: OTPClassWidget(
                        transactPin: transactPin,
                        onChanged: (value) {
                          setState(() {
                            _pin = value;
                          });
                        },
                        onComplete: (value) async {
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
                      )),
                  SizedBox(
                    height: size.height * 0.15,
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
                    height: size.height * 0.04,
                  ),
                  ResendOTP(
                    textI: 'NO OTP RECEIVED? ',
                    textII: 'TAP HERE TO RESEND IT',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Visibility(
              visible: currentView == 1,
              child: Column(
                children: [
                  Text(
                    'Please answer the question and enter your pin',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  RoundedInputField(
                    controller: question1,
                    onTap: () {
                      buildShowModalBottomSheetForQuestion1(context);
                    },
                    readOnly: true,
                    labelText: 'Question One',
                    hintText: 'What is the name of your girl friend??',
                    autoCorrect: true,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  RoundedInputField(
                    passwordvisible: _answer,
                    inputType: TextInputType.visiblePassword,
                    labelText: 'Answer To Question One',
                    hintText: '',
                    autoCorrect: true,
                    onSaved: (newValue) => answer1 = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        removeError(error: kPinNullError);
                      } else if (value.length >= 4) {
                        removeError(error: kShortPinError);
                      }
                      answer1 = value;
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
                    readOnly: true,
                    controller: question2,
                    onTap: () => buildShowModalBottomSheetForQuestion2(context),
                    inputType: TextInputType.number,
                    labelText: 'Question Two',
                    hintText: 'What is the name of your mom?',
                    autoCorrect: true,
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
                    labelText: 'Answer To Question Two',
                    hintText: '',
                    autoCorrect: true,
                    onSaved: (newValue) => answer2 = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        removeError(error: kPinNullError);
                      } else if (value.length >= 4) {
                        removeError(error: kShortPinError);
                      }
                      answer2 = value;
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
                    inputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    hintText: '*********',
                    autoCorrect: true,
                    onSaved: (newValue) => password = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        removeError(error: kPassNullError);
                      } else if (value.length >= 6) {
                        removeError(error: kShortPassError);
                      }
                      password = value;
                    },
                    validateForm: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          addError(error: kPassNullError);
                          return "";
                        } else if (value.length < 6) {
                          addError(error: kShortPassError);
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
                            _passwordVisible = !_passwordVisible;
                          });
                        }),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedInputField(
                    inputType: TextInputType.visiblePassword,
                    labelText: 'Confirm Password',
                    maxLen: 6,
                    hintText: '**********',
                    autoCorrect: true,
                    passwordvisible: _confirmPasswordVisible,
                    onSaved: (newValue) => confirmPassword = newValue,
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
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey[500],
                          size: 15,
                        ),
                        onTap: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
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
                  isLoading
                      ? SpinKitThreeBounce(
                          size: 30,
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kPrimaryColor,
                              ),
                            );
                          },
                        )
                      : CustomSignInButton(
                          size: size,
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              KeyboardUtil.hideKeyboard(context);

                              var forgotPassWordParams = ForgotPasswordReq(
                                  password: password,
                                  passwordConfirmation: confirmPassword,
                                  phone: phoneNum,
                                  otp: _pin,
                                  answer1: answer1,
                                  answer2: answer2,
                                  quest1: idQuestion1,
                                  quest2: idQuestion2);
                              forgotPassword(
                                  forgotPassWordParams, authProvider);
                            }
                          },
                          btnTitle: 'Continue',
                        ),
                  SizedBox(
                    height: size.height * 0.25,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
