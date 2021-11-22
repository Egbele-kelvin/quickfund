class PayBillsReq {
  PayBillsReq({
    this.accountNumber,
    this.accountName,
    this.customerId,
    this.amount,
    this.billerName,
    this.billerId,
    this.categoryId,
    this.categoryName,
    this.bundleName,
    this.bundle,
    this.pin,
  });

  final String accountNumber;
  final String accountName;
  final String customerId;
  final String amount;
  final String billerName;
  final String billerId;
  final String categoryId;
  final String categoryName;
  final String bundleName;
  final String bundle;
  final String pin;

  factory PayBillsReq.fromJson(Map<String, dynamic> json) => PayBillsReq(
    accountNumber: json['account_number'] == null ? null : json['account_number'],
    accountName: json['account_name'] == null ? null : json['account_name'],
    customerId: json['customer_id'] == null ? null : json['customer_id'],
    amount: json['amount'] == null ? null : json['amount'],
    billerName: json['biller_name'] == null ? null : json['biller_name'],
    billerId: json['biller_id'] == null ? null : json['biller_id'],
    categoryId: json['category_id'] == null ? null : json['category_id'],
    categoryName: json['category_name'] == null ? null : json['category_name'],
    bundleName: json['bundle_name'] == null ? null : json['bundle_name'],
    bundle: json['bundle'] == null ? null : json['bundle'],
    pin: json['pin'] == null ? null : json['pin'],
  );

  Map<String, dynamic> toJson() => {
    'account_number': accountNumber == null ? null : accountNumber,
    'account_name': accountName == null ? null : accountName,
    'customer_id': customerId == null ? null : customerId,
    'amount': amount == null ? null : amount,
    'biller_name': billerName == null ? null : billerName,
    'biller_id': billerId == null ? null : billerId,
    'category_id': categoryId == null ? null : categoryId,
    'category_name': categoryName == null ? null : categoryName,
    'bundle_name': bundleName == null ? null : bundleName,
    'bundle': bundle == null ? null : bundle,
    'pin': pin == null ? null : pin,
  };
}
