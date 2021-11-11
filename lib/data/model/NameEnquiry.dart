class NameEnquiry {
  NameEnquiry({
    this.accountNumber,
    this.bankCode,
  });

  final String accountNumber;
  final String bankCode;

  factory NameEnquiry.fromJson(Map<String, dynamic> json) => NameEnquiry(
    accountNumber: json['account_number'] == null ? null : json['account_number'],
    bankCode: json['bank_code'] == null ? null : json['bank_code'],
  );

  Map<String, dynamic> toJson() => {
    'account_number': accountNumber == null ? null : accountNumber,
    'bank_code': bankCode == null ? null : bankCode,
  };
}
