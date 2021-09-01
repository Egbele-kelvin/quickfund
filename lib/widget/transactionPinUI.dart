import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickfund/util/constants.dart';

import 'customReferenceWidget.dart';
import 'custom_button.dart';
import 'custom_widgets.dart';

class OTPTransaction extends StatelessWidget {
  const OTPTransaction(
      {Key key,
        this.size,
        this.transactPin,
        this.onChanged,
        this.onComplete,
        this.userAccount,
        this.receipientNumber,
        this.date,
        this.amount, this.onTap, this.cancelOnTap})
      : super(key: key);
  final Size size;
  final transactPin;
  final String userAccount, receipientNumber, date, amount;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onComplete;
  final Function onTap , cancelOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SummaryRe(
              size: size,
              tag: 'From',
              labelI: userAccount,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SummaryRe(
              size: size,
              tag: 'To',
              labelI: receipientNumber,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SummaryRe(
              size: size,
              tag: 'Date',
              labelI: date,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SummaryRe(
              size: size,
              tag: 'Amount',
              labelI: amount,
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Text(
          'Enter transaction Pin',
          style: GoogleFonts.roboto(
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15),
          child: PinCodeTextField(
            controller: transactPin,
            textStyle: TextStyle(fontWeight: FontWeight.normal),
            cursorColor: kPrimaryColor,
            cursorHeight: 10,
            onCompleted: onComplete,
            onChanged: onChanged,
            obscureText: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            enableActiveFill: true,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 45,
                selectedFillColor: Colors.grey.withOpacity(0.1),
                disabledColor: Colors.white,
                selectedColor: Colors.white,
                fieldWidth: 45,
                activeColor: kPrimaryColor,
                inactiveColor: Colors.grey.withOpacity(0.15),
                inactiveFillColor: Colors.white,
                activeFillColor: colorPrimaryWhite),
            length: 4,
            appContext: context,
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        CustomSignInButton(
          size: size,
          onTap: onTap,
          btnTitle: 'Continue',
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        CancelTranasactionProcess(
          onTap: cancelOnTap,
        ),
      ],
    );
  }
}
