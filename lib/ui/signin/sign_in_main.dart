import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_fingerPrint.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/form_error.dart';

class SignInMain extends StatefulWidget {
  @override
  _SignInMainState createState() => _SignInMainState();
}

class _SignInMainState extends State<SignInMain> {
  bool setImage, assetsImageUrl = false;
  bool _passwordVisible;
  String userName = 'Bose', phoneNumber, password;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();



  // static Future<bool> authenticateWithBiometrics() async {
  //   final LocalAuthentication localAuthentication = LocalAuthentication();
  //   bool isBiometricSupported = await localAuthentication.isDeviceSupported();
  //   bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
  //
  //   bool isAuthenticated = false;
  //
  //   if (isBiometricSupported && canCheckBiometrics) {
  //     isAuthenticated = await localAuthentication.authenticate(
  //       localizedReason: 'Please complete the biometrics to proceed.',
  //       //biometricOnly: true,
  //       stickyAuth: true,
  //     );
  //   }
  //
  //   return isAuthenticated;
  // }


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
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    //Spacer(flex: 1,),
                    CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage: assetsImageUrl != null
                            ? AssetImage('assets/f_png/businessman.png')
                            : NetworkImage('https://placebeard.it/640x360')),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      'Welcome back, $userName',
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                )),
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                              Text(
                                AppStrings.signInLetterHead,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                              ),
                              RoundedInputField(
                                // onSaved: (newValue) => bvn = newValue,
                                onSaved: (newValue) => phoneNumber = newValue,
                                inputType: TextInputType.text,
                                maxLen: 11,
                                labelText: 'Phone Number',
                                customTextHintStyle: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.black54.withOpacity(0.3),
                                    fontWeight: FontWeight.w600),
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
                                customTextHintStyle: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.black54.withOpacity(0.3),
                                    fontWeight: FontWeight.w600),
                                // onSaved: (newValue) => bvn = newValue,
                                inputType: TextInputType.visiblePassword,
                                maxLen: 11,
                                passwordvisible: _passwordVisible,
                                labelText: 'Enter Password',
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
                              Spacer(
                                flex: 1,
                              ),
                              FormError(errors: errors),
                              Spacer(
                                flex: 1,
                              ),
                              CustomSignInButton(
                                size: size,
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    // if all are valid then go to success screen
                                    KeyboardUtil.hideKeyboard(context);
                                    Navigator.pushReplacementNamed(
                                        context, AppRouteName.DASHBOARD);
                                  }
                                },
                                btnTitle: 'sign In',
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              Text(
                                'Forgot Password',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    color: kTap,
                                    fontSize: 12),
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
                              CustomFingerPrint(
                                onTap: () {},
                              ),
                              Spacer(
                                flex: 3,
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
    );
  }
}
