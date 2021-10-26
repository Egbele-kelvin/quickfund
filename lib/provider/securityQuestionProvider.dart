import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class SecurityQuestionProvider with ChangeNotifier{
  Repository repository = Repository(networkService: NetworkService());
  Map _setupSecurityQuestionR;

  Map get setupSecurityQuestionR => _setupSecurityQuestionR;


  Future<void> _setupSecurityQuestion(
      SetupSecurityQuestion setupSecurityQuestion) async {
    try {
      final otpVerification = await repository
          .setupSecurityQuestion(setupSecurityQuestion);
      _setupSecurityQuestionR = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }


  //-----Public Accesss-------//

  Future<void> setupSecurityQuestion(SetupSecurityQuestion setupSecurityQuestion) async {
    return await _setupSecurityQuestion(setupSecurityQuestion);
  }


}