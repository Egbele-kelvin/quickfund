import 'package:flutter/material.dart';
import 'package:quickfund/util/size_config.dart';

const kPrimaryColor = Color(0xFFFF4C4C);
const kSelectMenuColor = Color(0xFFD02F32);
const kTap = Color(0xFFCE2E31);
const kPrimaryLightColor = Color(0xFFFFECDF);
const Color colorPrimaryLightPurple = Color(0XFF6C63FF);
const Color colorPrimaryWhite = Color(0XFFFFFFFF);
const Color colorPrimaryLightPink = Color(0XFFFF0077);

// static const Color colorPrimaryLight = const Color(0XFF27C8D9);
const Color colorPrimaryLightYellow = Color(0xffFFB300);
const Color colorPrimaryBlack = Color(0XFF000000);
Color colorPrimaryLightYellowDashBoard = Color(0XFFFFC300).withOpacity(0.8);
 Color colorGeryField = Color(0XFFF5F6F8);
 Color colorPin = Color(0XFFEAECEF);
const Color colorPrimaryRed = Color(0XFFDB0011);
const Color colorPrimaryLightGreen = Color(0XFF17C261);
const Color colorPrimaryBlue = Color(0XFF1E32FA);
const Color kShadowColor = Color(0XFFFCCCCC);
const Color kDashBoardCardColor = Color(0XFFF57B7B);


const Color colorGrey = Colors.grey;
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kPinNullError = "Please Enter your pin";
const String kShortPinError = "pin is too short";
const String kBVNNullError = "Please Enter your BVN";
const String kPhoneNumberNullError = "Please Enter your Phone Number";
const String kSecurityNullError = "Please Enter your security answer";
const String kShortPassError = "Password is too short";
const String kShortPhoneNumberError = "Phone Number is too short";
const String kShortBVNError = "BVN is too short";
const String kShortLoanError = "Amount is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kAddressNullError = "Please Enter your address";
const String kSalaryAmountNullError = "Please Enter your Salary";
const String kLoanAmountNullErrorII = "Loan amount should\'nt exceed 1,000,000";
const String kLoanAmountNullError = "Please Enter Loan Amount";
const String kAmount = "Please Enter Amount";
const String basURL = "http://3.144.238.224";



const String kIsBiometricOn = 'isBiometricsOn';
const String kHasAlreadyLogin = 'hasNeverLogin';
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
