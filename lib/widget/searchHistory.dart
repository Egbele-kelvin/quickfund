import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

import 'custom_search.dart';

class TransactionHistoryDateCalender extends StatelessWidget {
  const TransactionHistoryDateCalender({
    Key key,
    @required this.size,
    @required this.searchController,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final TextEditingController searchController;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          width: size.width / 1.19,
          child: SearchBoxWidget(
            searchController: searchController,
            onSubmitted: (val) {},
            onEditingComplete: () {},
            onChanged: (val) {},
            onEditing: (val) {},
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: size.width * 0.1,
            child: SvgPicture.asset(
              'assets/f_svg/calender.svg',
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}

class TransactionButton extends StatelessWidget {
  const TransactionButton({
    Key key,
    @required this.size,
    this.proceed, this.onTap,
  }) : super(key: key);

  final Size size;
  final Function onTap;
  final String proceed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          top: 35,
          right: 45,
          left: 45,
        ),
        height: size.height * 0.046,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kPrimaryColor,
        ),
        child: Center(
          child: Text(
            proceed,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400, fontSize: 11, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CustomDateSelect extends StatelessWidget {
  const CustomDateSelect({
    Key key,
    @required this.size,
    this.dateValue,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final String dateValue;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: size.width *0.05,
      child: Row(
        children: [
          Text(
            dateValue,
            style: GoogleFonts.openSans(fontSize: 11, color: Colors.black),
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                'assets/f_svg/calender.svg',
                width: 10,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }
}
class SelectDateRange extends StatefulWidget {
  const SelectDateRange({
    Key key,
    @required this.size,
    this.proceedOnTap,
    this.fromDateSelect,
    this.toDateSelect,
    this.fromDate,
    this.toDate,
  }) : super(key: key);

  final Size size;
  final Function proceedOnTap, fromDateSelect, toDateSelect;
  final String fromDate, toDate;

  @override
  _SelectDateRangeState createState() => _SelectDateRangeState();
}

class _SelectDateRangeState extends State<SelectDateRange> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'From Date',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 11,
              ),
            ),
            Text(
              'To Date',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 11,
              ),
            ),
          ],
        ),
        SizedBox(
          height: widget.size.height * 0.007,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomDateSelect(
              size: widget.size,
              onTap: widget.fromDateSelect,
              dateValue: widget.fromDate,
            ),
            CustomDateSelect(
                size: widget.size, onTap: widget.toDateSelect, dateValue: widget.toDate),
          ],
        ),
        TransactionButton(
          onTap: widget.proceedOnTap,
          size: widget.size,
          proceed: 'proceed',
        )
      ],
    );
  }
}
