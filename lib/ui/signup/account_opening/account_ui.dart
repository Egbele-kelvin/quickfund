import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AccountMain extends StatefulWidget {
  const AccountMain({Key key}) : super(key: key);

  @override
  _AccountMainState createState() => _AccountMainState();
}

class _AccountMainState extends State<AccountMain> {
  final _formKey = GlobalKey<FormState>();
  String bvn;
  int currentView = 0;
  bool checkUI;

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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                //color: kPrimaryColor,
                child: Custom_Sign_up_AppBar(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  imageUrl: 'assets/f_svg/quickfund.svg',
                  pageTitle: 'Account Opening',
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
                      vertical: getProportionateScreenHeight(10)),
                  child: Column(
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        AppStrings.registerWithBvn,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ToggleSwitch(
                          minWidth: size.width * 0.43,
                          minHeight: size.height * 0.08,
                          cornerRadius: 30.0,
                          inactiveFgColor: kPrimaryColor,
                          activeBgColor: [
                            kPrimaryColor,
                          ],
                          inactiveBgColor: Colors.grey.withOpacity(0.2),
                          totalSwitches: 2,
                          initialLabelIndex: 0,
                          changeOnTap: false,
                          labels: ['Sign up with BVN', 'with Phone Number'],
                          onToggle: (index) {
                            setState(() {
                              print('switch $index');
                              currentView=index;
                              // setState(() {
                              //   currentView =index;
                              // });
                              //currentView  !=  currentView;
                            });

                            //  print('switched to: $index');
                          },
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.05,
                      ),

                      Visibility(
                        visible: currentView == 0,
                        child: Column(
                          children: [
                            RoundedInputField(
                              onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              maxLen: 11,
                              labelText: 'BVN',
                              customTextHintStyle: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.black54.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                              hintText: 'Enter your BVN',
                              autoCorrect: true,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: kBVNNullError);
                                } else if (value.length >= 11) {
                                  removeError(error: kShortBVNError);
                                }
                                return null;
                              },
                              validateForm: (value) {
                                if (value.isEmpty) {
                                  addError(error: kBVNNullError);
                                  return "";
                                } else if (value.length < 11) {
                                  addError(error: kShortBVNError);
                                  return "";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Text(
                              AppStrings.HAS_NO_BVN,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            FormError(errors: errors),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: currentView == 1,
                        child: RoundedInputField(
                          onSaved: (newValue) => bvn = newValue,
                          inputType: TextInputType.number,
                          maxLen: 11,
                          labelText: 'Phone Number',
                          customTextHintStyle: GoogleFonts.lato(
                              fontSize: 12,
                              color: Colors.black54.withOpacity(0.3),
                              fontWeight: FontWeight.w600),
                          hintText: 'Enter your phone number',
                          autoCorrect: true,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kBVNNullError);
                            } else if (value.length >= 11) {
                              removeError(error: kShortBVNError);
                            }
                            return null;
                          },
                          validateForm: (value) {
                            if (value.isEmpty) {
                              addError(error: kBVNNullError);
                              return "";
                            } else if (value.length < 11) {
                              addError(error: kShortBVNError);
                              return "";
                            }
                            return null;
                          },
                        ),
                      ),
                      FormError(errors: errors),
                      Spacer(
                        flex: 1,
                      ),
                      Spacer(
                        flex: 5,
                      ),
                      CustomButton(size: size ,
                      onTap: (){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          Navigator.pushNamed(context, AppRouteName.ReviewDetails);
                        }
                      },
                      btnTitle: 'Continue'.toUpperCase(),),
                      Spacer(
                        flex: 7,
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
