import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:http/http.dart' as http;
import 'package:quickfund/data/api-service/ApiInterception.dart';
import 'package:quickfund/data/api-service/apiManager.dart';
import 'package:quickfund/data/model/NameEnquiry.dart';
import 'package:quickfund/data/model/accountDetailsResp.dart';
import 'package:quickfund/data/model/activateDeviceReq.dart';
import 'package:quickfund/data/model/completeOnBoardOldCustomerReq.dart';
import 'package:quickfund/data/model/createAccountBvnReq.dart';
import 'package:quickfund/data/model/createAccountViaPhoneNumReq.dart';
import 'package:quickfund/data/model/deleteSaveBeneficiary.dart';
import 'package:quickfund/data/model/forgotPasswordReq.dart';
import 'package:quickfund/data/model/initiateBvnReq.dart';
import 'package:quickfund/data/model/initiateOnboardOldCustomer.dart';
import 'package:quickfund/data/model/inititatePhoneNumReq.dart';
import 'package:quickfund/data/model/listOfAirtimeResp.dart';
import 'package:quickfund/data/model/listOfBanks.dart';
import 'package:quickfund/data/model/listOfCategories.dart';
import 'package:quickfund/data/model/listOfSecurityQuestionResp.dart';
import 'package:quickfund/data/model/listOfState.dart';
import 'package:quickfund/data/model/loginReq.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/payBillsReq.dart';
import 'package:quickfund/data/model/resetPasswordReq.dart';
import 'package:quickfund/data/model/resetPinReq.dart';
import 'package:quickfund/data/model/resetSecurityQuestion.dart';
import 'package:quickfund/data/model/saveBeneficiaryResp.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/data/model/transactionHistory.dart';
import 'package:quickfund/data/model/transferFundsReq.dart';
import 'package:quickfund/data/model/verifyBvnReq.dart';
import 'package:quickfund/data/model/verifyOtpReq.dart';
import 'package:quickfund/data/model/verifyPhoneNumReq.dart';

class NetworkService {
  // final String baseUrl = 'http://staging.quickfund.rimotechnology.com';
  final String baseUrl = 'http://3.144.238.224';
  final ApiManager apiManager = ApiManager();

  Future<dynamic> initiateBvn(InitiateBvn initiateBvn) async {
    print('UserReqNetwork: ${initiateBvn.bvn}');
    var url = '/api/v1/initialize/registration/bvn';
    var responseJson;
    try {
      final response = await apiManager.post(url, initiateBvn);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }

    return responseJson;
  }

