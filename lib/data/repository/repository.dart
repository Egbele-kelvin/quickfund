import 'package:quickfund/data/model/createAccountBvnReq.dart';
import 'package:quickfund/data/model/createAccountViaPhoneNumReq.dart';
import 'package:quickfund/data/model/initiateBvnReq.dart';
import 'package:quickfund/data/model/inititatePhoneNumReq.dart';
import 'package:quickfund/data/model/loginReq.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/data/model/verifyBvnReq.dart';
import 'package:quickfund/data/model/verifyPhoneNumReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';

class Repository {
  final NetworkService networkService;

  Repository({this.networkService});

  Future<dynamic> initiateBvn(InitiateBvn initiateBvn) async {
    final apiCall = await networkService?.initiateBvn(initiateBvn);
    return apiCall;
  }

  Future<dynamic> verifyOtpBvn(VerifyBvn verifyBvn) async {
    final apiCall = await networkService?.verifyOtpBvn((verifyBvn));
    return apiCall;
  }

  Future<dynamic> initiatePhoneNumberForAccount(
      InitiatePhoneReq initiatePhoneReq) async {
    final apiCall =
        await networkService?.initiatePhoneNumberForAccount((initiatePhoneReq));
    return apiCall;
  }

  Future<dynamic> verifyOtpPhoneNumber(
      VerifyPhoneNumReq verifyPhoneNumReq) async {
    final apiCall =
        await networkService?.verifyOtpPhoneNumber((verifyPhoneNumReq));
    return apiCall;
  }

  Future<dynamic> createAccountViaBvn(CreateAccountBvn createAccountBvn) async {
    final apiCall =
        await networkService?.createAccountViaBvn((createAccountBvn));
    return apiCall;
  }

  Future<dynamic> createAccountViaPhoneNumber(
      CreateAccountViaPhoneNumReq createAccountViaPhoneNumReq) async {
    final apiCall = await networkService
        ?.createAccountViaPhoneNumber((createAccountViaPhoneNumReq));
    return apiCall;
  }
  Future<dynamic> verifyOtpForAll(OtpReq otpReq) async {
    final apiCall = await networkService?.verifyOtpForAll((otpReq));
    return apiCall;
  }
  Future<dynamic> setupSecurityQuestion(
      SetupSecurityQuestion setupSecurityQuestion) async {
    final apiCall = await networkService
        ?.setupSecurityQuestion((setupSecurityQuestion));
    return apiCall;
  }

  Future<dynamic> signIn(LoginReq loginReq) async {
    final apiCall = await networkService?.signIn((loginReq));
    return apiCall;
  }
}
