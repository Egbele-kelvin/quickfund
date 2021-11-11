class TransferFunds {
  TransferFunds({
    this.from,
    this.to,
    this.fromName,
    this.toName,
    this.toBankCode,
    this.toBankName,
    this.toKyc,
    this.toBvn,
    this.sessionId,
    this.amount,
    this.narration,
    this.pin,
    this.saveBeneficiary,
  });

  final String from;
  final String to;
  final String fromName;
  final String toName;
  final String toBankCode;
  final String toBankName;
  final String toKyc;
  final String toBvn;
  final String sessionId;
  final dynamic amount;
  final String narration;
  final String pin;
  final bool saveBeneficiary;

  factory TransferFunds.fromJson(Map<String, dynamic> json) => TransferFunds(
    from: json['from'] == null ? null : json['from'],
    to: json['to'] == null ? null : json['to'],
    fromName: json['from_name'] == null ? null : json['from_name'],
    toName: json['to_name'] == null ? null : json['to_name'],
    toBankCode: json['to_bank_code'] == null ? null : json['to_bank_code'],
    toBankName: json['to_bank_name'] == null ? null : json['to_bank_name'],
    toKyc: json['to_kyc'] == null ? null : json['to_kyc'],
    toBvn: json['to_bvn'] == null ? null : json['to_bvn'],
    sessionId: json['session_id'] == null ? null : json['session_id'],
    amount: json['amount'] == null ? null : json['amount'],
    narration: json['narration'] == null ? null : json['narration'],
    pin: json['pin'] == null ? null : json['pin'],
    saveBeneficiary: json['save_beneficiary'] == null ? null : json['save_beneficiary'],
  );

  Map<String, dynamic> toJson() => {
    'from': from == null ? null : from,
    'to': to == null ? null : to,
    'from_name': fromName == null ? null : fromName,
    'to_name': toName == null ? null : toName,
    'to_bank_code': toBankCode == null ? null : toBankCode,
    'to_bank_name': toBankName == null ? null : toBankName,
    'to_kyc': toKyc == null ? null : toKyc,
    'to_bvn': toBvn == null ? null : toBvn,
    'session_id': sessionId == null ? null : sessionId,
    'amount': amount == null ? null : amount,
    'narration': narration == null ? null : narration,
    'pin': pin == null ? null : pin,
    'save_beneficiary': saveBeneficiary == null ? null : saveBeneficiary,
  };
}
