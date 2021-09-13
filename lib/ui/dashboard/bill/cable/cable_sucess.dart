import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/widget/custom_button.dart';

class CableSuccessful extends StatelessWidget {
  // const CableSuccessful({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_qxh0yua7.json'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text('Transaction Successful',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 20
              ),),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            CustomButton(
              btnTitle: 'Done',
              size: MediaQuery.of(context).size,
              onTap: (){
                Navigator.pushReplacementNamed(
                    context, AppRouteName.DASHBOARD);
              },
            )
            // Container(
            //   width: double.infinity,
            //   height: 50,
            //   margin: EdgeInsets.all(15),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>CableSuccessful()));
            //     },
            //     child: Text('Done'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
