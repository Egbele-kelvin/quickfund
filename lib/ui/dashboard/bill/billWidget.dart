import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/custom_textform_field.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    Key key,
    @required this.size, this.detail,
  }) : super(key: key);

  final Size size;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: size.height *0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(

            color: Colors.black.withOpacity(0.08),
          )
      ),
      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(detail, style: GoogleFonts.robotoMono(
                fontWeight: FontWeight.w300,
                fontSize: 10,
                color: Colors.black

            ),),
          ),

          Icon(Icons.check_circle_sharp, color: Colors.green,size: 14,)
        ],),
    );
  }
}
class InvisibleAmount extends StatefulWidget {
  InvisibleAmount({Key key, this.invisibleAmount}) : super(key: key);

  final TextEditingController invisibleAmount;

  @override
  _InvisibleAmountState createState() => _InvisibleAmountState();
}

class _InvisibleAmountState extends State<InvisibleAmount> {
  final List<String> errors = [];
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  @override
  Widget build(BuildContext context) {
    return RoundedInputField(
      controller: widget.invisibleAmount,
      inputType: TextInputType.number,
      labelText: 'Amount',
      autoCorrect: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(
              error: 'Amount is Required');
        }
        return null;
      },
      validateForm: (value) {
        if (value.isEmpty) {
          addError(
              error: 'Amount is Required');
          return "";
        } else if (value.length < 1 ||
            value == '0') {
          addError(
              error:
              'Amount should be greater than 0');
          return "";
        }
        return null;
      },
    );
  }
}
