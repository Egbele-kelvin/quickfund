import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:share/share.dart';

class SettingsMainUI extends StatefulWidget {
  const SettingsMainUI({Key key}) : super(key: key);

  @override
  _SettingsMainUIState createState() => _SettingsMainUIState();
}

class _SettingsMainUIState extends State<SettingsMainUI> {
  String email, _pin , oldPassword, password, confirmPassword;
  TextEditingController transactPin;
  bool showDataplan = false, showPhoneEdit = false, _btnEnabled = false;
  int currentView = 1, selectedIndex;
  String headerText= 'settings';
  bool _oldPassword, _passwordVisible, _confirPasswordVisible;
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

  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 1) {
      Navigator.of(context).pop();
     // Navigator.pushReplacementNamed(context, AppRouteName.DASHBOARD);
    } else {
      setState(() {
        if (showDataplan) {
          showDataplan = false;
        } else if (currentView == 2) {
          //  isEnabled = true;
          headerText = 'Settings';
          currentView = 1;
        } else if (currentView == 3) {
          // isEnabled = false;
          headerText = 'Set New Pin';
          currentView = 2;
        }
      });
      print('printght' + currentView.toString());
    }
  }

  @override
  void initState() {
    _passwordVisible = true;
    _oldPassword = true;
    _confirPasswordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
     backgroundColor: kPrimaryColor,
      body:Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                //color: kPrimaryColor,
                child: CustomAppBar(
                  onTap: () {
                    onBackPress();
                    // Navigator.pushReplacementNamed(
                    //     context, AppRouteName.DASHBOARD);
                  },
                  pageTitle: headerText,
                ),
              ),
            ),
            Expanded(
              flex: 5,
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
                  child: Column(
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      Visibility(
                        visible: currentView == 1,
                        child: Column(
                          children: [
                            GetHelp_widget(
                              size: size,
                              title: 'Change Pin',
                              leadingIcon: Icons.lock_open,
                              onTap: () {
                                setState(() {
                                  currentView = 2;
                                  headerText = 'Set New Pin';
                                });
                                print('');
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Change Transaction Pin',
                              leadingIcon: Icons.lock,
                              onTap: () {
                                print('');
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Reset Transaction Pin',
                              leadingIcon: Icons.cached,
                              onTap: () {
                                print('');
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Reset Question & Answer',
                              leadingIcon: Icons.cached,
                              onTap: () {
                                print('');
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Share This APP',
                              leadingIcon: Icons.share,
                              onTap: () {
                                // _shareContent();
                                print('');
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Biometric',
                              leadingIcon: Icons.fingerprint,
                              onTap: () {
                                print('');
                              },
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                          visible: currentView==2,
                          child: Column(
                        children: [
                          RoundedInputField(
                            passwordvisible: _passwordVisible,
                            customTextHintStyle: GoogleFonts.lato(
                                fontSize: 12,
                                color: Colors.black54.withOpacity(0.3),
                                fontWeight: FontWeight.w600),
                            // onSaved: (newValue) => bvn = newValue,
                            inputType: TextInputType.visiblePassword,
                            labelText: 'Current Pin',
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
                                  _oldPassword ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey[500],
                                  size: 15,
                                ),
                                onTap: () {
                                  setState(() {
                                    _oldPassword = !_passwordVisible;
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
                            confirmPassword = newValue,
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
                                  currentView = 3;
                                });
                              }
                            },
                            btnTitle: 'Continue',
                          ),
                        ],
                      )),

                      Visibility(
                          visible: currentView == 3,
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
                                   //   currentView = 2;
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
                      Spacer(
                        flex: 6,
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
