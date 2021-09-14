import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          color: kPrimaryColor,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Transactions',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 12,
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
      ),
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
    this.iconData,
    this.dashBoardColor,
    this.gestureTap,
    this.iconWidget,
  }) : super(key: key);

  final Size size;
  final String acctBalanceI, acctBalanceII, savingsAcct, accountNum;
  final IconData iconData;
  final Color dashBoardColor;
  final Function gestureTap;
  final Widget iconWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: size.width * 0.9,
      height: size.height * 0.18,
      decoration: BoxDecoration(
          color: dashBoardColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  acctBalanceI,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                      color: Colors.white),
                ),
                
                GestureDetector(
                    onTap: gestureTap,
                    child: Icon(Icons.add_circle , color: Colors.white,))

              ],
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
                      fontSize: 12.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: size.width * 0.2,
                ),
                // Icon(
                //   iconData,
                //   size: 20,
                //   color: Colors.white,
                // ),

                iconWidget,
              ],
            ),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Align(
            child: Text(
              savingsAcct,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
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
          color: kDashBoardCardColor,
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
                      borderRadius: BorderRadius.circular(30),
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
                      fontSize: 11,
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
          height: size.height * 0.1,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.08))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.only(left: 6,top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.exchangeAlt,color: kPrimaryColor,size: 15,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                child: Container(
                  width: size.width * 0.5,
                  height: size.height * 08,
                  child: Column(
                    children: [
                      Align(
                        child: Text(
                          transferName,
                          style: GoogleFonts.roboto(
                              fontSize: 9.3,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      SizedBox(
                        height: size.height * 0.00678,
                      ),
                      Align(
                        child: Text(
                          code,
                          style: GoogleFonts.roboto(
                              fontSize: 8.5,
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
                  //height: size.height * 0.5,
                  child: Column(
                    children: [
                      Align(
                        child: Text(
                          amount,
                          style: GoogleFonts.roboto(
                              fontSize: 8.7,
                              fontWeight: FontWeight.w400,
                              color: amountColor),
                        ),
                        alignment: Alignment.topRight,
                      ),
                      SizedBox(
                        height: size.height * 0.00678,
                      ),
                      Align(
                        child: Text(
                          tfDate,
                          style: GoogleFonts.roboto(
                              fontSize: 9,
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

class HorizontalLineForAccountSetting extends StatelessWidget {
  const HorizontalLineForAccountSetting({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: size.height *0.006,
        decoration: BoxDecoration(
            color:kPrimaryColor ,
            borderRadius: BorderRadius.circular(
                30
            )
        ),

      ),
    );
  }
}


class AccountSettingProfile extends StatelessWidget {
  const AccountSettingProfile({
    Key key,
    @required this.size,
    this.imgURL,
  }) : super(key: key);

  final Size size;
  final String imgURL;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      //bottom: size.height,
        top: 150,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(140)),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade50,
            radius: 50,
            child: Image.asset(
              imgURL,
              width: size.width * 0.2,
              height: size.height * 0.2,
            ),
          ),
        ));
  }
}



class AccountSettingCardMenu extends StatelessWidget {
  const AccountSettingCardMenu({
    Key key,
    @required this.size,
    this.onTap,
    this.lable,
    this.imgURL, this.iconData,
  }) : super(key: key);

  final Size size;
  final Function onTap;
  final String lable, imgURL;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: size.height * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        radius: 24,
                        backgroundColor: kPrimaryColor,
                        child: SvgPicture.asset(imgURL)),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      lable,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 20,
                )
              ],
            )),
      ),
    );
  }
}

class BeneficiaryCard extends StatelessWidget {
  const BeneficiaryCard({
    Key key,
    @required this.size,
    this.accountName,
    this.accountNum,
    this.bankName,
    this.moreTap,
    this.deleteTap,
    this.imgURL,
  }) : super(key: key);

  final Size size;
  final String imgURL, accountName, accountNum, bankName;
  final Function moreTap, deleteTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: moreTap,
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: deleteTap,
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
        child: Container(
          height: size.height * 0.1,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(
              color: Colors.grey.withOpacity(0.03),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade50,
                  radius: 35,
                  child: Image.asset(
                    imgURL,
                    width: size.width * 0.1,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Container(
                alignment: Alignment.topLeft,
                width: size.width * 0.6,
                height: size.height * 0.085,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      child: Text(
                        accountNum,
                        style: GoogleFonts.lato(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Align(
                      child: Text(
                        accountName,
                        style: GoogleFonts.lato(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Align(
                      child: Text(
                        bankName,
                        style: GoogleFonts.lato(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.stacked_bar_chart,
                    size: 15,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuyingAirtimeCustomPlaceHolder extends StatelessWidget {
  const BuyingAirtimeCustomPlaceHolder({
    Key key,
    @required this.size,
    @required this.airtimeType,
  }) : super(key: key);

  final Size size;
  final String airtimeType;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SvgPicture.asset(
        'assets/f_svg/${airtimeType.toLowerCase()}.svg',
        width: size.width * 0.1,
        height: size.height *0.05,
      ),
    );
  }
}
class CancelTranasactionProcess extends StatelessWidget {
  const CancelTranasactionProcess({
    Key key,
    this.onTap,
  }) : super(key: key);
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Cancel',
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400, color: Colors.black, fontSize: 12),
      ),
    );
  }
}

class SelectAmountWidget extends StatelessWidget {
  const SelectAmountWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          'Or Select amount',
          style: GoogleFonts.robotoMono(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
