import 'dart:async';
import 'dart:io';

// import 'package:http/http.dart' as http;
import 'package:quickfund/data/api-service/ApiInterception.dart';
import 'package:quickfund/data/api-service/apiManager.dart';
import 'package:quickfund/data/model/createAccountBvnReq.dart';
import 'package:quickfund/data/model/createAccountViaPhoneNumReq.dart';
import 'package:quickfund/data/model/initiateBvnReq.dart';
import 'package:quickfund/data/model/inititatePhoneNumReq.dart';
import 'package:quickfund/data/model/listOfState.dart';
import 'package:quickfund/data/model/loginReq.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/data/model/verifyBvnReq.dart';
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


}
