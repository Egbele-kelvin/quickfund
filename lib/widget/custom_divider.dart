import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  // final Color color;
  // final double lead;
  // final double trail;

  const CustomDivider({
    // @required this.color,
    // @required this.lead,
    // @required this.trail,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 80,
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3),
      height: 8,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
    );
    // return ClipRRect(
    //     borderRadius: const BorderRadius.all(Radius.circular(300)),
    //     child: Divider(
    //       color: color,
    //       height: 4,
    //       thickness: 10,
    //       indent: lead,
    //       endIndent: trail,
    //     ));
  }
}
