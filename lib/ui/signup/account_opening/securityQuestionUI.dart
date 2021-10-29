import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/createAccountBvnResp.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/otpResp.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/provider/securityQuestionProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:toast/toast.dart';

import 'accountOpeningWidget.dart';

class SecurityQuestionUI extends StatefulWidget {
  @override
  _SecurityQuestionUIState createState() => _SecurityQuestionUIState();
}

class _SecurityQuestionUIState extends State<SecurityQuestionUI> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentView = 0;
  String accountNumber = '' , phoneNumber , qst1='Question One', qst2='Question Two';
  bool _passwordVisible, _confirPasswordVisible;
  bool showDataplan = false, showPhoneEdit = false;
  TextEditingController transactPin=TextEditingController();
  final question1Controller=TextEditingController();
  final question2Controller=TextEditingController();
bool question1=true , question2=true;
  String _pin,userID, answerToSecurityQuestion , answerToSecurityQuestion1,answerToSecurityQuestion2;
  List<String> securityQuestion = [
    AppStrings.SecurityQuestionI,
    AppStrings.SecurityQuestionII,
    AppStrings.SecurityQuestionIII,
    AppStrings.SecurityQuestionIV,
    AppStrings.SecurityQuestionV,
    AppStrings.SecurityQuestionVI
  ];
  String gender, maritalStatus, stateOO;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String conform_password , responseData;
  bool remember = false , isLoading=false;
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context,
        duration: duration,
        gravity: gravity,
        backgroundRadius: 20.0,
        textColor: Colors.white60);
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
  parseAuthData(SetupAccountViaBVNandViaPhoneProvider authProvider) {
    try {
      if (authProvider.createAccountUsingBvn != null) {
        final userData = CreateAccountBvnResp.fromJson(authProvider.createAccountUsingBvn);
        accountNumber = userData.data.accountNumber;
        phoneNumber= userData.data.user.phone;
        userID = userData.data.user.id.toString();
        print(accountNumber);
        print(phoneNumber);
        print(userID);
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  parseAuthDataFromOldCustomer(OtpProvider otpProvider) {
    try {
      if (otpProvider.completeOnBoardOldC != null) {
        final userData = CreateAccountBvnResp.fromJson(otpProvider.completeOnBoardOldC);
        accountNumber = userData.data.accountNumber;
        phoneNumber= userData.data.user.phone;
        userID = userData.data.user.id.toString();
        print(accountNumber);
        print(phoneNumber);
        print(userID);
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  void verifyOtp(
      OtpReq otpReq, OtpProvider otpProvider) async {
    setState(() {
      print('printing Loader');
      showToast('OTP-Code has been sent!');
    });
    try {
      await otpProvider.otpVerificationForAll(otpReq);
      if (otpProvider.otpVerificate != null) {
        final otpResp =
        OtpResp.fromJson(otpProvider.otpVerificate);
        if (otpResp.status == true) {
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
        } else{
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      }
    } catch (e) {
      responseMessage('Server Auth Error', Colors.red);
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

  void securityQuestionPayLoad(
      SetupSecurityQuestion setupSecurityQuestion, SecurityQuestionProvider securityQuestionProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await securityQuestionProvider.setupSecurityQuestion(setupSecurityQuestion);
      if (securityQuestionProvider.setupSecurityQuestionR != null) {
        final setupSecurityQuestionResp =
        CreateAccountBvnResp.fromJson(securityQuestionProvider.setupSecurityQuestionR);
        if (setupSecurityQuestionResp.status==true) {
          setState(() {
            isLoading = false;
          });
          responseData = setupSecurityQuestionResp.message.toString();
          print('responseMessage : $responseData');
          Navigator.pushReplacementNamed(context, AppRouteName.LOG_IN);
        }else{
          setState(() {
            isLoading=false;
          });
          responseData = setupSecurityQuestionResp.message;
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
                      SecurityQuestionWidgetQuest(
                        onTap: (){
                         setState(() {
                           print('qst1 : $qst1');
                           qst1=answerToSecurityQuestion;
                         });
                          Navigator.pop(context);},
                        onChanged: (val){
                          if(val.isNotEmpty){
                           setState(() {
                             answerToSecurityQuestion=val;

                           });
                          }
                        },onSaved: (newValue)=>answerToSecurityQuestion,
                      ),

                      Expanded(flex:2, child:   Container(

                        height:size.height *0.5,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: securityQuestion.asMap().entries.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0 , vertical: 10),
                            child:
                            CustomListTile(
                              title: e.value,
                              onTap: (){
                                setState(() {
                                  qst1 = e.value;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          )).toList(),
                        ),
                      ),),

                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Future<dynamic> buildShowModalBottomSheetForUserT(
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
                      SecurityQuestionWidgetQuest(
                        onTap: (){
                         setState(() {
                           print('qst2 : $qst2');
                           qst2=answerToSecurityQuestion;
                         });
                          Navigator.pop(context);},
                        onChanged: (val){
                          if(val.isNotEmpty){
                           setState(() {
                             answerToSecurityQuestion=val;

                           });
                          }
                        },onSaved: (newValue)=>answerToSecurityQuestion,
                      ),

                      Expanded(flex:2, child:   Container(

                        height:size.height *0.5,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: securityQuestion.asMap().entries.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0 , vertical: 10),
                            child:
                            Column(
                              children: [
                                CustomListTile(
                                  title: e.value,
                                  onTap: (){
                                    setState(() {
                                      qst2 = e.value;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                Divider()
                              ],
                           ),
                          )).toList(),
                        ),
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
    return Consumer3<SetupAccountViaBVNandViaPhoneProvider , SecurityQuestionProvider , OtpProvider>(
  builder: (context, setUpAccountProvider,securityProvider , otpProvider, child) {
    parseAuthData(setUpAccountProvider);
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
                      child:SingleChildScrollView(
                        child:  Column(children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          RoundedInputField(
                            controller: question1Controller,
                            onTap: (){buildShowModalBottomSheetForUserTitle(context, size);},
                            readOnly: question1,
                            inputType: TextInputType.text,
                            labelText: 'Question One',
                            hintText: qst1,
                            customTextHintStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            autoCorrect: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          RoundedInputField(
                            // onSaved: (newValue) => bvn = newValue,
                            onSaved: (newValue) =>
                            answerToSecurityQuestion1 = newValue,
                            inputType: TextInputType.text,
                            labelText: 'Answer one',
                            customTextHintStyle: GoogleFonts.lato(
                                fontSize: 12,
                                color: Colors.black54.withOpacity(0.3),
                                fontWeight: FontWeight.w600),
                            hintText: 'Enter your Answer to the Question',
                            autoCorrect: true,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  answerToSecurityQuestion1=value;
                                });
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
                            controller: question2Controller,
                            onTap: (){buildShowModalBottomSheetForUserT(context, size);},
                            readOnly: question1,
                            inputType: TextInputType.text,
                            labelText: 'Question Two',
                            hintText: qst2,
                            customTextHintStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            autoCorrect: true,
                          ), SizedBox(
                            height: size.height * 0.02,
                          ),
                          RoundedInputField(
                            // onSaved: (newValue) => bvn = newValue,
                            onSaved: (newValue) =>
                            answerToSecurityQuestion2 = newValue,
                            inputType: TextInputType.text,
                            labelText: 'Answer Two',
                            customTextHintStyle: GoogleFonts.lato(
                                fontSize: 12,
                                color: Colors.black54.withOpacity(0.3),
                                fontWeight: FontWeight.w600),
                            hintText: 'Enter your Answer to the Question',
                            autoCorrect: true,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  answerToSecurityQuestion2=value;
                                });
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
                            maxLen: 4,
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
                                setState(() {
                                  password = value;
                                });
                                removeError(error: kPassNullError);
                              } else if (value.length >= 4) {
                                removeError(error: kShortPassError);
                              }

                            },
                            validateForm: (value) {
                              if (value.isEmpty) {
                                addError(error: kPassNullError);
                                return "";
                              } else if (value.length < 4) {
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
                            maxLen: 4,
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
                                setState(() {
                                  conform_password = value;
                                });
                                removeError(error: kPassNullError);
                              } else if (value.isNotEmpty &&
                                  password == conform_password) {
                                removeError(error: kMatchPassError);
                              }

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
                                )
                              ),
                            ],
                          ),
                          FormError(errors: errors),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomSignInButton(
                            size: size,
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                KeyboardUtil.hideKeyboard(context);

                                var securityQuestionParams=SetupSecurityQuestion(
                                    phone: phoneNumber,
                                    otp: _pin,
                                    pin: password,
                                    pinConfirmation: conform_password,
                                    answer1: answerToSecurityQuestion1,
                                    answer2: answerToSecurityQuestion2,
                                    quest1: qst1,
                                    quest2: qst1,
                                    userId: userID
                                );
                                securityQuestionPayLoad(securityQuestionParams , securityProvider);
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
                            onTap: () {
                              var otpParams=OtpReq(
                                  phone: phoneNumber
                              );

                              verifyOtp(otpParams , otpProvider);


                            },
                          ), SizedBox(
                            height: size.height * 0.2,
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
      ),
  );
  },
);
  }
}

