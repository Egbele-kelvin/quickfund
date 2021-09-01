import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/constants.dart';
import 'bill/bill_main.dart';
import 'dashboardMain.dart';
import 'fundAcct/fundAccountUI.dart';
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

  @override
  void initState() {
    print(tfDate);

    super.initState();
  }
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

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


    return Scaffold(
        resizeToAvoidBottomInset: false,
        //  backgroundColor: kPrimaryColor,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38.withOpacity(0.1),
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
                      label:
                        'Home',
                      ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.wysiwyg_rounded), label: 'Bills'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sticky_note_2_outlined),
                      label: 'Transactions'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.more_horiz,
                      ),
                      label:
                        'More',
                      )
                ],
              ),
            )));
  }
}


