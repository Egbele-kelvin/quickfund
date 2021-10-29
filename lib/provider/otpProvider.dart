import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/completeOnBoardOldCustomerReq.dart';
import 'package:quickfund/data/model/initiateOnboardOldCustomer.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/verifyOtpReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class OtpProvider with ChangeNotifier{
  Repository repository = Repository(networkService: NetworkService());
  Map _otpVerificate;
  get otpVerificate => _otpVerificate;

  Map _verifySentOtp;
  get verifySentOtp => _verifySentOtp;

  Map _initiateOnBoardOldC;
  get initiateOnBoardOldC => _initiateOnBoardOldC;

  Map _completeOnBoardOldC;
  get completeOnBoardOldC => _completeOnBoardOldC;

  Future<void> _otpVerification(OtpReq otpReq)async{
    try {
      final otpVerification = await repository.verifyOtpForAll(otpReq);
      _otpVerificate = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
  Future<void> _verifyOtpSent(VerifyOtpReq verifyOtpReq)async{
    try {
      final otpVerification = await repository.verifyOtpSent(verifyOtpReq);
      _verifySentOtp = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _initiateOnBoardOldCustomer(InitiateOnBoardOldCustomer initiateOnBoardOldCustomer)async{
    try {
      final otpVerification = await repository.initiateOnBoardOldCustomer(initiateOnBoardOldCustomer);
      _initiateOnBoardOldC = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _completeOnBoardOldCustomerReq(CompleteOnBoardOldCustomerReq completeOnBoardOldCustomerReq)async{
    try {
      final otpVerification = await repository.completeOnBoardOldCustomerReq(completeOnBoardOldCustomerReq);
      _completeOnBoardOldC = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  ///
  ///
  //-----public Access------//
  ///
  ///

  Future<void> otpVerificationForAll(OtpReq otpReq) async {
    return await _otpVerification(otpReq);
  }
  Future<void> verifyOtpSent(VerifyOtpReq verifyOtpReq) async {
    return await _verifyOtpSent(verifyOtpReq);
  }
  Future<void> initiateOnBoardOldCustomer(InitiateOnBoardOldCustomer initiateOnBoardOldCustomer) async {
    return await _initiateOnBoardOldCustomer(initiateOnBoardOldCustomer);
  }
  Future<void> completeOnBoardOldCustomerReq(CompleteOnBoardOldCustomerReq completeOnBoardOldCustomerReq) async {
    return await _completeOnBoardOldCustomerReq(completeOnBoardOldCustomerReq);
  }
}