import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
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


class PayBillDataProvider extends StatelessWidget {
  const PayBillDataProvider({
    Key key, this.title, this.svgURL, this.onTap,
  }) : super(key: key);

  final String title, svgURL;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 1),
              height: size.height * 0.04,
              width: size.width * 0.09,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(40),
              //     border: Border.all(
              //       color: kPrimaryColor.withOpacity(0.6),
              //       width: 1,
              //     ),
              // ),
              child: Image.asset(svgURL),
            ),
            title: Text( title , style: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black
            ),),
            trailing: Icon(Icons.chevron_right, color: Colors.grey.withOpacity(0.5),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: CustomHorizonDividerForProfile(),
          )
        ],
      ),
    );
  }
}
class DataWidget extends StatelessWidget {
  const DataWidget({
    Key key,
    @required this.airtimeType,
    @required this.size, this.imgUrl, this.payBillData,
  }) : super(key: key);

  final String airtimeType ,payBillData, imgUrl;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 10.0,
          leading: SvgPicture.asset(
              imgUrl,
              width: size.width * 0.1,
              height: size.height * 0.05),
          title: Text(
            airtimeType ?? '',
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white
            ),
          ),
          subtitle: Text(payBillData, style: GoogleFonts.nunito(
              color: Color(0xffBB9A8C),
              fontSize: 12
          ),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomHorizonDividerForProfile(),
        )
      ],
    );
  }
}
class SelectFromContactWidgetText extends StatelessWidget {
  const SelectFromContactWidgetText({
    Key key,
    this.onTap,
  }) : super(key: key);
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          'Select from phone contacts',
          style: GoogleFonts.nunito(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
class CustomHorizonDividerForProfile extends StatelessWidget {
  const CustomHorizonDividerForProfile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
    );
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
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 22),
        child: Text(
          heading,
          style: GoogleFonts.nunito(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
          radius: 25,
          backgroundColor: Colors.grey.withOpacity(0.3),
          backgroundImage: imgrUrl ==null ? AssetImage(
            'assets/f_png/businessman.png',
          ) : NetworkImage(imgrUrl),
        ),
      ),
      title: Text(
        'Hi $userName',
        style: GoogleFonts.nunito(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      trailing: InkWell(
        onTap: notification,
        child: Icon(
          Icons.notifications,
          size:20,
          color: Colors.black.withOpacity(0.53),
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
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Text(
              'See All',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w400,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        // width: size.width * 0.9,
        width: double.infinity,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/f_png/dashboardbg.png'),
            fit: BoxFit.cover
          ),
           color: dashBoardColor,
            borderRadius: BorderRadius.circular(6)
          ),
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
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
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
                    style: GoogleFonts.nunito(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
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
              height: size.height * 0.01,
            ),
            Align(
              child: Text(
                'Account Number',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w400,
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
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              alignment: Alignment.topLeft,
            ),
          ],
        ),
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
    this.onTap, this.color, this.cardTitleColor, this.imgColor,
  }) : super(key: key);

  final Size size;
  final String cardTitle;
  final String cardIcon;
  final Function onTap;
  final Color color,cardTitleColor,imgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.41,
        height: size.height * 0.135,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade50,
           // width: size.width *0.1
          ),
          color:color==null ? kDashBoardCardColor:color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Align(
              child: Padding(
                padding:
                 EdgeInsets.symmetric(horizontal: 8, vertical: 6.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15,
                  child: SvgPicture.asset(
                    cardIcon,
                    // fit: BoxFit.fill,
                    width: size.width *0.03,
                   // cacheColorFilter: true,
                    color: imgColor==null ? kPrimaryColor: imgColor,
                  ),
                )
              ),
              alignment: Alignment.topRight,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Align(
                child: Text(
                  cardTitle,
                  style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color:cardTitleColor==null ?  Colors.white:cardTitleColor),
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
    this.onTap, this.isPending,
  }) : super(key: key);

  final Size size;
  final bool isPending;
  final String tfDate, transferName, code, amount, igUrl;
  final Color amountColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
        child: Container(
          height: size.height * 0.07,
          width: double.infinity,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(color: Colors.grey.withOpacity(0.2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child:Icon(Icons.swap_horiz_rounded,  color: !isPending ? Colors.green : kPrimaryColor,),
                 // padding: EdgeInsets.all(5),
                  width: size.width * 0.13,
                  // decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //   border: Border.all(
                  //       color: !isPending ? Colors.green : kPrimaryColor
                  //   )
                  // ),
                ),
              ),
              Container(
                width: size.width * 0.5,
                height: size.height * 08,
                child: Column(
                  children: [
                    Expanded(
                      flex:0,
                      child: Align(
                        child: Text(
                          transferName.toUpperCase(),
                          overflow:  TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.00678,
                    ),
                    Align(
                      child: Text(
                        code,
                        style: GoogleFonts.nunito(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                // padding: EdgeInsets.symmetric(horizontal: 5 , vertical: 2),
                width: size.width * 0.2,
                //height: size.height * 0.5,
                child: Column(
                  children: [
                    Align(
                      child: Text(
                        amount,
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: !isPending ? Colors.green : kPrimaryColor),
                      ),
                      alignment: Alignment.topRight,
                    ),
                    SizedBox(
                      height: size.height * 0.00678,
                    ),
                    Align(
                      child: Text(
                        tfDate,
                        style: GoogleFonts.nunito(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.withOpacity(1)),
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                  ],
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
        top: 100,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(140)),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade50,
            radius: 50,
            backgroundImage: imgURL ==null ? AssetImage(
              'assets/f_png/businessman.png',
            ): NetworkImage(imgURL),
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
                        radius: 18,
                        backgroundColor: kPrimaryColor,
                        child: Icon(iconData , color: Colors.white,size: 18,)),
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
    this.imgURL, this.onTap,
  }) : super(key: key);

  final Size size;
  final String imgURL, accountName, accountNum, bankName;
  final Function moreTap,onTap, deleteTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      secondaryActions: <Widget>[
        Container(
          height: size.height*0.095,
          child: IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: deleteTap,
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
        child: GestureDetector(
          onTap: onTap,
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
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade50,
                    radius: 35,
                    child: Icon(Icons.add_chart, color: Colors.grey.shade300,)
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
                  padding: const EdgeInsets.all(2.0),
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
      child: Image.asset(
        'assets/f_png/avatar.png',
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
        style: GoogleFonts.nunito(
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
          style: GoogleFonts.nunito(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}


class CustomProfileChildRowWidget extends StatelessWidget {
  const CustomProfileChildRowWidget({
    Key key,
    @required this.size,
    this.title,
    this.svgURL,
    this.widgetIcon,
  }) : super(key: key);

  final Size size;
  final String title, svgURL;
  final Widget widgetIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                SvgPicture.asset(
                  svgURL,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                Text(
                  title,
                  style: GoogleFonts.nunito(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          widgetIcon
        ],
      ),
    );
  }
}
