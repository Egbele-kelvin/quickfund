// To parse this JSON data, do
//
//     final accountBalance = accountBalanceFromJson(jsonString);

import 'dart:convert';

AccountBalance accountBalanceFromJson(String str) => AccountBalance.fromJson(json.decode(str));

String accountBalanceToJson(AccountBalance data) => json.encode(data.toJson());

class AccountBalance {
  AccountBalance({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final AccountBalanceData data;
  final int responsecode;

  factory AccountBalance.fromJson(Map<String, dynamic> json) => AccountBalance(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : AccountBalanceData.fromJson(json['data']),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : data.toJson(),
    'responsecode': responsecode == null ? null : responsecode,
  };
}

class AccountBalanceData {
  AccountBalanceData({
    this.balance,
  });

  final String balance;

  factory AccountBalanceData.fromJson(Map<String, dynamic> json) => AccountBalanceData(
    balance: json['balance'] == null ? null : json['balance'],
  );

  Map<String, dynamic> toJson() => {
    'balance': balance == null ? null : balance,
  };
}
