import 'package:quickfund/data/model/NameEnquiry.dart';
import 'package:quickfund/data/model/activateDeviceReq.dart';
import 'package:quickfund/data/model/completeOnBoardOldCustomerReq.dart';
import 'package:quickfund/data/model/createAccountBvnReq.dart';
import 'package:quickfund/data/model/createAccountViaPhoneNumReq.dart';
import 'package:quickfund/data/model/deleteSaveBeneficiary.dart';
import 'package:quickfund/data/model/forgotPasswordReq.dart';
import 'package:quickfund/data/model/initiateBvnReq.dart';
import 'package:quickfund/data/model/initiateOnboardOldCustomer.dart';
import 'package:quickfund/data/model/inititatePhoneNumReq.dart';
import 'package:quickfund/data/model/loginReq.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/payBillsReq.dart';
import 'package:quickfund/data/model/resetPasswordReq.dart';
import 'package:quickfund/data/model/resetPinReq.dart';
import 'package:quickfund/data/model/resetSecurityQuestion.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/data/model/transferFundsReq.dart';
import 'package:quickfund/data/model/verifyBvnReq.dart';
import 'package:quickfund/data/model/verifyOtpReq.dart';
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

  Future<dynamic> createAccountViaBvn(dynamic createAccountBvn) async {
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

  Future<dynamic> verifyOtpSent(VerifyOtpReq verifyOtpReq) async {
    final apiCall = await networkService?.verifyOtpSent((verifyOtpReq));
    return apiCall;
  }

  Future<dynamic> initiateOnBoardOldCustomer(
      InitiateOnBoardOldCustomer initiateOnBoardOldCustomer) async {
    final apiCall = await networkService
        ?.initiateOnBoardOldCustomer((initiateOnBoardOldCustomer));
    return apiCall;
  }

  Future<dynamic> completeOnBoardOldCustomerReq(
      CompleteOnBoardOldCustomerReq completeOnBoardOldCustomerReq) async {
    final apiCall = await networkService
        ?.completeOnBoardOldCustomerReq((completeOnBoardOldCustomerReq));
    return apiCall;
  }

  Future<dynamic> setupSecurityQuestion(
      SetupSecurityQuestion setupSecurityQuestion) async {
    final apiCall =
        await networkService?.setupSecurityQuestion((setupSecurityQuestion));
    return apiCall;
  }

  Future<dynamic> signIn(LoginReq loginReq) async {
    final apiCall = await networkService?.signIn((loginReq));
    return apiCall;
  }

  Future<dynamic> payBills(PayBillsReq payBillsReq) async {
    final apiCall = await networkService?.payBills((payBillsReq));
    return apiCall;
  }

  Future<dynamic> activateDevice(ActivateDeviceReq activateDeviceReq) async {
    final apiCall = await networkService?.activateDevice((activateDeviceReq));
    return apiCall;
  }

  Future<dynamic> forgotPassword(ForgotPasswordReq forgotPasswordReq) async {
    final apiCall = await networkService?.forgotPassword((forgotPasswordReq));
    return apiCall;
  }

  Future<dynamic> resetPassWord(ResetPassword resetPassword) async {
    final apiCall = await networkService?.resetPassWord((resetPassword));
    return apiCall;
  }

  Future<dynamic> resetPin(ResetPin resetPin) async {
    final apiCall = await networkService?.resetPin((resetPin));
    return apiCall;
  }

  Future<dynamic> resetSecurityQuestionQuery(
      ResetSecurityQuestionReq resetSecurityQuestionReq) async {
    final apiCall = await networkService
        ?.resetSecurityQuestionQuery((resetSecurityQuestionReq));
    return apiCall;
  }

  Future<dynamic> nameEnquiry(NameEnquiry nameEnquiry) async {
    final apiCall = await networkService?.nameEnquiry((nameEnquiry));
    return apiCall;
  }

  Future<dynamic> transferFunds(TransferFunds transferFunds) async {
    final apiCall = await networkService?.transferFunds((transferFunds));
    return apiCall;
  }

  Future<dynamic> deleteSaveBeneficiary(
      DeleteSaveBeneficiary deleteSaveBeneficiary) async {
    final apiCall =
        await networkService?.deleteSaveBeneficiary((deleteSaveBeneficiary));
    return apiCall;
  }

  Future<dynamic> refreshSession(String refreshToken) async {
    final resp = await networkService?.refreshSession(refreshToken);

    return resp;
  }

  Future<dynamic> getListOfState() async {
    final apiCall = await networkService?.getListOfState();

    return apiCall.data;
  }

  Future<dynamic> getListOfSecurityQuestion() async {
    final apiCall = await networkService?.getListOfSecurityQuestion();

    return apiCall.data;
  }

  Future<dynamic> getAccountDetails() async {
    final apiCall = await networkService?.getAccountDetails();

    return apiCall.data;
  }

  Future<dynamic> getAccountBal(String userBal) async {
    return await networkService?.getUserAccountBal(userBal);
  }

  Future<dynamic> getListOfBanks() async {
    final apiCall = await networkService?.getListOfBanks();

    return apiCall.data;
  }

  Future<dynamic> getListOfBillersCategory() async {
    final apiCall = await networkService?.getListOfBillersCategory();

    return apiCall.data;
  }

  Future<dynamic> getListOfAirtime() async {
    final apiCall = await networkService?.getListOfAirtime();

    return apiCall.data;
  }

  Future<dynamic> getAllSaveBeneficiary() async {
    final apiCall = await networkService?.getAllSaveBeneficiary();

    return apiCall.data;
  }

  Future<dynamic> getAllTransactionHistory() async {
    final apiCall = await networkService?.getAllTransactionHistory();

    return apiCall.data;
  }

  Future<dynamic> getBillsByCode(String codeID) async {
    return await networkService?.getBillsByCode(codeID);
  }

  Future<dynamic> getBillerDataByCodeId(String billerID) async {
    return await networkService?.getBillerDataByCodeId(billerID);
  }
}
