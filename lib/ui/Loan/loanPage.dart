import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_expandable.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/form_error.dart';

Iterable<int> get positiveIntegers sync* {
  int i = 0;
  while (true) yield i++;
}

class LoanPageUI extends StatefulWidget {
  @override
  _LoanPageUIState createState() => _LoanPageUIState();
}

class _LoanPageUIState extends State<LoanPageUI> {
  bool setImage, assetsImageUrl = false;
  int selectedIndex;
  bool _passwordVisible;
  String title, userName = 'Bose', salary, loanAmount, purposeOfLoan;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  final List<String> selectPurpose = [
    'House Rent',
    'Hospital Bill',
    'Burial',
    'Fashion',
    'School Fees',
    'Vacation',
    'Shopping',
    'Car Purchase',
    'Birthday',
    'Wedding',
    'Family'
  ];

  var listOfIntegers = positiveIntegers
      .skip(3) // don't use 0
      .take(10) // take 10 numbers
      .toList(); // create a list

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

  bool _isExpanded = false;
  double _currentSliderValue = 5, minLoan = 3, maxLoan = 12;

  String currentSlideValue = '3 Month';

  void _toogleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
  void _handleCalculation() {

    //  Amortization
    //  A = Payemtn amount per period
    //  P = Initial Printical (loan amount)
    //  r = interest rate
    //  n = total number of payments or periods

    // double A = 0.0;
    // int P = int.parse(_principalAmount.text);
    // double r = int.parse(_interestRate.text) / 12 / 100;
    // int n = _tenureType == "Year(s)" ? int.parse(_tenure.text) * 12  : int.parse(_tenure.text);
    //
    // A = (P * r * pow((1+r), n) / ( pow((1+r),n) -1));
    //
    // _emiResult = A.toStringAsFixed(2);
    //
    // setState(() {
    //
    // });
  }

  @override
  void initState() {
    _passwordVisible = false;
    print(listOfIntegers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                  //onBackPress();
                  Navigator.pop(context);
                },
                pageTitle: 'Salary Loan',
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
                        RoundedInputField(
                          onSaved: (newValue) => salary = newValue,
                          inputType: TextInputType.text,
                          labelText: 'what\'s your monthly Salary',
                          customTextHintStyle: GoogleFonts.lato(
                              fontSize: 12,
                              color: Colors.black54.withOpacity(0.3),
                              fontWeight: FontWeight.w600),
                          hintText: 'what\'s your monthly Salary',
                          autoCorrect: true,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kSalaryAmountNullError);
                            }
                            return null;
                          },

                          validateForm: (value) {
                            if (value.isEmpty) {
                              addError(error: kSalaryAmountNullError);
                              return "";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        RoundedInputField(
                          suffixIcon: InkWell(
                            onTap: () {
                              _toogleExpand();
                            },
                            child: Icon(
                              _isExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: kDashBoardCardColor,
                            ),
                          ),
                          hasFocus: AlwaysDisabledFocusNode(),
                          // onSaved: (newValue) => bvn = newValue,
                          onSaved: (newValue) => purposeOfLoan = newValue,
                          inputType: TextInputType.text,
                          maxLen: 11,
                          labelText: 'what\'s the purpose of the loan',
                          customTextHintStyle: GoogleFonts.lato(
                              fontSize: 12,
                              color: Colors.black54.withOpacity(0.3),
                              fontWeight: FontWeight.w600),
                          hintText: title,
                          autoCorrect: true,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        ExpandedSection(
                          expand: _isExpanded,
                          child: Container(
                            width: double.infinity,
                            height: size.height * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade200)),
                            child: Wrap(
                                direction: Axis.horizontal,
                                children: selectPurpose
                                    .asMap()
                                    .entries
                                    .map((e) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              // title = selectPurpose.toList() as String;
                                              selectedIndex = e.key;
                                              title = e.value;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.5, vertical: 8),
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              width: size.width * 0.2,
                                              height: size.height * 0.02,
                                              decoration: selectedIndex == e.key
                                                  ? BoxDecoration(
                                                      color: kDashBoardCardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))
                                                  : BoxDecoration(
                                                      //color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                              child: Center(
                                                child: Text(
                                                  e.value,
                                                  //  textAlign: TextAlign.center,
                                                  style: GoogleFonts.roboto(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 10,
                                                      color:
                                                          selectedIndex == e.key
                                                              ? Colors.white
                                                              : Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Column(
                          children: [
                            RoundedInputField(
                              // onSaved: (newValue) => bvn = newValue,
                              onSaved: (newValue) => loanAmount = newValue,
                              inputType: TextInputType.text,
                              maxLen: 7,
                              labelText: 'Loan Amount',
                              customTextHintStyle: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.black54.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                              hintText: 'Loan Amount',
                              autoCorrect: true,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: kLoanAmountNullError);
                                } else if (value.length >= 5) {
                                  removeError(error: kShortLoanError);
                                }
                                return null;
                              },

                              validateForm: (value) {
                                if (value.isEmpty) {
                                  addError(error: kLoanAmountNullError);
                                  return "";
                                } else if (value.length < 5) {
                                  addError(error: kShortLoanError);
                                  return "";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Min amount: #50,000.00',
                                  style: GoogleFonts.roboto(
                                      fontSize: 8.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Max amount: #1,000,000.00',
                                  style: GoogleFonts.roboto(
                                      fontSize: 8.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            // Align(
                            //   alignment: Alignment.topLeft,
                            //   child: Text(
                            //     'Min months: 3',
                            //     style: GoogleFonts.roboto(
                            //         fontSize: 8.5,
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.w400),
                            //   ),
                            // ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.red[700],
                                          inactiveTrackColor: Colors.red[100],
                                          trackShape: RoundedRectSliderTrackShape(),
                                          trackHeight: 12.0,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 18.0),
                                          thumbColor: Colors.redAccent,
                                          overlayColor: Colors.red.withAlpha(32),
                                          overlayShape: RoundSliderOverlayShape(
                                              overlayRadius: 28.0),
                                          tickMarkShape: RoundSliderTickMarkShape(),
                                          activeTickMarkColor: Colors.red[700],
                                          inactiveTickMarkColor: Colors.red[100],
                                          valueIndicatorShape:
                                              PaddleSliderValueIndicatorShape(),
                                          valueIndicatorColor: Colors.redAccent,
                                          valueIndicatorTextStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Slider(
                                          value: _currentSliderValue,
                                          min: minLoan,
                                          max: maxLoan,
                                          divisions: 9,
                                          label: '$_currentSliderValue',
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                _currentSliderValue = value;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: listOfIntegers
                                      .asMap()
                                      .entries
                                      .map((e) => Text(
                                    '${e.value}',
                                    style: GoogleFonts.roboto(
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ))
                                      .toList(),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            Text(
                              'Monthly Repayment',
                              style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Text(
                              'N 19,000',
                              style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
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
                                }
                              },
                              btnTitle: 'Proceed',
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
