import 'package:flutter/cupertino.dart';
import 'package:quickfund/data/model/NameEnquiry.dart';
import 'package:quickfund/data/model/deleteSaveBeneficiary.dart';
import 'package:quickfund/data/model/listOfBanks.dart';
import 'package:quickfund/data/model/saveBeneficiaryResp.dart';
import 'package:quickfund/data/model/transactionHistory.dart';
import 'package:quickfund/data/model/transferFundsReq.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';

class TransferProvider with ChangeNotifier {
  Repository repository = Repository(networkService: NetworkService());
  bool loading = false;
  List<BankData> bankData = [];
  List<TransactionHistoryDatum> transactionHistoryData = [];
  List<SaveBeneficiaryData> saveBeneficiaryData = [];

  Map _enquiry;

  get enquiry => _enquiry;

  Map _transfer;

  get transfer => _transfer;

  Map _deleteBeneficiaryData;

  get deleteBeneficiaryData => _deleteBeneficiaryData;

  Future<void> _getListOfBanks() async {
    try {
      loading = true;
      final stateListResp = await repository.getListOfBanks();
      bankData = stateListResp;
      loading = false;
      print('bank----DataList : $bankData');
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _getAllSavedBeneficiary() async {
    try {
      loading = true;
      final stateListResp = await repository.getAllSaveBeneficiary();
      saveBeneficiaryData = stateListResp;
      loading = false;
      print('bank----transactionHistoryDataList : $saveBeneficiaryData');
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _getAllTransactionHistory() async {
    try {
      loading = true;
      final stateListResp = await repository.getAllTransactionHistory();
      transactionHistoryData = stateListResp;
      loading = false;
      print('bank----DataList : $transactionHistoryData');
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _nameEnquiry(NameEnquiry nameEnquiry) async {
    try {
      final otpVerification = await repository.nameEnquiry(nameEnquiry);
      _enquiry = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  Future<void> _transferFunds(TransferFunds transferFunds) async {
    try {
      final otpVerification = await repository.transferFunds(transferFunds);
      _transfer = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }


  Future<void> _deleteBeneficiary(DeleteSaveBeneficiary deleteSaveBeneficiary) async {
    try {
      final otpVerification = await repository.deleteSaveBeneficiary(deleteSaveBeneficiary);
      _deleteBeneficiaryData = otpVerification;
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  //-------Public Access------//

  Future<void> getListOfBanks() async {
    return await _getListOfBanks();
  }

  Future<void> getAllTransactionHistory() async {
    return await _getAllTransactionHistory();
  }

  Future<void> getAllSavedBeneficiary() async {
    return await _getAllSavedBeneficiary();
  }

  Future<void> nameEnquiry(NameEnquiry nameEnquiry) async {
    return await _nameEnquiry(nameEnquiry);
  }

  Future<void> transferFunds(TransferFunds transferFunds) async {
    return await _transferFunds(transferFunds);
  }

  Future<void> deleteBeneficiary(DeleteSaveBeneficiary deleteSaveBeneficiary) async {
    return await _deleteBeneficiary(deleteSaveBeneficiary);
  }
}
