
class AllBanks {
  AllBanks({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<BankData> data;
  final int responsecode;

  factory AllBanks.fromJson(Map<String, dynamic> json) => AllBanks(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : List<BankData>.from(json['data'].map((x) => BankData.fromJson(x))),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    'responsecode': responsecode == null ? null : responsecode,
  };
}

class BankData {
  BankData({
    this.code,
    this.gateway,
    this.id,
    this.name,
    this.status,
    this.statusDetails,
    this.requestStatus,
    this.responseDescription,
    this.responseStatus,
  });

  final String code;
  final dynamic gateway;
  final String id;
  final String name;
  final bool status;
  final dynamic statusDetails;
  final bool requestStatus;
  final dynamic responseDescription;
  final dynamic responseStatus;

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
    code: json['Code'] == null ? null : json['Code'],
    gateway: json['Gateway'],
    id: json['ID'] == null ? null : json['ID'],
    name: json['Name'] == null ? null : json['Name'],
    status: json['Status'] == null ? null : json['Status'],
    statusDetails: json['StatusDetails'],
    requestStatus: json['RequestStatus'] == null ? null : json['RequestStatus'],
    responseDescription: json['ResponseDescription'],
    responseStatus: json['ResponseStatus'],
  );

  Map<String, dynamic> toJson() => {
    'Code': code == null ? null : code,
    'Gateway': gateway,
    'ID': id == null ? null : id,
    'Name': name == null ? null : name,
    'Status': status == null ? null : status,
    'StatusDetails': statusDetails,
    'RequestStatus': requestStatus == null ? null : requestStatus,
    'ResponseDescription': responseDescription,
    'ResponseStatus': responseStatus,
  };
}
