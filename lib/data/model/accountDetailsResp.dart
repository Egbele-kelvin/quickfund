class AccountDetails {
  AccountDetails({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<AccountDatum> data;
  final int responsecode;

  factory AccountDetails.fromJson(Map<String, dynamic> json) => AccountDetails(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : List<AccountDatum>.from(json['data'].map((x) => AccountDatum.fromJson(x))),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    'responsecode': responsecode == null ? null : responsecode,
  };
}

class AccountDatum {
  AccountDatum({
    this.id,
    this.userId,
    this.accountNumber,
    this.accountNumberLong,
    this.customerName,
    this.accessLevel,
    this.accountType,
    this.dateCreated,
    this.accountBalance,
    this.availableBalance,
    this.ledgerBalance,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int userId;
  final String accountNumber;
  final String accountNumberLong;
  final String customerName;
  final String accessLevel;
  final String accountType;
  final dynamic dateCreated;
  final dynamic accountBalance;
  final dynamic availableBalance;
  final dynamic ledgerBalance;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AccountDatum.fromJson(Map<String, dynamic> json) => AccountDatum(
    id: json['id'] == null ? null : json['id'],
    userId: json['user_id'] == null ? null : json['user_id'],
    accountNumber: json['account_number'] == null ? null : json['account_number'],
    accountNumberLong: json['account_number_long'] == null ? null : json['account_number_long'],
    customerName: json['customer_name'] == null ? null : json['customer_name'],
    accessLevel: json['access_level'] == null ? null : json['access_level'],
    accountType: json['account_type'] == null ? null : json['account_type'],
    dateCreated: json['date_created'],
    accountBalance: json['account_balance'] == null ? null : json['account_balance'],
    availableBalance: json['available_balance'] == null ? null : json['available_balance'],
    ledgerBalance: json['ledger_balance'] == null ? null : json['ledger_balance'],
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id == null ? null : id,
    'user_id': userId == null ? null : userId,
    'account_number': accountNumber == null ? null : accountNumber,
    'account_number_long': accountNumberLong == null ? null : accountNumberLong,
    'customer_name': customerName == null ? null : customerName,
    'access_level': accessLevel == null ? null : accessLevel,
    'account_type': accountType == null ? null : accountType,
    'date_created': dateCreated,
    'account_balance': accountBalance == null ? null : accountBalance,
    'available_balance': availableBalance == null ? null : availableBalance,
    'ledger_balance': ledgerBalance == null ? null : ledgerBalance,
    'created_at': createdAt == null ? null : createdAt.toIso8601String(),
    'updated_at': updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
