import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/createAccountBvnResp.dart';
import 'package:quickfund/data/model/loginReq.dart';
import 'package:quickfund/data/model/loginResp.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/otpResp.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/ui/signup/account_opening/activateDeviceUI.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_fingerPrint.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:toast/toast.dart';
import 'package:universal_platform/universal_platform.dart';

class SignInMain extends StatefulWidget {
  @override
  _SignInMainState createState() => _SignInMainState();
}

class _SignInMainState extends State<SignInMain> {
  bool setImage,
      assetsImageUrl = false,
      isLoading = false,
      biometricActive = false,
      hasAlreadyLogin = false;
  bool _passwordVisible;
  String userName = 'Bose', phoneNumber, password, responseData;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  AuthProvider _auth;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String _authorizedOrNot = "Not Authorized";
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

  void checkBiometricSetup() async {
    bool isBiometricsOn =
        await _sharedPreferenceQS.getSharedPrefs(bool, kIsBiometricOn);

    hasAlreadyLogin =
        await _sharedPreferenceQS.getSharedPrefs(bool, kHasAlreadyLogin) ??
            false;
    isBiometricsOn = (isBiometricsOn != null) ? isBiometricsOn : false;
    setState(() {
      biometricActive = isBiometricsOn;
    });
    if (isBiometricsOn) {
      checkBioMeTric();
    }
  }

