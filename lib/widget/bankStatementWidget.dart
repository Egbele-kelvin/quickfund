

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountTypeWidget extends StatelessWidget {
  const AccountTypeWidget({
    Key key,
    @required this.size,
    this.accountType,
    this.onTap,
    this.colorTap,
    this.textColor,
    this.borderRad,
  }) : super(key: key);

  final Size size;
  final String accountType;
  final Function onTap;
  final BorderRadiusGeometry borderRad;
  final Color colorTap, textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        // height: size.height*0.1,
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        decoration: BoxDecoration(
          color: colorTap,
          border: Border.all(color: Colors.grey.withOpacity(0.05)),
          borderRadius: borderRad,
        ),
        child: Text(
          accountType,
          style: GoogleFonts.poppins(
              fontSize: 11, fontWeight: FontWeight.w400, color: textColor),
        ),
      ),
    );
  }
}

class AccountTypeWidgetForBankStateMent extends StatelessWidget {
  const AccountTypeWidgetForBankStateMent({
    Key key,
    @required this.size,
    this.widgetCard,
  }) : super(key: key);

  final Size size;
  final Widget widgetCard;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        //padding: EdgeInsets.symmetric(vertical: 8),
        // height: size.height * 0.09,
        width: size.width * 0.3,
        decoration: BoxDecoration(
          //color: Colors.grey,
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10)),
        child: widgetCard,
      ),
    );
  }
}


class BankTypeProfiling{
  final String accountType, accountNumber;

  BankTypeProfiling({this.accountType, this.accountNumber});
}

class SelectDatePickerByFunmi extends StatelessWidget {
  final ValueChanged<DateTime> onDateTimeChanged;

  const SelectDatePickerByFunmi({Key key, this.onDateTimeChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.4,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).copyWith().size.width * 0.15,
                height: MediaQuery.of(context).copyWith().size.height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text(
                  'Done',
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            //  color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: onDateTimeChanged,
              initialDateTime: DateTime.now(),
              minimumYear: 1950,
              maximumYear: 2050,
            ),
          ),
        ],
      ),
    );
  }
}
