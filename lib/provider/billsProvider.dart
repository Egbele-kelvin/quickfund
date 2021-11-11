import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/listOfAirtimeResp.dart';
import 'package:quickfund/data/model/listOfCategories.dart';
import 'package:quickfund/data/model/payBillsReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class BillsProvider with ChangeNotifier{
  Repository repository = Repository(networkService: NetworkService());
  bool loading = false;

  Map _billsPaysCodeResp;
  Map  get billsPaysCodeResp => _billsPaysCodeResp;

  Map _getDataByCodeId;
  Map  get getDataByCodeId => _getDataByCodeId;

  Map _pay;
  Map  get pay => _pay;


  List<CategoryData> billerCategory;
  List<AirtimeData> airtimeData;


  Future<void> _getAllBillers() async {
    try {
      loading = true;
      final stateListResp = await repository.getListOfBillersCategory();
      billerCategory = stateListResp;
      loading = false;
      print('-billerCategory : $billerCategory');
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }


  Future<void> _getAirtime() async {
    try {
      loading = true;
      final stateListResp = await repository.getListOfAirtime();
      airtimeData = stateListResp;
      loading = false;
      print('-airtimeData : $airtimeData');
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }


  Future<void> _userBillsResult(String codeID) async{
    try {
      final userBillsResp = await repository.getBillsByCode(codeID);
      _billsPaysCodeResp = userBillsResp;
      notifyListeners();
    }catch(e){
      print('Error ${e.toString()}');
    }
  }



  Future<void> _getBillerDataByCodeId(String billerID) async{
    try {
      final userBillsResp = await repository.getBillerDataByCodeId(billerID);
      _getDataByCodeId = userBillsResp;
      notifyListeners();
    }catch(e){
      print('Error ${e.toString()}');
    }
  }

  Future<void> _payBills(PayBillsReq payBillsReq) async {
    try {
      final otpVerification = await repository.payBills(payBillsReq);
      _pay = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  //-------Public Access------//

  Future<void> getAllBillers() async {
    return await _getAllBillers();
  }
  Future<void> getAirtime() async {
    return await _getAirtime();
  }

  Future<void> userBillsResult(String codeID) async{
    print('custom bills ID:  $codeID');
    return await _userBillsResult(codeID);
  }


  Future<void> getBillerDataByCodeId(String billerID) async{
    print('custom bills ID:  $billerID');
    return await _getBillerDataByCodeId(billerID);
  }
  Future<void> payBills(PayBillsReq payBillsReq) async {
    return await _payBills(payBillsReq);
  }


}