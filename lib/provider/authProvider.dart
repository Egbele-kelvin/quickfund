import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/loginReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class AuthProvider with ChangeNotifier{
  Repository repository = Repository(networkService: NetworkService());
  Map _login;

  Map get login => _login;

  Future<void> _signIn(LoginReq loginReq) async {
    try {
      final otpVerification = await repository.signIn(loginReq);
      _login = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }


  //public Access----//

  Future<void> signIn(LoginReq loginReq) async {
    return await _signIn(loginReq);
  }

}