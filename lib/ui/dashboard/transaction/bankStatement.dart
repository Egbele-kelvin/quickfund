import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/ui/signup/account_opening/accountOpeningWidget.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/bankStatementWidget.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_expandable.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class BankStatement extends StatefulWidget {
  @override
  _BankStatementState createState() => _BankStatementState();
}

class _BankStatementState extends State<BankStatement> {
  bool isExpanded = false;
  int selectIndex;
  dynamic accountNum = '0119695695',
      acctBalance = '239,600',
      issueDate = 'Select Start Date',
      expiryDate = 'Select End Date';
  DateTime selectedDate = DateTime.now();
  DateTime issueDat = DateTime.now();
  DateTime expiryDat = DateTime.now();

  List selectFileType = ['pdf', 'xls'];
  final dateOfBirth = TextEditingController();
  final issuedDate = TextEditingController();
  final expiredDate = TextEditingController();

  _selectExpiryDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      return buildMaterialDatePickerForExpiryDate(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePickerForExpiryDate(context);
    }
  }
  _selectIssuedDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      return buildMaterialDatePickerForIssuedDate(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePickerForIssuedDate(context);
    }
  }

  //
  /// This builds material date picker in Android
  buildMaterialDatePickerForIssuedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      cancelText: 'Cancel',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null)
      setState(() {
        issuedDate.text =DateFormat('dd-MM-yyyy').format(picked);
        print('issueDate : ${issuedDate.text}');
      });
  }

  buildCupertinoDatePickerForIssuedDate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SelectDatePickerByFunmi(
            onDateTimeChanged: (picked) {
              if (picked != null) {
                setState(() {
                  issuedDate.text = DateFormat('dd-MM-yyyy').format(picked);
                });

                print('date : ${issuedDate.text}');
              }
            },
          );
        });
  }  /// This builds material date picker in Android
  buildMaterialDatePickerForExpiryDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      cancelText: 'Cancel',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null)
      setState(() {
        expiredDate.text =DateFormat('dd-MM-yyyy').format(picked);
        print('issueDate : $expiredDate');
      });
  }

  buildCupertinoDatePickerForExpiryDate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SelectDatePickerByFunmi(
            onDateTimeChanged: (picked) {
              if (picked != null) {
                setState(() {
                  expiredDate.text = DateFormat('dd-MM-yyyy').format(picked);
                });

                print('date : ${expiredDate.text}');
              }
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  _toggleAccountType() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  List<BankTypeProfiling> accountType = [
    BankTypeProfiling(accountNumber: '1205695939', accountType: 'Savings'),
    BankTypeProfiling(accountType: 'Current', accountNumber: '8059329495')
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              //color: kPrimaryColor,
              child: CustomAppBar(
                onTap: () {
                  //onBackPress();
                  Navigator.pushReplacementNamed(
                      context, AppRouteName.DASHBOARD);
                },
                pageTitle: 'Bank Statement',
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
                  horizontal: getProportionateScreenWidth(20.0),
                  vertical: getProportionateScreenHeight(10.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Expanded(
                      flex: 10,
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(children: [
                              SelectedCustom(
                                size: size,
                                onTap: () {
                                  _toggleAccountType();
                                },
                                title: accountNum,
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              ExpandedSection(
                                expand: isExpanded,
                                child: AccountTypeWidgetForBankStateMent(
                                  size: size,
                                  widgetCard: Column(
                                    children: accountType
                                        .asMap()
                                        .entries
                                        .map((e) => AccountTypeWidget(
                                              borderRad: selectIndex == e.key
                                                  ? BorderRadius.circular(4)
                                                  : BorderRadius.circular(0),
                                              onTap: () {
                                                setState(() {
                                                  selectIndex = e.key;
                                                  accountNum =
                                                      e.value.accountNumber;
                                                });
                                                print(selectIndex);
                                              },
                                              textColor: selectIndex == e.key
                                                  ? Colors.white
                                                  : Colors.black,
                                              colorTap: selectIndex == e.key
                                                  ? kPrimaryColor
                                                  : Colors.transparent,
                                              size: size,
                                              accountType: e.value.accountType,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              RoundedInputField(
                                controller: issuedDate,
                                suffixIcon:Icon(Icons.calendar_today_sharp, color: kPrimaryColor,size: 15,),
                                readOnly: true,
                                onTap: () {
                                  _selectIssuedDate(context);
                                  },
                                maxLen: 11,
                                hintText: 'Select Start Date',
                                autoCorrect: true,
                                validateForm: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter date.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              RoundedInputField(
                                suffixIcon:Icon(Icons.calendar_today_sharp, color: kPrimaryColor,size: 15,),
                                controller: expiredDate,
                                readOnly: true,
                                onTap: () {
                                  _selectExpiryDate(context);
                                },
                                maxLen: 11,
                                hintText: 'Select End Date',
                                autoCorrect: true,
                                validateForm: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter date.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Choose File Type',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  FileTypeWidget(
                                    onTap: () {},
                                    selectFileType: selectFileType,
                                    size: size,
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

