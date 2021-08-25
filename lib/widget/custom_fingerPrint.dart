import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFingerPrint extends StatelessWidget {
  const CustomFingerPrint({
    Key key, this.onTap,
  }) : super(key: key);

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(Icons.fingerprint_sharp,
        size: 70,
      ),
    );
  }
}
