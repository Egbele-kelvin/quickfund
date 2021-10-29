import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/createAccountBvnReq.dart';
import 'package:quickfund/data/model/createAccountViaPhoneNumReq.dart';
import 'package:quickfund/data/model/initiateBvnReq.dart';
import 'package:quickfund/data/model/inititatePhoneNumReq.dart';
import 'package:quickfund/data/model/listOfState.dart';
import 'package:quickfund/data/model/loginReq.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/data/model/verifyBvnReq.dart';
import 'package:quickfund/data/model/verifyPhoneNumReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class SetupAccountViaBVNandViaPhoneProvider with ChangeNotifier {
  Repository repository = Repository(networkService: NetworkService());
  bool loading = false;
  List stateList = [];
  Map _initiateBvnR;

  Map get initiateBvnR => _initiateBvnR;

  Map _verifyBvnOtp;

  Map get verifyBvnOtp => _verifyBvnOtp;

  Map _initiatePhoneNumber;

  Map get initiatePhoneNumber => _initiatePhoneNumber;

  Map _verifyPhoneOtp;

  Map get verifyPhoneOtp => _verifyPhoneOtp;

  Map _createAccountUsingBvn;

  Map get createAccountUsingBvn => _createAccountUsingBvn;

  Map _createAccountUsingPhone;

  Map get createAccountUsingPhone => _createAccountUsingPhone;

  Map _listOfState;

  Map get listOfState => _listOfState;

  Future<void> _getListOfState() async {
    try {
      loading = true;
      final stateListResp = await repository.getListOfState();
      stateList = stateListResp;
      loading = false;
      print('stateList : $stateList');
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _initiateBvn(InitiateBvn initiateBvn) async {
    try {
      final initiateBvnResp = await repository.initiateBvn(initiateBvn);
      _initiateBvnR = initiateBvnResp;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _verifyBVNOtp(VerifyBvn verifyBvn) async {
    try {
      final otpVerification = await repository.verifyOtpBvn(verifyBvn);
      _verifyBvnOtp = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _initiatePhoneNumberForAccount(
      InitiatePhoneReq initiatePhoneReq) async {
    try {
      final initiatePhoneResp =
          await repository.initiatePhoneNumberForAccount(initiatePhoneReq);
      _initiatePhoneNumber = initiatePhoneResp;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _verifyOtpPhoneNumber(
      VerifyPhoneNumReq verifyPhoneNumReq) async {
    try {
      final otpVerification =
          await repository.verifyOtpPhoneNumber(verifyPhoneNumReq);
      _verifyPhoneOtp = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _createAccountViaBvn(dynamic createAccountBvn) async {
    try {
      final otpVerification =
          await repository.createAccountViaBvn(createAccountBvn);
      _createAccountUsingBvn = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _createAccountViaPhone(
      CreateAccountViaPhoneNumReq createAccountViaPhoneNumReq) async {
    try {
      final otpVerification = await repository
          .createAccountViaPhoneNumber(createAccountViaPhoneNumReq);
      _createAccountUsingPhone = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  //---------------------Public Access-----------//
  Future<void> initiateBvn(InitiateBvn initiateBvn) async {
    return await _initiateBvn(initiateBvn);
  }

  Future<void> verifyBVNOtp(VerifyBvn verifyBvn) async {
    return await _verifyBVNOtp(verifyBvn);
  }

  Future<void> initiatePhoneNumberForAccount(
      InitiatePhoneReq initiatePhoneReq) async {
    return await _initiatePhoneNumberForAccount(initiatePhoneReq);
  }

  Future<void> verifyOtpPhoneNumber(VerifyPhoneNumReq verifyPhoneNumReq) async {
    return await _verifyOtpPhoneNumber(verifyPhoneNumReq);
  }

  Future<dynamic> createAccountViaBvn(dynamic createAccountBvn) async {
    return await _createAccountViaBvn(createAccountBvn);
  }

  Future<void> createAccountViaPhone(
      CreateAccountViaPhoneNumReq createAccountViaPhoneNumReq) async {
    return await _createAccountViaPhone(createAccountViaPhoneNumReq);
  }

  Future<void> getListOfState() async {
    return await _getListOfState();
  }
}
