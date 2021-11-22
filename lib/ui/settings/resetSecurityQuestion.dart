import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/listOfSecurityQuestionResp.dart';
import 'package:quickfund/data/model/loginResp.dart';
import 'package:quickfund/data/model/resetSecurityQuestion.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/securityQuestionProvider.dart';
import 'package:quickfund/provider/settingsProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_widgets.dart';

class ResetSecurityQuestion extends StatefulWidget {
  const ResetSecurityQuestion({Key key}) : super(key: key);

  @override
  _ResetSecurityQuestionState createState() => _ResetSecurityQuestionState();
}

class _ResetSecurityQuestionState extends State<ResetSecurityQuestion> {
  String email, _pin,phone, oldPassword, password, confirmPassword, userId, quest1, quest2, answer1, answer2,responseData, title = 'Security Question';
  TextEditingController transactPin;
  bool showDataplan = false, showPhoneEdit = false, _btnEnabled = false, isLoading = false;
  int currentView = 1, selectedIndex;

  bool question1=true , question2=true;
  final question1Controller=TextEditingController();
  final question2Controller=TextEditingController();
  String headerText = 'settings', answerToSecurityQuestion;
  bool _oldPassword, _passwordVisible, _confirPasswordVisible;
  final List<String> errors = [];
  List<ListedQuestionData> securityQuestion = [];
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
    isLoading = true;
    final postMdl =
        Provider.of<SecurityQuestionProvider>(context, listen: false);
    postMdl.getListOfSecurityQuestion();
    setState(() {
      securityQuestion = postMdl.data;
    });
    _passwordVisible = true;
    _oldPassword = true;
    _confirPasswordVisible = true;
    super.initState();
  }

  responseMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w400,
          fontSize: 11,
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
    ));
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
                securityQuestion.isEmpty ? Container():  CustomDetails(
                  heading: 'Security Question',
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                securityQuestion == null
                    ? Center(
                        child: SpinKitFadingCircle(
                            size: 20,
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                              );
                            }))
                    : securityQuestion.isNotEmpty
                        ? ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: securityQuestion
                                .asMap()
                                .entries
                                .map((e) => SecurityQuestionListWidget(
                                      onTap: () {
                                        setState(() {
                                          question1Controller.text=e.value.question;
                                          quest1 = e.value.id.toString();
                                          print('quest1: $quest1');
                                        });

                                        Navigator.pop(context);
                                      },
                                      questItem: e.value.question,
                                    ))
                                .toList(),
                          )
                        : NoActivity(),
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
                securityQuestion.isEmpty ? Container():  CustomDetails(
                  heading: 'Security Question',
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                securityQuestion == null
                    ? Center(
                        child: SpinKitFadingCircle(
                            size: 20,
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                              );
                            }))
                    : securityQuestion.isNotEmpty
                        ? ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: securityQuestion
                                .asMap()
                                .entries
                                .map((e) => SecurityQuestionListWidget(
                                      onTap: () {
                                        setState(() {
                                          question2Controller.text=e.value.question;
                                          quest2 = e.value.id.toString();
                                          print('quest1: $quest1');
                                        });

                                        Navigator.pop(context);
                                      },
                                      questItem: e.value.question,
                                    ))
                                .toList(),
                          )
                        : NoActivity(),
              ],
            ),
          );
        });
  }

  void resetSecurityQuestion(
      ResetSecurityQuestionReq resetSecurityQuestionReq, SettingsProvider settingsProvider) async {
    setState(() {
      isLoading = true;
    });
    try {
      await settingsProvider.resetSecurityQuestion(resetSecurityQuestionReq);
      if (settingsProvider.changePin != null) {
        final changePinResp =
        LoginResp.fromJson(settingsProvider.changePin);
        if (changePinResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = changePinResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          Navigator.of(context).pushReplacementNamed(AppRouteName.DASHBOARD);
        } else {
          setState(() {
            isLoading = false;
          });
          responseData = changePinResp.message;
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


  parseAuthData(AuthProvider setupAccountViaBVNandViaPhoneProvider) {
    try {
      if (setupAccountViaBVNandViaPhoneProvider.login != null) {
        final userData =
            LoginResp.fromJson(setupAccountViaBVNandViaPhoneProvider.login);
        setState(() {
          userId = userData.data.user.id.toString();
          print('userId: $userId');
          phone = userData.data.user.phone;
          print('userId: $phone');


        });
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer2<AuthProvider , SettingsProvider>(builder: (context, provider,settingProvider, child) {
      parseAuthData(provider);
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 69.0,
            ),
            child: Text(
              'Please Answer One Question And Enter Your New Pin',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedInputField(
            controller: question1Controller,
            onTap: (){buildShowModalBottomSheetForUserTitle(context, size);},
            readOnly: question1,
            inputType: TextInputType.text,
            labelText: 'Question One',
            hintText: title,
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
            answer1 = newValue,
            inputType: TextInputType.text,
            labelText: 'Answer one',
            hintText: 'Enter your Answer to the Question',
            autoCorrect: true,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  answer1=value;
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
            hintText: title,
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
            onSaved: (newValue) =>
            answer2 = newValue,
            inputType: TextInputType.text,
            labelText: 'Answer Two',
            hintText: 'Enter your Answer to the Question',
            autoCorrect: true,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  answer2=value;
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
            height: size.height * 0.03,
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
              :CustomSignInButton(
            size: size,
            onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                KeyboardUtil.hideKeyboard(context);
                var resetQuestParam= ResetSecurityQuestionReq(
                  phone: phone,
                  quest1: quest1,
                  quest2: quest2,
                  answer2: answer2,
                  answer1: answer1,
                  userId: userId
                );
                resetSecurityQuestion(resetQuestParam, settingProvider);

              }
            },
            btnTitle: 'Continue',
          ),
        ],
      );
    });
  }
}
