import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/constants.dart';
import 'bill/bill_main.dart';
import 'dashboardMain.dart';
import 'more/more.dart';
import 'transaction/transactionUI.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key key}) : super(key: key);

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  String userName = 'Bose', acctBalance = '239,600';

  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  List<Widget> _widgetOptions = <Widget>[
    DashBoardMain(),
    BillMainUI(),
    TransactionUI(),
    More()
    // FundAccountUI()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    print(tfDate);

    super.initState();
  }
  int _selectedIndex = 0;

  showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    String cancelActionText,
    @required String defaultActionText,
  }) async {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (cancelActionText != null)
              FlatButton(
                child: Text(cancelActionText),
                textColor: Colors.blue,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            FlatButton(
                child: Text(defaultActionText),
                textColor: Colors.red,
                onPressed:  () => exit(0)),
          ],
        ),
      );
    }
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.red),
            child: Text(defaultActionText),
            onPressed: () => exit(0),
          ),
        ],
      ),
    );
  }

  _onBackPress(BuildContext context){
    showAlertDialog(
        content: 'Do you want to exit an App',
        context: context,
        defaultActionText: 'Yes',
        cancelActionText: 'No',
        title: 'Are you sure?');
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=> _onBackPress(context),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: BottomNavigationBar(

                  type: BottomNavigationBarType.fixed,
                  elevation: 1.0,
                  onTap: onItemTapped,
                  selectedItemColor: kDashBoardCardColor,
                  unselectedItemColor: Colors.grey,
                  currentIndex: _selectedIndex,
                  selectedLabelStyle: GoogleFonts.roboto(

                  ),
                  unselectedLabelStyle: GoogleFonts.roboto(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 11
                  ),
                  showUnselectedLabels: true,
                  unselectedFontSize: 11,
                  selectedFontSize: 11,

                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        label: 'Home',),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.wysiwyg_rounded),
                        label: 'Bills'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.sticky_note_2_outlined),
                        label: 'Transactions'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.more_horiz,),
                        label: 'More',)
                  ],
                ),
              ))),
    );
  }
}


