import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/accountDetailsResp.dart';
import 'package:quickfund/data/model/activateDeviceReq.dart';
import 'package:quickfund/data/model/forgotPasswordReq.dart';
import 'package:quickfund/data/model/loginReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class AuthProvider with ChangeNotifier{
  Repository repository = Repository(networkService: NetworkService());
  List<AccountDatum> accountDetails=[];
  bool loading = false;
  Map _login;
  Map get login => _login;

  Map _activateD;
  Map get activateD => _activateD;

  Map _forgot;
  Map get forgot => _forgot;

  Map _refreshAccess;
  Map get refreshAccess => _refreshAccess;

  bool _hasSignedIn;
  bool get hasSignedIn => _hasSignedIn;

  Map _userAcctBalResp;
  Map get userAcctBalResp => _userAcctBalResp;

  Future<void> _signIn(LoginReq loginReq) async {
    try {
      print('1_login: $_login');
      final otpVerification = await repository.signIn(loginReq);
      _login = otpVerification;
      print('2_login: $_login');
      _hasSignedIn = true;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _activateDevice(ActivateDeviceReq activateDeviceReq) async {
    try {
      final otpVerification = await repository.activateDevice(activateDeviceReq);
      _activateD = otpVerification;
      _hasSignedIn = true;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _forgotPassword(ForgotPasswordReq forgotPasswordReq) async {
    try {
      final otpVerification = await repository.forgotPassword(forgotPasswordReq);
      _forgot = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
  Future<void> _getRefreshAccess(String refreshToken) async {
    try {
      final refreshAccesResp = await repository.refreshSession(refreshToken);
      _refreshAccess = refreshAccesResp;
      notifyListeners();
    } catch (e) {
      print('refresh Error $e');

      // debug('Login Error ${e.toString()}');
    }
  }


  Future<void> _getAccount() async {
    try {
      loading = true;
      final stateListResp = await repository.getAccountDetails();
      accountDetails =stateListResp;
      loading = false;
      print('bank----accountDetails : $accountDetails');
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }


  Future<void> _getUserBal(String acctNo) async {
    try {
      final userBalResp = await repository.getAccountBal(acctNo);
      _userAcctBalResp = userBalResp;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  //public Access----//



  Future<void> getAccount() async {
    return await _getAccount();
  }


  Future<void> signIn(LoginReq loginReq) async {
    return await _signIn(loginReq);
  }

  Future<void> activateDevice(ActivateDeviceReq activateDeviceReq) async {
    return await _activateDevice(activateDeviceReq);
  }

  Future<void> forgotPassword(ForgotPasswordReq forgotPasswordReq) async {
    return await _forgotPassword(forgotPasswordReq);
  }
  Future<void> getRefreshAccess(String refreshToken) async {
    return await _getRefreshAccess(refreshToken);
  }

  Future<void> getUserBal(String acctNo) async {
    return await _getUserBal(acctNo);
  }
}