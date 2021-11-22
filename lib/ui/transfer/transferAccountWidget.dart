
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/accountDetailsResp.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/ui/signup/account_opening/accountWidget.dart';
import 'package:quickfund/widget/custom_widgets.dart';

class AccountWidget extends StatelessWidget {
  final Widget widgetIcon;

  const AccountWidget({Key key, this.widgetIcon}) : super(key: key);
  //
  // List<AccountDatum> accountDetails;
  // String accountName , accountNumber, balance;
  // getAccountDetails() async {
  //   final postMdl = Provider.of<AuthProvider>(context, listen: false);
  //   postMdl.getAccount();
  //   accountDetails = postMdl.accountDetails;
  //   try {
  //     await Future.forEach(accountDetails, (AccountDatum account) async {
  //       print('Account ${account.accountNumber}');
  //       accountNumber = account.accountNumber;
  //       accountName=account.customerName;
  //       balance=account.accountBalance;
  //       print('acctNum : $accountNumber');
  //     });
  //   } catch (e) {
  //     print('e: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.4,
      child: Column(
        children: [
          CustomDetails(
            heading: 'Select Source Account',
          ),

          widgetIcon,
        ],
      ),
    );
  }
}

