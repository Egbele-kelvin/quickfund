
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:shimmer/shimmer.dart';

import 'custom_button.dart';

class AddSecurityQuestion extends StatelessWidget {
  final Function onTap;
  const AddSecurityQuestion({
    Key key, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Icon(
        Icons.add,
        size: 30,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key key, this.onTap, this.title}) : super(key: key);

  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap:onTap,
          title: Text(title , style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 11,
              color: Colors.black
          ),),
          trailing: Icon(Icons.tag , size: 12),

        ),
        Divider()
      ],
    );
  }
}


class SecurityQuestionWidgetQuest extends StatelessWidget {

  SecurityQuestionWidgetQuest({Key key, this.onChanged, this.onTap, this.onSaved}) : super(key: key);
  final List<String> errors = [];
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSaved;
  final Function onTap;

  void addError({String error}) {
    if (!errors.contains(error))
      errors.add(error);
  }
  void removeError({String error}) {
    if (errors.contains(error))
      errors.remove(error);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return   Expanded(flex:0, child:   Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 25),
      // height: size.height *0.1,
      child: Row(
        children: [
          Container(
            width: size.width *0.73,
            child: RoundedInputField(
              onSaved: onSaved,
                inputType: TextInputType.text,
                labelText: 'Create a Security Question',
                customTextHintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54.withOpacity(0.3),
                    fontWeight: FontWeight.w400),
                autoCorrect: true,
                onChanged: onChanged
            ),
          ),

          SizedBox(
            width: size.height * 0.02,
          ),
          AddSecurityQuestion(
              onTap:onTap
          )
        ],
      ),
    ),);
  }
}



class OTPClassWidget extends StatelessWidget {
  const OTPClassWidget({Key key, this.onChanged, this.onComplete, this.transactPin}) : super(key: key);
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onComplete;
  final  transactPin;
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: transactPin,
      textStyle: TextStyle(
          fontWeight: FontWeight.normal),
      obscureText: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      enableActiveFill: true,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 45,
          selectedFillColor:
          Colors.grey.withOpacity(0.1),
          disabledColor: Colors.white,
          selectedColor: Colors.white,
          fieldWidth: 45,
          activeColor: kPrimaryColor,
          inactiveColor:
          Colors.grey.withOpacity(0.15),
          inactiveFillColor: Colors.white,
          activeFillColor: colorPrimaryWhite),
      length: 4,
      appContext: context,
      onChanged:onChanged,
      onCompleted:onComplete,
    );
  }
}
//
class SecurityQuestionListWidget extends StatelessWidget {
  final String questItem;
  final Function onTap;
  SecurityQuestionListWidget({
    Key key, this.questItem, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 18.0, vertical: 10),
      child: Column(
        children: [
          ListTile(
            onTap:onTap,
            title: Text(
              questItem,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Colors.black),
            ),
            trailing: Icon(Icons.tag, size: 12),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}


class CustomWidget extends StatelessWidget {

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const CustomWidget.rectangular({
    this.width = double.infinity,
     this.height
  }): this.shapeBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10))
  );

  const CustomWidget.circular({
    this.width = double.infinity,
     this.height,
    this.shapeBorder = const CircleBorder()
  });

  @override
  Widget build(BuildContext context)  => Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.06),
    highlightColor: Colors.grey.shade50,
    period: Duration(seconds: 2),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[400],
        shape: shapeBorder,


      ),
    ),
  );
}


class NoActivity extends StatelessWidget {
  final String tag;
  const NoActivity({
    Key key, this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height *0.1,
          ),
          Icon(
            Icons.baby_changing_station,
            size: 65,
            color: Colors.grey.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0 , vertical: 20),
            child: Text(tag ==null ? 'OH, You don\'t have any Activity at the \n Moment!': tag, textAlign:TextAlign.center ,style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),),
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({
    Key key,
    @required this.userResultData, this.checking, this.switchWidget,
  }) : super(key: key);

  final String userResultData;
  final bool checking;
  final Widget switchWidget;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Visibility(
      visible: checking,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.check_circle_sharp, size: 9,color: kOnBoardingII,),
              SizedBox(
                width: 5,
              ),
              Text('$userResultData' , style: GoogleFonts.poppins(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w500,
                  color: kOnBoardingII
              ),),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Add to Beneficiary', style: GoogleFonts.poppins(
                fontSize: 11,
                color:kOnBoardingII
              ),),SizedBox(width: size.width*0.02,),
              switchWidget,
            ],
          ),
        ],
      ),
    );
  }
}

class CustomDataWidget extends StatelessWidget {
  const CustomDataWidget({
    Key key, this.title, this.amountLabel, this.onTap,
  }) : super(key: key);

  final String title , amountLabel;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            height: size.height * 0.06,
            child: ListTile(
              title: Text(
                title,
                style: GoogleFonts.nunito(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              trailing: Text(
                amountLabel,
                textAlign: TextAlign.left,
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              horizontalTitleGap: 10.0,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Divider(
            height: 0.4,
          )
        ],
      ),
    );
  }
}
