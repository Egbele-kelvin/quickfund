import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';

class CustomBottomSheetMenuItem extends StatelessWidget {
  const CustomBottomSheetMenuItem({
    this.customWidget,
  });

  final Widget customWidget;

  @override
  Widget build(BuildContext context) {
    return customWidget;
  }
}

class CustomDetails extends StatelessWidget {
  final String heading;

  const CustomDetails({
    Key key,
    this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 30),
        child: Text(
          heading,
          style: GoogleFonts.roboto(
              fontSize: 12.2, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class CustomItemWidget extends StatelessWidget {
  final String descriptionItem;
  final Function onTap;

  const CustomItemWidget({Key key, this.descriptionItem, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(5),
            vertical: getProportionateScreenHeight(5)),
        height: size.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            descriptionItem,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 13.5,
            ),
          ),
        ),
      ),
    );
  }
}

class BuildHelp extends StatelessWidget {
  final String helpText;
  final Function onTap;

  const BuildHelp({Key key, this.helpText, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap:onTap,
      child: Text(
        helpText,
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
class DashBoardHeader extends StatelessWidget {
  const DashBoardHeader({
    Key key,
    @required this.userName,
    this.imgrUrl,
    this.userAcct,
    this.notification,
  }) : super(key: key);

  final String userName, imgrUrl;
  final Function userAcct, notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        onTap: userAcct,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.withOpacity(0.3),
          backgroundImage: AssetImage(
            imgrUrl,
          ),
        ),
      ),
      title: Text(
        'Hi $userName',
        style: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
      ),
      trailing: InkWell(
        onTap: notification,
        child: Icon(
          Icons.notifications,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
class RecentTransactionHead extends StatelessWidget {
  const RecentTransactionHead({
    this.onTap,
  });

  final Function onTap;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Transactions',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.black),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Text(
            'See All',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
                fontSize: 11,
                color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class CardDetails extends StatelessWidget {
  const CardDetails({
    Key key,
    @required this.size,
    this.acctBalanceI,
    this.acctBalanceII,
    this.savingsAcct,
    this.accountNum,
    this.iconData, this.dashBoardColor,
  }) : super(key: key);

  final Size size;
  final String acctBalanceI, acctBalanceII, savingsAcct, accountNum;
  final IconData iconData;
  final Color dashBoardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: size.width * 0.9,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          color: dashBoardColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
            child: Text(
              acctBalanceI,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors.white),
            ),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
            child: Row(
              children: [
                Text(
                  acctBalanceII,
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: size.width * 0.2,
                ),
                Icon(
                  iconData,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: size.height * 0.055,
          ),
          Align(
            child: Text(
              savingsAcct,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors.white),
            ),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
            child: Text(
              accountNum,
              style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            alignment: Alignment.topLeft,
          ),
        ],
      ),
    );
  }
}

class CustomDashBoardCard extends StatelessWidget {
  const CustomDashBoardCard({
    Key key,
    @required this.size,
    this.cardTitle,
    this.cardIcon,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final String cardTitle;
  final IconData cardIcon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.42,
        height: size.height * 0.13,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Align(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 6.0),
                child: Container(
                  child: Icon(
                    cardIcon,
                    size: 15,
                    color: kTap,
                  ),
                  width: size.width * 0.07,
                  height: size.height * 0.033,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white),
                ),
              ),
              alignment: Alignment.topRight,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Align(
                child: Text(
                  cardTitle,
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                alignment: Alignment.bottomLeft,
              ),
            )
          ],
        ),
      ),
    );
  }
}


class TransactionHistorySummary extends StatelessWidget {
  const TransactionHistorySummary({
    Key key,
    @required this.size,
    @required this.tfDate,
    this.transferName,
    this.code,
    this.amount,
    this.igUrl,
    this.amountColor,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final String tfDate, transferName, code, amount, igUrl;
  final Color amountColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          height: size.height * 0.08,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.08))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(igUrl),
                  ),
                  padding: EdgeInsets.all(5),
                  width: size.width * 0.13,
                  height: size.height * 05,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                child: Container(
                  width: size.width * 0.5,
                  height: size.height * 05,
                  child: Column(
                    children: [
                      Align(
                        child: Text(
                          transferName,
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      SizedBox(
                        height: size.height * 0.011,
                      ),
                      Align(
                        child: Text(
                          code,
                          style: GoogleFonts.roboto(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.withOpacity(1)),
                        ),
                        alignment: Alignment.bottomLeft,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 5 , vertical: 2),
                  width: size.width * 0.2,
                  height: size.height * 05,
                  child: Column(
                    children: [
                      Align(
                        child: Text(
                          amount,
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: amountColor),
                        ),
                        alignment: Alignment.topRight,
                      ),
                      SizedBox(
                        height: size.height * 0.011,
                      ),
                      Align(
                        child: Text(
                          tfDate,
                          style: GoogleFonts.roboto(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.withOpacity(1)),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
