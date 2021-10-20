import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/createAccountBvnResp.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';

import 'accountOpeningWidget.dart';

class SecurityQuestionUI extends StatefulWidget {
  @override
  _SecurityQuestionUIState createState() => _SecurityQuestionUIState();
}

class _SecurityQuestionUIState extends State<SecurityQuestionUI> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentView = 0;
  String accountNumber = '';
  bool _passwordVisible, _confirPasswordVisible;
  bool showDataplan = false, showPhoneEdit = false;
  TextEditingController transactPin;
  TextEditingController securityQuestionController;

  String _pin, answerToSecurityQuestion;
  List<String> securityQuestion = [
    AppStrings.SecurityQuestionI,
    AppStrings.SecurityQuestionII,
    AppStrings.SecurityQuestionIII,
    AppStrings.SecurityQuestionIV,
    AppStrings.SecurityQuestionV,
    AppStrings.SecurityQuestionVI
  ];
  String title = 'Security Question', gender, maritalStatus, stateOO;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String conform_password , responseData;
  bool remember = false , isLoading;
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

  void securityQuestionPayLoad(
      SetupSecurityQuestion setupSecurityQuestion, SetupAccountViaBVNandViaPhone authProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await authProvider.setupSecurityQuestion(setupSecurityQuestion);
      if (authProvider.setupSecurityQuestionR != null) {
        final setupSecurityQuestionResp =
        CreateAccountBvnResp.fromJson(authProvider.setupSecurityQuestionR);
        if (setupSecurityQuestionResp.status==true) {
          setState(() {
            isLoading = false;
          });
          responseData = setupSecurityQuestionResp.message.toString();
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          Navigator.pushReplacementNamed(context, AppRouteName.AccountOpeningUI);
        }else{
          setState(() {
            isLoading=false;
          });
          responseData = setupSecurityQuestionResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('LoadingData: $isLoading');
        print('dataResp: ${authProvider.initiateBvnR.toString()}');

        responseMessage('$responseData', Colors.red);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage('Server Auth Error', Colors.red);
    }
  }


  
  Future<dynamic> buildShowModalBottomSheetForUserTitle(
      BuildContext context, Size size) {
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
          return Container(
            height: size.height * 0.8,
            child: Column(
              children: [
                CustomDetails(
                  heading: 'Security Question',
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  height: size.height *0.6,
                  child: Column(
                    children: [


                      Expanded(flex:0, child:   Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        // height: size.height *0.1,
                        child: Row(
                          children: [
                            Container(
                              width: size.width *0.73,
                              child: RoundedInputField(
                                controller: securityQuestionController,
                                // onSaved: (newValue) => bvn = newValue,
                                onSaved: (newValue) =>
                                answerToSecurityQuestion = newValue,
                                inputType: TextInputType.text,
                                labelText: 'Create a Security Question',
                                customTextHintStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black54.withOpacity(0.3),
                                    fontWeight: FontWeight.w400),
                                autoCorrect: true,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    removeError(error: kSecurityNullError);
                                  }
                                  return null;
                                },
                                validateForm: (value) {
                                  if (value.isEmpty) {
                                    addError(error: kSecurityNullError);
                                    return "";
                                  }
                                  return null;
                                },
                              ),
                            ),

                            SizedBox(
                              width: size.height * 0.02,
                            ),
                            AddSecurityQuestion(
                              onTap: (){
                                setState(() {
                                  title=securityQuestionController.text;
                                });
                              },
                            )
                          ],
                        ),
                      ),),
                      Expanded(flex:2, child:   Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          height: size.height *0.1,
                          child: Column(
                            children: [

                              Container(
                                height:size.height *0.5,
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: securityQuestion.asMap().entries.map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18.0 , vertical: 10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: (){},
                                          title: Text(e.value , style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black
                                          ),),
                                          trailing: Icon(Icons.tag , size: 12),

                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 0.5,
                                        ),
                                      ],
                                    ),
                                  )).toList(),
                                ),
                              )
                            ],
                          )
                      ),),

                    ],
                  ),
                )
              ],
            ),
          );
        });
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

   parseAuthData(SetupAccountViaBVNandViaPhone authProvider) {
    try {
      if (authProvider.createAccountUsingBvn != null) {
        final userData = CreateAccountBvnResp.fromJson(authProvider.createAccountUsingBvn);
        accountNumber = userData.data.accountNumber;
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }


  @override
  void initState() {
  _passwordVisible = true;
  _confirPasswordVisible = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Consumer<SetupAccountViaBVNandViaPhone>(
  builder: (context, provider, child) {
  return WillPopScope(
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
              Flexible(
                flex: 1,
                child: Container(
                  //color: kPrimaryColor,
                  child: CustomAppBar(
                    onTap: () {
                      onBackPress();
                    },
                    pageTitle: 'QFMB account no: $accountNumber',
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                 // height: size.height,
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
                    child:CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child:    Column(children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SelectedCustom(
                              size: size,
                              onTap: () {
                                buildShowModalBottomSheetForUserTitle(
                                    context, size);
                              },
                              title: title,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              // onSaved: (newValue) => bvn = newValue,
                              onSaved: (newValue) =>
                              answerToSecurityQuestion = newValue,
                              inputType: TextInputType.text,
                              labelText: 'Enter Answer',
                              customTextHintStyle: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.black54.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                              hintText: 'Enter your Answer to the Question',
                              autoCorrect: true,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: kSecurityNullError);
                                }
                                return null;
                              },

                              validateForm: (value) {
                                if (value.isEmpty) {
                                  addError(error: kSecurityNullError);
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
                              customTextHintStyle: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.black54.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'Enter New Pin',
                              hintText: '*********',
                              autoCorrect: true,
                              onSaved: (newValue) => password = newValue,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: kPassNullError);
                                } else if (value.length >= 5) {
                                  removeError(error: kShortPassError);
                                }
                                password = value;
                              },
                              validateForm: (value) {
                                if (value.isEmpty) {
                                  addError(error: kPassNullError);
                                  return "";
                                } else if (value.length < 5) {
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
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            RoundedInputField(
                              maxLen: 6,
                              customTextHintStyle: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.black54.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                              // onSaved: (newValue) => bvn = newValue,
                              inputType: TextInputType.number,
                              labelText: 'Confirm New Pin',
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
                                if (value.isEmpty) {
                                  addError(error: kPassNullError);
                                  return "";
                                } else if ((password != value)) {
                                  addError(error: kMatchPassError);
                                  return "";
                                }
                                return null;
                              },
                              suffixIcon: InkWell(
                                  child: Icon(
                                    _confirPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
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
                            Column(
                              children: [
                                Text(
                                  'Enter OTP',
                                  style: GoogleFonts.roboto(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0, vertical: 15),
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
                              ],
                            ),
                            FormError(errors: errors),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            CustomButton(
                              size: size,
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  KeyboardUtil.hideKeyboard(context);
                                  // if all are valid then go to success screen
                                  Navigator.pushNamed(
                                      context, AppRouteName.LOG_IN);
                                }
                              },
                              btnTitle: 'Confirm',
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            ResendOTP(
                              textI: 'NO OTP RECEIVED? ',
                              textII: 'TAP HERE TO RESEND IT',
                              onTap: () {},
                            ),

                          ]),
                        ),
                      ],
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

class AddSecurityQuestion extends StatelessWidget {
  final Function onTap;
  const AddSecurityQuestion({
    Key key, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Icon(
        Icons.add,
        size: 30,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
