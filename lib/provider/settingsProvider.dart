import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/resetPasswordReq.dart';
import 'package:quickfund/data/model/resetPinReq.dart';
import 'package:quickfund/data/model/resetSecurityQuestion.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class SettingsProvider with ChangeNotifier {
  Repository repository = Repository(networkService: NetworkService());

  Map _changePassword;

  get changePassword => _changePassword;

  Map _changePin;

  get changePin => _changePin;

  Map _changeSecurityQuestion;

  get changeSecurityQuestion => _changeSecurityQuestion;

  Map _changeSecurityQuest;

  get changeSecurityQuest => _changeSecurityQuest;

  Future<void> _resetPassWord(ResetPassword resetPassword) async {
    try {
      final otpVerification = await repository.resetPassWord(resetPassword);
      _changePassword = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _resetPin(ResetPin resetPin) async {
    try {
      final otpVerification = await repository.resetPin(resetPin);
      _changePin = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _resetSecurityQuestion(ResetSecurityQuestionReq resetSecurityQuestionReq) async {
    try {
      final otpVerification = await repository.resetSecurityQuestionQuery(resetSecurityQuestionReq);
      _changeSecurityQuest = otpVerification;
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

  Future<void> resetPassWord(ResetPassword resetPassword) async {
    return await _resetPassWord(resetPassword);
  }

  Future<void> resetPin(ResetPin resetPin) async {
    return await _resetPin(resetPin);
  }

  Future<void> resetSecurityQuestion(ResetSecurityQuestionReq resetSecurityQuestionReq) async {
    return await _resetSecurityQuestion(resetSecurityQuestionReq);
  }
}
