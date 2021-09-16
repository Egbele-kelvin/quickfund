import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:quickfund/widget/transactionPinUI.dart';

class AirtimeUI extends StatefulWidget {
  @override
  _AirtimeUIState createState() => _AirtimeUIState();
}

class _AirtimeUIState extends State<AirtimeUI> {
  int currentView = 0, selectedIndex;

  TextEditingController _amountController = TextEditingController();
  TextEditingController transactPin;
  List<String> airtimeProvider = ['Airtel', 'MTN', 'GLO', '9Mobile'];
  bool showDataplan = false, showPhoneEdit = false, _btnEnabled = false;
  String tfDate = DateFormat.yMMMd().format(DateTime.now());

  List<String> amountProvider = [
    '100',
    '200',
    '300',
    '500',
    '1000',
    '1500',
    '2500',
    '3000'
  ];
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  String initialAmount,
      phoneNum,
      amount,
      airtimeType,
      pin,
      userAccountNumber = '1019945039';
  String amountHere;

  @override
  void initState() {
    print(tfDate);
    super.initState();
  }

  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 0) {
      // Navigator.pop(context);
      Navigator.pushReplacementNamed(
          context, AppRouteName.DASHBOARD);
    } else {
      setState(() {
        if (showDataplan) {
          showDataplan = false;
        } else if (currentView == 1) {
          //  isEnabled = true;
          currentView = 0;
        } else if (currentView == 2) {
          // isEnabled = false;
          currentView = 1;
        }
      });
      print('printght' + currentView.toString());
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return onBackPress();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColor,
        body: Form(
          key: _formKey,
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Container(
                //color: kPrimaryColor,
                child: CustomAppBar(
                  onTap: () {
                    onBackPress();
                  },
                  pageTitle: 'Airtime',
                ),
              ),
            ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(10),
                    ),
                    child: CustomScrollView(slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Visibility(
                              visible: currentView == 0,
                              child: Column(
                                children: airtimeProvider
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => CustomAirtimeWidget(
                                        size: size,
                                        title: e.value,
                                        imgURL:
                                            'assets/f_svg/${e.value.toLowerCase()}.svg',
                                        onTap: () {
                                          print(e.value);
                                          setState(() {
                                            currentView = 1;
                                            airtimeType = e.value;
                                          });
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Visibility(
                              visible: currentView == 1,
                              child: Column(
                                children: [
                                  BuyingAirtimeCustomPlaceHolder(
                                      size: size, airtimeType: airtimeType),
                                  SizedBox(
                                    height: size.height * .03,
                                  ),
                                  RoundedInputField(
                                    // onSaved: (newValue) => bvn = newValue,
                                    onSaved: (newValue) => phoneNum = newValue,
                                    inputType: TextInputType.text,
                                    maxLen: 11,
                                    labelText: 'Phone Number',
                                    customTextHintStyle: GoogleFonts.lato(
                                        fontSize: 12,
                                        color: Colors.black54.withOpacity(0.3),
                                        fontWeight: FontWeight.w600),
                                    hintText: 'Phone Number',
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
                                    height: size.height * 0.03,
                                  ),
                                  RoundedInputField(
                                    controller: _amountController,
                                    onSaved: (newValue) => amount = newValue,
                                    inputType: TextInputType.text,
                                    labelText: 'Amount',
                                    customTextHintStyle: GoogleFonts.lato(
                                        fontSize: 12,
                                        color: Colors.black54.withOpacity(0.3),
                                        fontWeight: FontWeight.w600),
                                    hintText: 'Amount',
                                    autoCorrect: true,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        removeError(error: kAmount);
                                      }
                                      return null;
                                    },
                                    validateForm: (value) {
                                      if (value.isEmpty) {
                                        addError(error: kAmount);
                                        return "";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  SelectAmountWidget(),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  Wrap(
                                    children: amountProvider
                                        .asMap()
                                        .entries
                                        .map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7.0, bottom: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = e.key;
                                                  initialAmount = e.value;
                                                  _amountController.text =
                                                      '${e.value}';
                                                });
                                              },
                                              child: Container(
                                                width: size.width * 0.125,
                                                height: size.height * 0.04,
                                                decoration: selectedIndex ==
                                                        e.key
                                                    ? BoxDecoration(
                                                        color: kPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      )
                                                    : BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2))),
                                                child: Center(
                                                  child: Text(
                                                    'N ${e.value}',
                                                    style:
                                                        GoogleFonts.robotoMono(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 10,
                                                            color:
                                                                selectedIndex ==
                                                                        e.key
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
                                  FormError(errors: errors),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
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
                                          currentView = 2;
                                        });
                                      }
                                    },
                                    btnTitle: 'Continue',
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: currentView == 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OTPTransaction(
                                  size: size,
                                  amount: 'N $amount',
                                  date: tfDate,
                                  userAccount: userAccountNumber,
                                  receipientNumber: phoneNum,
                                  transactPin: transactPin,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Transaction is required";
                                    } else if (value.length != 4) {
                                      return "Transaction pin is to short";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      pin = value;
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
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      // if all are valid then go to success screen
                                      KeyboardUtil.hideKeyboard(context);
                                      Navigator.of(context).pushReplacementNamed(AppRouteName.SuccessPage);

                                      // setState(() {
                                      //   currentView = 2;
                                      // });
                                    }
                                  },
                                  cancelOnTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 8,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}

