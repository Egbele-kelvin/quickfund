import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/loginResp.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/otpResp.dart';
import 'package:quickfund/data/model/resetPasswordReq.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/provider/settingsProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/form_error.dart';

class ChangePassWord extends StatefulWidget {
  const ChangePassWord({Key key}) : super(key: key);

  @override
  _ChangePassWordState createState() => _ChangePassWordState();
}

class _ChangePassWordState extends State<ChangePassWord> {
  String email,
      _pin,
      oldPassword,
      password,
      confirmPassword,
      phoneNumber,
      responseData;
  TextEditingController transactPin;
  bool _oldPassword, _passwordVisible, _confirPasswordVisible;
  int currentView = 1, selectedIndex;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  final _formKey = GlobalKey<FormState>();

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    _passwordVisible = true;
    _oldPassword = true;
    _confirPasswordVisible = true;
    super.initState();
  }

  bool isLoading = false;
  void responseMessage(BuildContext context, String message, Color color) {
    Flushbar(
      margin: EdgeInsets.symmetric(vertical: 20),
      backgroundColor: color,
      message: message,
      leftBarIndicatorColor: Colors.grey,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void verifyOtp(OtpReq otpReq, OtpProvider otpProvider) async {
    setState(() {
      isLoading = true;
    });
    try {
      await otpProvider.otpVerificationForAll(otpReq);
      if (otpProvider.otpVerificate != null) {
        final otpResp = OtpResp.fromJson(otpProvider.otpVerificate);
        if (otpResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage(context,'$responseData', Colors.green);
          setState(() {
            currentView = 2;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage(context,'$responseData', Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage(context,'Server Auth Error', Colors.red);
    }
  }

  void resetPassWord(
      ResetPassword resetPassword, SettingsProvider settingsProvider) async {
    setState(() {
      isLoading = true;
    });
    try {
      await settingsProvider.resetPassWord(resetPassword);
      if (settingsProvider.changePassword != null) {
        final changePassWordResp =
            LoginResp.fromJson(settingsProvider.changePassword);
        if (changePassWordResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = changePassWordResp.message;
          print('responseMessage : $responseData');
          responseMessage(context,'$responseData', Colors.green);
          Navigator.of(context).pushReplacementNamed(AppRouteName.LOG_IN);
        } else {
          setState(() {
            isLoading = false;
          });
          responseData = changePassWordResp.message;
          print('responseMessage : $responseData');
          responseMessage(context,'$responseData', Colors.red);
        }
      }else{
        setState(() {
          isLoading = false;
        });
        print('responseMessage : $responseData');
        responseMessage(context,'$responseData', Colors.red);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage(context,'Server Auth Error', Colors.red);
    }
  }

  parseAuthData(AuthProvider setupAccountViaBVNandViaPhoneProvider) {
    try {
      if (setupAccountViaBVNandViaPhoneProvider.login != null) {
        final userData =
            LoginResp.fromJson(setupAccountViaBVNandViaPhoneProvider.login);
        setState(() {
          phoneNumber = userData.data.user.phone;
          print('selfie: $phoneNumber');
        });
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer3<AuthProvider, OtpProvider, SettingsProvider>(
        builder: (context, provider, otpProvider, settingProvider, child) {
      parseAuthData(provider);
      return Form(
        key: _formKey,
        child: Column(
          children: [
            Visibility(
              visible: currentView == 1,
              child: Column(
                children: [
                  RoundedInputField(
                    maxLen: 6,
                    passwordvisible: _oldPassword,
                    inputType: TextInputType.visiblePassword,
                    labelText: 'Current Password',
                    hintText: '',
                    autoCorrect: true,
                    onSaved: (newValue) => oldPassword = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        removeError(error: kPinNullError);
                      } else if (value.length >= 4) {
                        removeError(error: kShortPinError);
                      }
                      oldPassword = value;
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
                          _oldPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey[500],
                          size: 15,
                        ),
                        onTap: () {
                          setState(() {
                            _oldPassword = !_oldPassword;
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
                    passwordvisible: _confirPasswordVisible,
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
                      :   CustomSignInButton(
                    size: size,
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        KeyboardUtil.hideKeyboard(context);
                        var verifyOtpParam = OtpReq(phone: phoneNumber);
                        verifyOtp(verifyOtpParam, otpProvider);
                      }
                    },
                    btnTitle: 'Continue',
                  ),
                ],
              ),
            ),
            Visibility(
              visible: currentView == 2,
              child: Column(children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Column(
                  children: [
                    Text(
                      'Enter OTP sent to the $phoneNumber',
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
                  ],
                ),
                SizedBox(
                  height: size.height * 0.15,
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
                    :   CustomSignInButton(
                  size: size,
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      KeyboardUtil.hideKeyboard(context);
                      var resetPasswordParams = ResetPassword(
                          phone: phoneNumber,
                          otp: _pin,
                          passwordConfirmation: confirmPassword,
                          password: password,
                          currentPassword: oldPassword);
                      resetPassWord(resetPasswordParams, settingProvider);
                    }
                  },
                  btnTitle: 'Continue',
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                ResendOTP(
                  textI: 'NO OTP RECEIVED? ',
                  textII: 'TAP HERE TO RESEND IT',
                  onTap: () {
                    var verifyOtpParam = OtpReq(phone: phoneNumber);
                    verifyOtp(verifyOtpParam, otpProvider);
                  },
                ),
              ]),
            ),
          ],
        ),
      );
    });
  }
}
