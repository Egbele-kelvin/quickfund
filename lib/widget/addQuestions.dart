
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';

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
    return ListTile(
      onTap:onTap,
      title: Text(title , style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 11,
          color: Colors.black
      ),),
      trailing: Icon(Icons.tag , size: 12),

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
