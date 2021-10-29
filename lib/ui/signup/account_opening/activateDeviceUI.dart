import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/activateDeviceReq.dart';
import 'package:quickfund/data/model/activateDeviceResp.dart';
import 'package:quickfund/data/model/loginResp.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/otpResp.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:toast/toast.dart';

import 'accountOpeningWidget.dart';

class ActivateDevice extends StatefulWidget {
  final phoneNumber;
  final passWord;

  const ActivateDevice({Key key, this.phoneNumber, this.passWord})
      : super(key: key);

  @override
  _ActivateDeviceState createState() => _ActivateDeviceState();
}

class _ActivateDeviceState extends State<ActivateDevice> {
  TextEditingController transactPin = TextEditingController();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  String _pin, responseData;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String phoneNumber, deviceId, deviceName, password;

  getSignInDetails() async {
    phoneNumber =
        await _sharedPreferenceQS.getSharedPrefs(String, 'phoneNumber') ?? '';
    deviceId =
        await _sharedPreferenceQS.getSharedPrefs(String, 'deviceId') ?? '';
    deviceName =
        await _sharedPreferenceQS.getSharedPrefs(String, 'deviceName') ?? '';
    password =
        await _sharedPreferenceQS.getSharedPrefs(String, 'password') ?? '';
    print('phoneNumber: $phoneNumber');
    print('phoneNumber: $deviceId');
    print('phoneNumber: $deviceName');
    print('phoneNumber: $password');
  }

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

  void responseMessage(BuildContext context, String message, Color color) {
    Flushbar(
      margin: EdgeInsets.symmetric(vertical: 20),
      backgroundColor: color,
      message: message,
      leftBarIndicatorColor: Colors.grey,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  OtpProvider otpProvider;

  @override
  void initState() {
    getSignInDetails();
    // TODO: implement initState
    super.initState();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context,
        duration: duration,
        gravity: gravity,
        backgroundRadius: 20.0,
        textColor: Colors.white60);
  }

  void verifyOtp(OtpReq otpReq, OtpProvider otpProvider) async {
    try {
      await otpProvider.otpVerificationForAll(otpReq);
      if (otpProvider.otpVerificate != null) {
        final otpResp = OtpResp.fromJson(otpProvider.otpVerificate);
        if (otpResp.status == true) {
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          showToast('$responseData');
        } else {
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage(context, '$responseData', Colors.red);
        }
      }
    } catch (e) {
      responseMessage(context, 'Server Auth Error', Colors.red);
    }
  }

  void activateDevice(
      ActivateDeviceReq activateDeviceReq, AuthProvider authProvider) async {
    try {
      setState(() {
        print('printing Loader');
        isLoading = true;
        print('isLoading $isLoading');
      });
      await authProvider.activateDevice(activateDeviceReq);
      if (authProvider.activateD != null) {
        final loginResp = LoginResp.fromJson(authProvider.activateD);
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
    return Consumer2<OtpProvider, AuthProvider>(
        builder: (context, otp, authProvider, child) {
      otpProvider = otp;
      return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: size.height * 0.79,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 40),
                child: ActivateDeviceNumberWidget(widget: widget),
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
                height: size.height * 0.04,
              ),
              ResendOTP(
                textI: 'NO OTP RECEIVED? ',
                textII: 'TAP HERE TO RESEND IT',
                onTap: () {
                  var otpParams = OtpReq(phone: widget.phoneNumber);

                  verifyOtp(otpParams, otpProvider);
                },
              ),
              SizedBox(
                height: size.height * 0.2,
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
                      btnTitle: 'Activate Device',
                      size: size,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          KeyboardUtil.hideKeyboard(context);
                          var activateParams = ActivateDeviceReq(
                            phone: phoneNumber,
                            deviceId: deviceId,
                            deviceName: deviceName,
                            otp: _pin,
                            password: password

                          );
                          activateDevice(activateParams, authProvider);
                        }
                      })
            ],
          ),
        ),
      );
    });
  }
}
