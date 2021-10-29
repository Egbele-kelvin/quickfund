import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/listOfSecurityQuestionResp.dart';
import 'package:quickfund/data/model/securityQuestionReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class SecurityQuestionProvider with ChangeNotifier{
  Repository repository = Repository(networkService: NetworkService());
  bool loading = false;
  List<ListedQuestionData> data = [];
  Map _setupSecurityQuestionR;

  Map get setupSecurityQuestionR => _setupSecurityQuestionR;



  Future<void> _getListOfSecurityQuestion() async{
    try {
      loading = true;
      final listedQuestionResp = await repository.getListOfSecurityQuestion();
      data = listedQuestionResp;
      loading = false;
      print('listedQuestions : $data');
      notifyListeners();
    }catch(e){
      print('Error ${e.toString()}');
    }
  }


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

  Future<void> getListOfSecurityQuestion() async{
    return await _getListOfSecurityQuestion();
  }


}