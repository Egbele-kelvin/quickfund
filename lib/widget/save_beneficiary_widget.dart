import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

class ChooseFromSavedBeneficiary extends StatelessWidget {
  const ChooseFromSavedBeneficiary({
    Key key,
    @required this.size,
    this.rowListForBeneficiary,
    this.onTapToCheckSave,
  }) : super(key: key);

  final Size size;
  final List<Widget> rowListForBeneficiary;
  final Function onTapToCheckSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      // color: Colors.black,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Choose from saved beneficiary',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 10, color: Colors.black),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 0,
                child: SizedBox(
                  width: size.width * 0.2,
                  //height: size.height * 0.16,
                  child: InkWell(
                    onTap: onTapToCheckSave,
                    child: Column(
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: kDashBoardCardColor.withOpacity(0.1),
                            child: Icon(
                              Icons.account_circle_sharp,
                              size: 25,
                              color: kPrimaryColor,
                            )),
                        Container()
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: rowListForBeneficiary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChooseFromBeneficiaryWidget extends StatelessWidget {
  const ChooseFromBeneficiaryWidget({
    Key key,
    @required this.size,
    this.accountName,
    this.onTapToSetSaveBeneficiary,
  }) : super(key: key);

  final Size size;
  final Function onTapToSetSaveBeneficiary;
  final String accountName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapToSetSaveBeneficiary,
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: Container(
          width: size.width * 0.22,
        //  height: size.height * 0.16,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: kDashBoardCardColor.withOpacity(0.1),
                    child: Icon(
                      Icons.account_circle_sharp,
                      size: 25,
                      color: kPrimaryColor,
                    )),
              ),
              Text(
                accountName,
                style: GoogleFonts.roboto(
                    fontSize: 8.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
