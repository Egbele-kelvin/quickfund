import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class OtpProvider with ChangeNotifier{
  Repository repository = Repository(networkService: NetworkService());
  Map _otpVerificate;
  get otpVerificate => _otpVerificate;

  Future<void> _otpVerification(OtpReq otpReq)async{
    try {
      final otpVerification = await repository.verifyOtpForAll(otpReq);
      _otpVerificate = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
  //-----public Access------//

  Future<void> otpVerificationForAll(OtpReq otpReq) async {
    return await _otpVerification(otpReq);
  }
}