  Future showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    String cancelActionText,
    @required String defaultActionText,
  }) async {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              if (cancelActionText != null)
                FlatButton(
                  child: Text(cancelActionText),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    Navigator.of(context)
                        .pushReplacementNamed(AppRouteName.DASHBOARD);
                  },
                ),
              FlatButton(
                child: Text(defaultActionText),
                textColor: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop(false);
                  _sharedPreferenceQS.setData('bool', kIsBiometricOn, true);
                  Navigator.of(context)
                      .pushReplacementNamed(AppRouteName.DASHBOARD);
                },
              ),
            ],
          );
        },
      );
    }
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () {
                Navigator.of(context).pop(false);
                Navigator.of(context)
                    .pushReplacementNamed(AppRouteName.DASHBOARD);
              },
            ),
          CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.red),
            child: Text(defaultActionText),
            onPressed: () {
              Navigator.of(context).pop(false);
              _sharedPreferenceQS.setData('bool', kIsBiometricOn, true);

              Navigator.pushReplacementNamed(context, AppRouteName.DASHBOARD);
              // Navigator.of(context)
              //     .pushReplacementNamed(AppRouteName.DASHBOARD);
            },
          ),
        ],
      ),
    );
  }

  void checkBioMeTric() async {
    if (await _getBiometricsSupport()) {
      selfie = await _sharedPreferenceQS.getSharedPrefs(String, 'selfie') ?? '';
      print('selfie: $selfie');
      username = await _sharedPreferenceQS.getSharedPrefs(String, 'firstName');
      print('username: $username');
      await _getAvailableSupport();
      if (await _authenticateMe()) {
        phone = await _sharedPreferenceQS.getSharedPrefs(String, 'phoneNumber');
        print('phone: $phone');
        selfie = await _sharedPreferenceQS.getSharedPrefs(String, 'selfie');
        print('selfie: $selfie');
        username =
            await _sharedPreferenceQS.getSharedPrefs(String, 'firstName');
        print('username: $username');
        password = await _sharedPreferenceQS.getSharedPrefs(String, 'password');
        print('password: $password');

        var signInR = LoginReq(
            phone: phone,
            password: password,
            deviceId: deviceID,
            deviceName: deviceName);
        signIn(signInR, _auth, true);
        print('signInR: $signInR');
      }
    } else {
      print('eror fingerprintDetect');
    }
  }

  List<BiometricType> _availableBuimetricType;

  Future<bool> _getBiometricsSupport() async {
    bool hasFingerPrintSupport = false;
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
      return hasFingerPrintSupport;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _getAvailableSupport() async {
    List<BiometricType> availableBuimetricType;
    try {
      availableBuimetricType =
          await _localAuthentication.getAvailableBiometrics();
      print(availableBuimetricType);
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBuimetricType = availableBuimetricType;
    });
  }

  Future<bool> _authenticateMe() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticate(
        localizedReason: "Authenticate for Testing", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );

      print(_authorizedOrNot);
      return authenticated;
    } catch (e) {
      print(e);
      return false;
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

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context,
        duration: duration,
        gravity: gravity,
        backgroundRadius: 20.0,
        textColor: Colors.white60);
  }

  Future<dynamic> buildShowModalBottomSheetToActivateDevice(
      BuildContext context, String phoneNumber, String passWord) {
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
          var size = MediaQuery.of(context).size;
          return ActivateDevice(
            phoneNumber: phoneNumber,
            passWord: passWord,
          );
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

  @override
  void initState() {
    _passwordVisible = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkBiometricSetup();
      getImei();
    });

    super.initState();
  }

  var selfie, username, phone;

  void signIn(
      LoginReq loginReq, AuthProvider provider, bool isBiometricSign) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
      print('isLoading $isLoading');
    });
    try {
      await provider.signIn(loginReq);
      var loginResponse = LoginResp.fromJson(provider.login);
      print('loginResp response $loginResponse');
      if (provider.login != null) {
        if (loginResponse.status == true) {
          responseData = loginResponse.message;
          print('responseMessage : $responseData');
          _sharedPreferenceQS.setData(
              'String', 'token', loginResponse.data.token.accessToken);
          _sharedPreferenceQS.setData(
              'String', 'firstName', loginResponse.data.user.firstName);
          _sharedPreferenceQS.setData(
              'String', 'selfie', loginResponse.data.user.selfie);

          if (!hasAlreadyLogin) {
            _sharedPreferenceQS.setData('bool', kHasAlreadyLogin, true);
          }
          responseData = loginResponse.message;
          isLoading = false;
          print('looorgin:  $responseData');
          //Pop up confirmation box
          /*** Show Confirmation box here with await */
          if (isBiometricSign) {
            Navigator.of(context).pushReplacementNamed(AppRouteName.DASHBOARD);
          } else {
            if (!biometricActive && !hasAlreadyLogin) {
              await showAlertDialog(
                  context: context,
                  title: 'Activate Biometric',
                  cancelActionText: 'Ignore',
                  content: 'Activate Biometric for signing in to your account',
                  defaultActionText: 'Activate');
            } else {
              Navigator.of(context)
                  .pushReplacementNamed(AppRouteName.DASHBOARD);
            }
          }
        } else if (loginResponse.status == false &&
            loginResponse.responsecode == 403) {
          setState(() {
            isLoading = false;
          });
          print('phoneNumber $phoneNumber');
          responseMessage('${loginResponse.message}', Colors.red);

          var requestOtp = OtpReq(phone: phoneNumber);
          // verifyOtp(requestOtp, otpProvider);
          Future.delayed(Duration(milliseconds: 1700), () {
            buildShowModalBottomSheetToActivateDevice(
                context, phoneNumber, password);
          });
        } else {
          setState(() {
            isLoading = false;
          });
          responseData = loginResponse.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage('$responseData', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer2<AuthProvider, SetupAccountViaBVNandViaPhoneProvider>(
      builder: (context, provider, setupProvider, child) {
        _auth = provider;
        return LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: kPrimaryColor,
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 0,
                      child: Column(
                        children: [
                          //Spacer(flex: 1,),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  color: Colors.grey.shade300),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                backgroundImage: selfie == null
                                    ? AssetImage('assets/f_png/businessman.png')
                                    : NetworkImage('$selfie'),
                              )),

                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Visibility(
                            visible: biometricActive,
                            child: Text(
                              'Welcome back, $username',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 2,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(children: [
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Text(
                              AppStrings.signInLetterHead,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            RoundedInputField(
                              onSaved: (newValue) => phoneNumber = newValue,
                              inputType: TextInputType.phone,
                              maxLen: 11,
                              labelText: 'Phone Number',
                              customTextHintStyle: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.black54.withOpacity(0.3),
                                  fontWeight: FontWeight.w400),
                              hintText: 'Enter Phone Number',
                              autoCorrect: true,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: kPhoneNumberNullError);
                                } else if (value.length >= 11) {
                                  removeError(error: kShortPhoneNumberError);
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
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              customTextHintStyle: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.black54.withOpacity(0.3),
                                  fontWeight: FontWeight.w400),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.visiblePassword,
                              maxLen: 6,
                              passwordvisible: _passwordVisible,
                              labelText: 'Enter Password',
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
                                if (value.isEmpty) {
                                  addError(error: kPassNullError);
                                  return "";
                                } else if (value.length < 6) {
                                  addError(error: kShortPassError);
                                  return "";
                                }
                                return null;
                              },
                              suffixIcon: InkWell(
                                  child: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey[500],
                                    size: 15,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  }),
                            ),
                            FormError(errors: errors),
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            CustomSignInButton(
                              size: size,
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  KeyboardUtil.hideKeyboard(context);
                                  var signParams = LoginReq(
                                      phone: phoneNumber,
                                      password: password,
                                      deviceName: deviceName,
                                      deviceId: deviceID);

                                  _sharedPreferenceQS.setData('String',
                                      'phoneNumber', signParams.phone);
                                  _sharedPreferenceQS.setData('String',
                                      'deviceId', signParams.deviceId);
                                  _sharedPreferenceQS.setData('String',
                                      'deviceName', signParams.deviceName);
                                  _sharedPreferenceQS.setData('String',
                                      'password', signParams.password);
                                  signIn(signParams, provider, false);
                                }
                              },
                              btnTitle: 'sign In',
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRouteName.ForgotPasswordUI);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: kTap,
                                    fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            ResendOTP(
                              textI: "Don't have a QFMB account? ",
                              textII: 'Create account',
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRouteName.getStartedUpdatedUI);
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Visibility(
                              visible: biometricActive,
                              child: CustomFingerPrint(
                                onTap: () {
                                  checkBioMeTric();
                                },
                              ),
                            ),
                          ]),
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
