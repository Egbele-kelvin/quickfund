

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

import 'cable.dart';
import 'cable_sucess.dart';

class CableMain extends StatefulWidget {
  @override
  _CableMainState createState() => _CableMainState();
}

class _CableMainState extends State<CableMain> {
  bool isVisible = false;
  bool focus = true;
  double opacityLevel = 0;
  String mainText = 'Choose a Subscription';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              //color: kPrimaryColor,
              child: CustomAppBar(
                onTap: () {
                  //onBackPress();
                  Navigator.pushReplacementNamed(
                      context, AppRouteName.DASHBOARD);
                },
                pageTitle: 'Cable Subscription',
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              //color: Colors.black,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              //
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 25, left: 10),
                        child: Text(
                          'Choose Your Service Provider',
                          style: GoogleFonts.roboto(fontSize: 16),
                        )),
                    SizedBox(height: 40),
                    CustomImageListTile(
                      leadingImage:
                      'https://getlogo.net/wp-content/uploads/2021/05/dstv-logo-vector.png',
                      title: 'DStv',
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Cable())),
                    ),
                    CustomImageListTile(
                      leadingImage:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY2Pjt-PzqsRcCD3iou8G0QjP6sZAV_kqV0_NfivjIA6oIQ7DOBQDcWBbIAol0lxZJggg&usqp=CAU',
                      title: 'Startime',
                    ),
                    CustomImageListTile(
                      leadingImage:
                      'https://getlogo.net/wp-content/uploads/2021/05/gotv-nigeria-logo-vector.png',
                      title: 'GOtv',
                    ),
                    CustomImageListTile(
                      leadingImage: 'http://www.techzim.co.zw/wp-content/uploads/2013/06/mytv-logo.png',
                      title: 'Mytv',
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomImageListTile extends StatelessWidget {
  const CustomImageListTile({
    Key key, this.title, this.leadingImage,this.onTap
  }) : super(key: key);

  final String title;
  final String leadingImage;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
            width: 35,
            height: 35,
            child: Image.network(leadingImage)),
        title: Text(title),
        trailing: Icon(Icons.east),
        onTap: onTap,
      ),
    );
  }
}