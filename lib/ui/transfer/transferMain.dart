import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:quickfund/model/accountModel.dart';
import 'package:quickfund/ui/signup/account_opening/accountOpeningWidget.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:quickfund/widget/save_beneficiary_widget.dart';
import 'package:quickfund/widget/transactionPinUI.dart';

class TransferComponent extends StatefulWidget {
  const TransferComponent({Key key}) : super(key: key);

  @override
  _TransferComponentState createState() => _TransferComponentState();
}

class _TransferComponentState extends State<TransferComponent> {
  bool _isExpanded = false;
  TextEditingController accountNameData = TextEditingController();
  TextEditingController accountNumData = TextEditingController();
  TextEditingController amountController = TextEditingController();

  TextEditingController transactPin;
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  bool showDataplan = false, showPhoneEdit = false, _btnEnabled = false;
  String bankName = 'Select Bank', amount, accountName, accountNum, note;
  String initialAmount, pin;
  int currentView = 0;

  void _toogleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
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

  List<AccountName> accountNames = [
    AccountName(firstName: 'Funmi', lastName: 'Tope'),
    AccountName(firstName: 'Olashile', lastName: 'Adebajo'),
    AccountName(firstName: 'Kunle', lastName: 'Oyewole'),
    AccountName(firstName: 'Sarah', lastName: 'Claire'),
    AccountName(firstName: 'Summer', lastName: 'Bitch'),
    AccountName(firstName: 'Saheed', lastName: 'Shegun'),
    AccountName(firstName: 'kel', lastName: 'ParthClan'),
    AccountName(firstName: 'duvet', lastName: 'regularly'),
    AccountName(firstName: 'cheatty', lastName: 'Catrine'),
  ];

  List<String> bankList = [
    'Access Bank',
    'GTB',
    'Eco Bank',
    'Fidelity Bank',
    'First Bank',
    'Zenith Bank'
  ];
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

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

  Future<dynamic> buildShowModalBottomSheetForUserTitle(
      BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
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
          // final postMdl = Provider.of<BankProvider>(context);
          return WillPopScope(
            onWillPop: () async {
              // listener dismiss
              return true;
            },
            child: CustomBottomSheetMenuItem(
              customWidget: Column(
                children: [
                  CustomDetails(
                    heading: 'List of Bank',
                    // onTap: () {
                    //   Navigator.of(context).pop();
                    // },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return CustomItemWidget(
                            onTap: () {
                              setState(() {
                                bankName = bankList[index];
                              });

                              Navigator.of(context).pop();
                            },
                            descriptionItem: bankList[index],
                          );
                        },
                        separatorBuilder: (context, index) => Container(),
                        itemCount: bankList.length),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    amountController = TextEditingController();
    amountController.addListener(() {
      final text = amountController.text.toLowerCase();
      if (text.isNotEmpty) {
        print(text.replaceAll('[,]', ''));
        amountController.value = amountController.value.copyWith(
          text: Money.from(num.parse(text.replaceAll(RegExp(r'[,]'), '')),
                  Currency.create('USD', 0))
              .format('#,###'),
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      }
    });

    super.initState();
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
                child: CustomAppBar(
                  onTap: () {
                    // Navigator.pop(context);
                    onBackPress();
                    // Navigator.pushReplacementNamed(
                    //     context, AppRouteName.DASHBOARD);
                  },
                  pageTitle: 'Enter Transfer Details',
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
                    horizontal: getProportionateScreenWidth(10.0),
                    vertical: getProportionateScreenHeight(10.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Visibility(
                        visible: currentView==0,
                        child: Expanded(
                          flex: 9,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: ChooseFromSavedBeneficiary(
                                      size: size,
                                      rowListForBeneficiary: accountNames
                                          .asMap()
                                          .entries
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkResponse(
                                                  onTap: (){
                                                    setState(() {

                                                      bankName='GT Bank';
                                                      accountNumData.text =e.key.toString();

                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            kPrimaryColor
                                                                .withOpacity(0.1),
                                                        child: Text(
                                                          '${e.value.firstName.substring(0, 1)} ' +
                                                              ' ${e.value.lastName.substring(0, 1)}',
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.01,
                                                      ),
                                                      Text(
                                                        '${e.value.firstName} ' +
                                                            ' ${e.value.lastName}',
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 9,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList()),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: SingleChildScrollView(
                                  // slivers: [
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(10.0),
                                        vertical:
                                            getProportionateScreenHeight(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Column(children: [
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                            RoundedInputField(
                                            maxLen: 7,
                                            controller: amountController,
                                            // onSaved: (newValue) => bvn = newValue,
                                            onSaved: (newValue) =>
                                                amount = newValue,
                                            inputType: TextInputType.number,
                                            labelText: 'Amount',
                                            customTextHintStyle:
                                                GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black54
                                                        .withOpacity(0.3),
                                                    fontWeight:
                                                        FontWeight.w500),
                                            autoCorrect: true,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                removeError(
                                                    error:
                                                        'Amount is required');
                                              }
                                              return null;
                                            },

                                            validateForm: (value) {
                                              if (value.isEmpty) {
                                                addError(
                                                    error:
                                                        'Amount is required');
                                                return "";
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          SelectedCustom(
                                            size: size,
                                            onTap: () {
                                              buildShowModalBottomSheetForUserTitle(
                                                  context, size);
                                            },
                                            title: bankName,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          RoundedInputField(
                                            controller: accountNumData,
                                            // onSaved: (newValue) => bvn = newValue,
                                            onSaved: (newValue) =>
                                                accountNum = newValue,
                                            inputType: TextInputType.text,
                                            maxLen: 11,
                                            labelText: 'Account Number',
                                            customTextHintStyle:
                                                GoogleFonts.lato(
                                                    fontSize: 12,
                                                    color: Colors.black54
                                                        .withOpacity(0.3),
                                                    fontWeight:
                                                        FontWeight.w600),
                                            autoCorrect: true,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                removeError(
                                                    error:
                                                        'Amount is required');
                                              }
                                              return null;
                                            },

                                            validateForm: (value) {
                                              if (value.isEmpty) {
                                                addError(
                                                    error:
                                                        'Amount is required');
                                                return "";
                                              }
                                              return null;
                                            },
                                          ),
                                            SizedBox(
                                              height: size.height * 0.03,
                                            ),
                                            RoundedInputField(
                                              // onSaved: (newValue) => bvn = newValue,
                                              onSaved: (newValue) =>
                                              note = newValue,
                                              inputType: TextInputType.text,
                                              labelText: 'Note',
                                              customTextHintStyle: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  color:
                                                  Colors.black54.withOpacity(0.3),
                                                  fontWeight: FontWeight.w600),
                                              autoCorrect: true,
                                            ),
                                            FormError(errors: errors),
                                            SizedBox(
                                              height: size.height * 0.07,
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

                                                    currentView=1;
                                                  });
                                                }
                                              },
                                              btnTitle: 'Continue',
                                            ),
                                          ]),

                                          Visibility(
                                            visible: currentView == 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: OTPTransaction(
                                                size: size,
                                                amount: 'N $amount',
                                                date: tfDate,
                                                userAccount: bankName ,
                                                receipientNumber: accountNum,
                                               transactPin: transactPin,
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
                                        ],
                                      ),
                                    ),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: currentView == 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OTPTransaction(
                            size: size,
                            amount: 'N $amount',
                            date: tfDate,
                            userAccount: bankName,
                            receipientNumber: accountNum,
                            transactPin: transactPin,
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
