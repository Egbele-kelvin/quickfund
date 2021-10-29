import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/completeOnBoardOldCustomerReq.dart';
import 'package:quickfund/data/model/createAccountBvnResp.dart';
import 'package:quickfund/data/model/initiateOnBoardOldCustomerResp.dart';
import 'package:quickfund/data/model/initiateOnboardOldCustomer.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/otpResp.dart';
import 'package:quickfund/data/model/verifyOtpReq.dart';
import 'package:quickfund/data/model/verifyOtpResp.dart';
import 'package:quickfund/provider/otpProvider.dart';
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
import 'package:universal_platform/universal_platform.dart';

class RegisterUI extends StatefulWidget {
  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  OtpProvider _otpProvider;
  int currentView = 0;
  String  _pin , phoneNumber, password, confirmPassword,responseData;
  bool _passwordVisible=false, _confirmPasswordVisible=false, showDataplan = false, showPhoneEdit = false,isLoading = false;
  TextEditingController transactPin;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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

  void initiateOnBoardOldCustomer(
      InitiateOnBoardOldCustomer initiateOnBoardOldCustomer, OtpProvider otpProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await otpProvider.initiateOnBoardOldCustomer(initiateOnBoardOldCustomer);
      if (otpProvider.initiateOnBoardOldC != null) {
        final initiateOnBoardOldCustomerResp =
        InitiateOnBoardOldCustomerResp.fromJson(otpProvider.initiateOnBoardOldC);
        if (initiateOnBoardOldCustomerResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = initiateOnBoardOldCustomerResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
         setState(() {
           currentView=1;
         });
        } else{
          setState(() {
            isLoading=false;
          });
          responseData = initiateOnBoardOldCustomerResp.message;
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

  void verifyOtpSent(
      VerifyOtpReq verifyOtpReq, OtpProvider otpProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await otpProvider.verifyOtpSent(verifyOtpReq);
      if (otpProvider.verifySentOtp != null) {
        final verifySentOtpResp =
        VerifyOtpResp.fromJson(otpProvider.verifySentOtp);
        if (verifySentOtpResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = verifySentOtpResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          await completeOnBoarding();
        } else{
          setState(() {
            isLoading=false;
          });
          responseData = verifySentOtpResp.message;
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

  void completeOnBoardOldCustomer(
      CompleteOnBoardOldCustomerReq completeOnBoardOldCustomerReq, OtpProvider otpProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await otpProvider.completeOnBoardOldCustomerReq(completeOnBoardOldCustomerReq);
      if (otpProvider.completeOnBoardOldC != null) {
        final initiateOnBoardOldCustomerResp =
        CreateAccountBvnResp.fromJson(otpProvider.completeOnBoardOldC);
        if (initiateOnBoardOldCustomerResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = initiateOnBoardOldCustomerResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          await otpVerify();
        } else{
          setState(() {
            isLoading=false;
          });
          responseData = initiateOnBoardOldCustomerResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      }
      else{
        setState(() {
          isLoading=false;
        });
        print('responseMessage : $responseData');
        responseMessage('$responseData', Colors.red);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage('Server Auth Error', Colors.red);
    }
  }

  void verifyOtp(
      OtpReq otpReq, OtpProvider otpProvider) async {
    setState(() {
      print('printing Loader');
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
          Navigator.pushReplacementNamed(
              context, AppRouteName.SecurityQuestionUI);
        } else{
          setState(() {
            isLoading=false;
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


   completeOnBoarding()async{
    print('password: $password');
    print('confirmPassword: $confirmPassword');
    var completeParams= CompleteOnBoardOldCustomerReq(
      phone: phoneNumber,
      password: password,
      deviceName: deviceName,
      passwordConfirmation: confirmPassword,
      deviceId: deviceID
    );
    completeOnBoardOldCustomer(completeParams ,_otpProvider );
  }
   otpVerify()async{
     var verifyParams = OtpReq(phone: phoneNumber);
     verifyOtp(verifyParams, _otpProvider);
  }

  @override
  void initState() {
    _passwordVisible = true;
    _confirmPasswordVisible = true;
     getImei();
    super.initState();
  }
  var deviceID, deviceName;

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
      deviceName = iosInfo.name;
      print('deviceID: $deviceID');
      print('deviceName: $deviceName');
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Consumer<OtpProvider>(
        builder: (context, provider , child) {
          _otpProvider=provider;
       return LoadingOverlay(
         isLoading: isLoading,
         child: WillPopScope(
              onWillPop: () {
                return onBackPress();
              },
              child: Form(
                key: _formKey,
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
                                  visible: currentView == 0,
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverFillRemaining(
                                        hasScrollBody: false,
                                        child: Column(children: [
                                          Spacer(
                                            flex: 1,
                                          ),
                                          RoundedInputField(
                                            onSaved: (newValue) =>
                                            phoneNumber = newValue,
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
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          RoundedInputField(
                                            maxLen: 6,
                                            passwordvisible: _passwordVisible,
                                            inputType: TextInputType
                                                .visiblePassword,
                                            labelText: 'Password',
                                            hintText: '*********',
                                            autoCorrect: true,
                                            onSaved: (newValue) =>
                                            password = newValue,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                removeError(
                                                    error: kPassNullError);
                                              } else if (value.length >= 6) {
                                                removeError(
                                                    error: kShortPassError);
                                              }
                                              password = value;
                                            },
                                            validateForm: (value) {
                                              setState(() {
                                                if (value.isEmpty) {
                                                  addError(error: kPassNullError);
                                                  return "";
                                                } else if (value.length < 6) {
                                                  addError(
                                                      error: kShortPassError);
                                                  return "";
                                                }
                                              });

                                              return null;
                                            },
                                            suffixIcon: InkWell(
                                                child: Icon(
                                                  _passwordVisible ? Icons
                                                      .visibility : Icons
                                                      .visibility_off,
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
                                            inputType: TextInputType
                                                .visiblePassword,
                                            labelText: 'Confirm Password',
                                            maxLen: 6,
                                            hintText: '**********',
                                            autoCorrect: true,
                                            passwordvisible: _confirmPasswordVisible,
                                            onSaved: (newValue) =>
                                            confirmPassword = newValue,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                removeError(
                                                    error: kPassNullError);
                                              } else if (value.isNotEmpty &&
                                                  password == confirmPassword) {
                                                removeError(
                                                    error: kMatchPassError);
                                              }
                                              confirmPassword = value;
                                            },
                                            validateForm: (value) {
                                              setState(() {
                                                if (value.isEmpty) {
                                                  addError(error: kPassNullError);
                                                  return "";
                                                } else if ((password != value)) {
                                                  addError(
                                                      error: kMatchPassError);
                                                  return "";
                                                }
                                              });

                                              return null;
                                            },
                                            suffixIcon: InkWell(
                                                child: Icon(
                                                  _confirmPasswordVisible
                                                      ? Icons.visibility : Icons
                                                      .visibility_off,
                                                  color: Colors.grey[500],
                                                  size: 15,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _confirmPasswordVisible =
                                                    !_confirmPasswordVisible;
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
                                          CustomSignInButton(
                                            size: size,
                                            onTap: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                KeyboardUtil.hideKeyboard(
                                                    context);

                                                var initiateNumberParams=InitiateOnBoardOldCustomer(
                                                  phone: phoneNumber
                                                );
                                                initiateOnBoardOldCustomer(initiateNumberParams,provider);
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 50.0,
                                                        vertical: 15),
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
                                                            addError(
                                                                error: kPinNullError);
                                                            return "";
                                                          } else
                                                          if (value.length < 4) {
                                                            addError(
                                                                error: kShortPinError);
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
                                            CustomSignInButton(
                                              size: size,
                                              onTap: () {
                                                KeyboardUtil.hideKeyboard(
                                                    context);
                                                // Navigator.pushNamed(
                                                //     context, AppRouteName.LOG_IN);

                                                var verifyOtpSentParam=VerifyOtpReq(
                                                  phone: phoneNumber,
                                                  otp: _pin
                                                );
                                                verifyOtpSent(verifyOtpSentParam, provider);
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

                                                var initiateNumberParams=InitiateOnBoardOldCustomer(
                                                    phone: phoneNumber
                                                );
                                                initiateOnBoardOldCustomer(initiateNumberParams,provider);
                                              },
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
            ),
       );
        });
  }
}
