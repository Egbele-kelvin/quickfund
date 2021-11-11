class TransactionHistoryResp {
  TransactionHistoryResp({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<TransactionHistoryDatum> data;
  final int responsecode;

  factory TransactionHistoryResp.fromJson(Map<String, dynamic> json) => TransactionHistoryResp(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<TransactionHistoryDatum>.from(json["data"].map((x) => TransactionHistoryDatum.fromJson(x))),
    responsecode: json["responsecode"] == null ? null : json["responsecode"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "responsecode": responsecode == null ? null : responsecode,
  };
}

class TransactionHistoryDatum {
  TransactionHistoryDatum({
    this.amount,
    this.desc,
    this.date,
    this.reference,
    this.narration,
    this.payerName,
    this.payerAccount,
    this.receiverAccount,
    this.receiverName,
    this.direction,
    this.bank,
    this.isTransfer,
    this.status,
    this.directionText,
  });

  final String amount;
  final String desc;
  final dynamic date;
  final String reference;
  final String narration;
  final String payerName;
  final String payerAccount;
  final String receiverAccount;
  final String receiverName;
  final int direction;
  final String bank;
  final int isTransfer;
  final int status;
  final String directionText;

  factory TransactionHistoryDatum.fromJson(Map<String, dynamic> json) => TransactionHistoryDatum(
    amount: json["amount"] == null ? null : json["amount"],
    desc: json["desc"] == null ? null : json["desc"],
    date: json["date"] == null ? null : json["date"],
    reference: json["reference"] == null ? null : json["reference"],
    narration: json["narration"] == null ? null : json["narration"],
    payerName: json["payer_name"] == null ? null : json["payer_name"],
    payerAccount: json["payer_account"] == null ? null : json["payer_account"],
    receiverAccount: json["receiver_account"] == null ? null : json["receiver_account"],
    receiverName: json["receiver_name"] == null ? null : json["receiver_name"],
    direction: json["direction"] == null ? null : json["direction"],
    bank: json["bank"] == null ? null : json["bank"],
    isTransfer: json["is_transfer"] == null ? null : json["is_transfer"],
    status: json["status"] == null ? null : json["status"],
    directionText: json["direction_text"] == null ? null : json["direction_text"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount == null ? null : amount,
    "desc": desc == null ? null : desc,
    "date": date == null ? null : date,
    "reference": reference == null ? null : reference,
    "narration": narration == null ? null : narration,
    "payer_name": payerName == null ? null : payerName,
    "payer_account": payerAccount == null ? null : payerAccount,
    "receiver_account": receiverAccount == null ? null : receiverAccount,
    "receiver_name": receiverName == null ? null : receiverName,
    "direction": direction == null ? null : direction,
    "bank": bank == null ? null : bank,
    "is_transfer": isTransfer == null ? null : isTransfer,
    "status": status == null ? null : status,
    "direction_text": directionText == null ? null : directionText,
  };
}
