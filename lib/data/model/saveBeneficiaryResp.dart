class SaveBeneficiaryResp {
  SaveBeneficiaryResp({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<SaveBeneficiaryData> data;
  final int responsecode;

  factory SaveBeneficiaryResp.fromJson(Map<String, dynamic> json) => SaveBeneficiaryResp(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SaveBeneficiaryData>.from(json["data"].map((x) => SaveBeneficiaryData.fromJson(x))),
    responsecode: json["responsecode"] == null ? null : json["responsecode"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "responsecode": responsecode == null ? null : responsecode,
  };
}

class SaveBeneficiaryData {
  SaveBeneficiaryData({
    this.id,
    this.name,
    this.firstname,
    this.lastname,
    this.middlename,
    this.accountNumber,
    this.bankCode,
    this.phone,
    this.bankName,
    this.kyc,
    this.bvn,
    this.sessionId,
  });

  final int id;
  final String name;
  final String firstname;
  final String lastname;
  final String middlename;
  final String accountNumber;
  final String bankCode;
  final dynamic phone;
  final String bankName;
  final String kyc;
  final String bvn;
  final String sessionId;

  factory SaveBeneficiaryData.fromJson(Map<String, dynamic> json) => SaveBeneficiaryData(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    middlename: json["middlename"] == null ? null : json["middlename"],
    accountNumber: json["account_number"] == null ? null : json["account_number"],
    bankCode: json["bank_code"] == null ? null : json["bank_code"],
    phone: json["phone"],
    bankName: json["bank_name"] == null ? null : json["bank_name"],
    kyc: json["kyc"] == null ? null : json["kyc"],
    bvn: json["bvn"] == null ? null : json["bvn"],
    sessionId: json["session_id"] == null ? null : json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "middlename": middlename == null ? null : middlename,
    "account_number": accountNumber == null ? null : accountNumber,
    "bank_code": bankCode == null ? null : bankCode,
    "phone": phone,
    "bank_name": bankName == null ? null : bankName,
    "kyc": kyc == null ? null : kyc,
    "bvn": bvn == null ? null : bvn,
    "session_id": sessionId == null ? null : sessionId,
  };
}
