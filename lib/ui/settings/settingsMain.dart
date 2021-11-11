import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';
import 'package:quickfund/ui/settings/resetSecurityQuestion.dart';
import 'package:quickfund/ui/signup/account_opening/accountOpeningWidget.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';

import 'changePassWord.dart';
import 'changePin.dart';

class SettingsMainUI extends StatefulWidget {
  const SettingsMainUI({Key key}) : super(key: key);

  @override
  _SettingsMainUIState createState() => _SettingsMainUIState();
}

class _SettingsMainUIState extends State<SettingsMainUI> {
  String email, _pin , oldPassword, password, confirmPassword;
  String title = 'Security Question';
  TextEditingController transactPin;
  bool showDataplan = false, showPhoneEdit = false, _btnEnabled = false;
  int currentView = 1, selectedIndex;
  String headerText= 'settings' ,  answerToSecurityQuestion;
  bool isBiometricsOn= false;
  bool status = false;
  Repository repository = Repository(networkService: NetworkService());
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  bool _oldPassword, _passwordVisible, _confirPasswordVisible;
  final List<String> errors = [];
  void getBiometric()async{
    isBiometricsOn =
    await _sharedPreferenceQS.getSharedPrefs(bool, kIsBiometricOn) ;
    setState(() {});
    print('isbometric $isBiometricsOn');
  }

  void saveBiometricState(bool val) async{
    await _sharedPreferenceQS.setData('bool', kIsBiometricOn, val);
  }

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
        } else if (currentView == 4) {
          // isEnabled = false;
          headerText = 'settings';
          currentView = 1;
        } else if (currentView == 5) {
          // isEnabled = false;
          headerText = 'Change Transaction Pin';
          currentView = 4;
        } else if (currentView == 6) {
          // isEnabled = false;
          headerText = 'settings';
          currentView = 1;
        }
      });
      print('printght' + currentView.toString());
    }
  }

  @override
  void initState() {
    getBiometric();
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
                              title: 'Change Password',
                              leadingIcon: Icons.lock,
                              onTap: () {
                                setState(() {
                                  currentView = 4;
                                  headerText = 'Change Password';
                                });
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Reset Question & Answer',
                              leadingIcon: Icons.cached,
                              onTap: () {
                                setState(() {
                                  currentView = 6;
                                  headerText = 'Reset Question & Answer';
                                });
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
                            Padding(
                              padding:  EdgeInsets.only(right: 18.0),
                              child: CustomProfileChildRowWidget(
                                  size: size,
                                  title: 'Enable or Disable Biometrics',
                                  svgURL: 'assets/f_svg/wifi.svg',
                                  widgetIcon: CustomFlushToggle(
                                    size: size,
                                    status: isBiometricsOn,
                                    onToggle: (val) {
                                      setState(() {
                                        isBiometricsOn = val;
                                      });
                                      saveBiometricState(val);
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                          visible: currentView==2,
                          child:ChangePin() ),
                      Visibility(
                          visible: currentView == 4,
                          child: ChangePassWord()),
                      Visibility(
                          visible: currentView == 6,
                          child: ResetSecurityQuestion()),
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