  Future<dynamic> initiatePhoneNumberForAccount(
      InitiatePhoneReq initiatePhoneReq) async {
    print('UserReqNetwork: ${initiatePhoneReq.phone}');
    var url = '/api/v1/initialize/registration/phone';
    var responseJson;
    try {
      final response = await apiManager.post(url, initiatePhoneReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }

    return responseJson;
  }

  Future<dynamic> verifyOtpBvn(VerifyBvn verifyBvn) async {
    print('UserReqNetwork: ${verifyBvn.otp}');
    var url = '/api/v1/register/verify/otp/bvn';
    var responseJson;
    try {
      final response = await apiManager.post(url, verifyBvn);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }

    return responseJson;
  }

  Future<dynamic> verifyOtpPhoneNumber(
      VerifyPhoneNumReq verifyPhoneNumReq) async {
    print('UserReqNetwork: ${verifyPhoneNumReq.otp}');
    var url = '/api/v1/register/verify/otp/phone';
    var responseJson;
    try {
      final response = await apiManager.post(url, verifyPhoneNumReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }

    return responseJson;
  }

  Future<dynamic> createAccountViaBvn(dynamic createAccountBvn) async {
    print('UserReqNetwork: ${createAccountBvn.bvn}');
    var url = '/api/v1/register/create/account/bvn';
    var responseJson;
    try {
      final response = await apiManager.post(url, createAccountBvn);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }

    return responseJson;
  }

  Future<dynamic> createAccountViaPhoneNumber(
      CreateAccountViaPhoneNumReq createAccountViaPhoneNumReq) async {
    print('UserReqNetwork: ${createAccountViaPhoneNumReq.bvn}');
    var url = '/api/v1/register/create/account/phone';
    var responseJson;
    try {
      final response = await apiManager.post(url, createAccountViaPhoneNumReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }

    return responseJson;
  }

  Future<dynamic> verifyOtpForAll(OtpReq otpReq) async {
    print('UserReqNetwork: ${otpReq.phone}');
    var url = '/api/v1/otp/send';
    var responseJson;
    try {
      final response = await apiManager.post(url, otpReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }

    return responseJson;
  }

  Future<dynamic> verifyOtpSent(VerifyOtpReq verifyOtpReq) async {
    print('UserReqNetwork: ${verifyOtpReq.phone}');
    var url = '/api/v1/otp/verify';
    var responseJson;
    try {
      final response = await apiManager.post(url, verifyOtpReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> initiateOnBoardOldCustomer(
      InitiateOnBoardOldCustomer initiateOnBoardOldCustomer) async {
    print('UserReqNetwork: ${initiateOnBoardOldCustomer.phone}');
    var url = '/api/v1/onboard/existing/customers/phone';
    var responseJson;
    try {
      final response = await apiManager.post(url, initiateOnBoardOldCustomer);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> completeOnBoardOldCustomerReq(
      CompleteOnBoardOldCustomerReq completeOnBoardOldCustomerReq) async {
    print('UserReqNetwork: ${completeOnBoardOldCustomerReq.phone}');
    var url = '/api/v1/onboard/existing/customers/password';
    var responseJson;
    try {
      final response =
          await apiManager.post(url, completeOnBoardOldCustomerReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<ListOfState> getListOfState() async {
    print('UserReqNetwork: dfaCreateAccount');
    var url = '/api/v1/states';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      return ListOfState.fromJson(response);
      // print('ServerData $response');
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }

  Future<AllBanks> getListOfBanks() async {
    print('UserReqNetwork: dfaCreateAccount');
    var url = '/api/v1/commercial/banks';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      return AllBanks.fromJson(response);
      // print('ServerData $response');
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }

  Future<CategoriesOfBills> getListOfBillersCategory() async {
    print('UserReqNetwork: dfaCreateAccount');
    var url = '/api/v1/bills/categories';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      return CategoriesOfBills.fromJson(response);
      // print('ServerData $response');
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }
  Future<ListOfAirtime> getListOfAirtime() async {
    print('UserReqNetwork: dfaCreateAccount');
    var url = '/api/v1/airtime/billers';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      return ListOfAirtime.fromJson(response);
      // print('ServerData $response');
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }

  Future<dynamic> getBillsByCode(String codeID) async {
    print('UserReqNetwork: ${codeID.toString()}');
    var url = '/api/v1/bills/category/billers/';
    var responseJson;
    try {
      final response = await apiManager.get(url + codeID);
      // return jsonDecode(response.body);
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getBillerDataByCodeId(String billerId) async {
    print('UserReqNetwork: ${billerId.toString()}');
    var url = '/api/v1/bills/biller/options/';
    var responseJson;
    try {
      final response = await apiManager.get(url + billerId);
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> payBills(PayBillsReq payBillsReq) async {
    print(
        'UserReqNetwork: PayBillsReq=> ${payBillsReq.billerName} PayBillsReq=> ${payBillsReq.bundleName}');
    var url = '/api/v1/bills/pay';
    var responseJson;
    try {
      final response = await apiManager.post(url, payBillsReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<AccountDetails> getAccountDetails() async {
    print('UserReqNetwork: dfaCreateAccount');
    var url = '/api/v1/accounts';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      return AccountDetails.fromJson(response);
      // print('ServerData $response');
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }

  Future<dynamic> getUserAccountBal(String accountNum) async {
    print('UserReqNetwork: ${accountNum.toString()}');
    var url = '/api/v1/account/balance/$accountNum';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      // return jsonDecode(response.body);
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<ListOfSecurityQuestion> getListOfSecurityQuestion() async {
    print('UserReqNetwork: dfaCreateAccount');
    var url = '/api/v1/securityquestions';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      return ListOfSecurityQuestion.fromJson(response);
      // print('ServerData $response');
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }

  Future<SaveBeneficiaryResp> getAllSaveBeneficiary() async {
    print('UserReqNetwork: beneficiaries');
    var url = '/api/v1/transfers/beneficiaries';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      return SaveBeneficiaryResp.fromJson(response);
      // print('ServerData $response');
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }

  Future<TransactionHistoryResp> getAllTransactionHistory() async {
    print('UserReqNetwork: beneficiaries');
    var url = '/api/v1/account/transactions/recent';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      return TransactionHistoryResp.fromJson(response);
      // print('ServerData $response');
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }

  Future<dynamic> setupSecurityQuestion(
      SetupSecurityQuestion setupSecurityQuestion) async {
    print('UserReqNetwork: ${setupSecurityQuestion.userId}');
    var url = '/api/v1/account/security/setup';
    var responseJson;
    try {
      final response = await apiManager.post(url, setupSecurityQuestion);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }

    return responseJson;
  }

  Future<dynamic> signIn(LoginReq loginReq) async {
    print('UserReqNetwork: ${loginReq.deviceId}');
    var url = '/api/v1/login';
    var responseJson;
    try {
      final response = await apiManager.post(url, loginReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> forgotPassword(ForgotPasswordReq forgotPasswordReq) async {
    print('UserReqNetwork: ${forgotPasswordReq.phone}');
    var url = '/api/v1/forgot/password';
    var responseJson;
    try {
      final response = await apiManager.post(url, forgotPasswordReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> activateDevice(ActivateDeviceReq activateDeviceReq) async {
    print(
        'UserReqNetwork: deviceId=> ${activateDeviceReq.deviceId} otp=> ${activateDeviceReq.otp}');
    var url = '/api/v1/login/activate/device';
    var responseJson;
    try {
      final response = await apiManager.post(url, activateDeviceReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> resetPassWord(ResetPassword resetPassword) async {
    print(
        'UserReqNetwork: deviceId=> ${resetPassword.phone} otp=> ${resetPassword.otp}');
    var url = '/api/v1/password/reset';
    var responseJson;
    try {
      final response = await apiManager.post(url, resetPassword);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> resetPin(ResetPin resetPin) async {
    print('UserReqNetwork: deviceId=> ${resetPin.phone} otp=> ${resetPin.otp}');
    var url = '/api/v1/pin/reset';
    var responseJson;
    try {
      final response = await apiManager.post(url, resetPin);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> resetSecurityQuestionQuery(
      ResetSecurityQuestionReq resetSecurityQuestionReq) async {
    print(
        'UserReqNetwork: phone=> ${resetSecurityQuestionReq.phone} userId=> ${resetSecurityQuestionReq.userId}');
    var url = '/api/v1/security/question/reset';
    var responseJson;
    try {
      final response = await apiManager.post(url, resetSecurityQuestionReq);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> nameEnquiry(NameEnquiry nameEnquiry) async {
    print(
        'UserReqNetwork: accountNumber=> ${nameEnquiry.accountNumber} userId=> ${nameEnquiry.bankCode}');
    var url = '/api/v1/transfers/name/enquiry';
    var responseJson;
    try {
      final response = await apiManager.post(url, nameEnquiry);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> transferFunds(TransferFunds transferFunds) async {
    print(
        'UserReqNetwork: from=> ${transferFunds.from} userId=> ${transferFunds.toBankCode}');
    var url = '/api/v1/transfers/funds';
    var responseJson;
    try {
      final response = await apiManager.post(url, transferFunds);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> deleteSaveBeneficiary(
      DeleteSaveBeneficiary deleteSaveBeneficiary) async {
    print(
        'UserReqNetwork: DeleteSaveBeneficiary=> ${deleteSaveBeneficiary.beneficiaryId}');
    var url = '/api/v1/transfers/beneficiary/remove';
    var responseJson;
    try {
      final response = await apiManager.post(url, deleteSaveBeneficiary);
      print('ServerData $response');
      responseJson = response;
    } catch (e) {
      print('ServerData $e');
    }
    return responseJson;
  }

  Future<dynamic> refreshSession(String refreshToken) async {
    print('UserReqNetwork: ${refreshToken.toString()}');
    var url = '/api/v1/refresh/token?refresh_token=$refreshToken';
    var responseJson;
    try {
      final response = await apiManager.get(url);
      responseJson = json.decode(response.body);
     // responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
