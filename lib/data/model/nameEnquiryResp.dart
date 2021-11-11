class NameEnquiryResp {
  NameEnquiryResp({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final Data data;
  final int responsecode;

  factory NameEnquiryResp.fromJson(Map<String, dynamic> json) => NameEnquiryResp(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : Data.fromJson(json['data']),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : data.toJson(),
    'responsecode': responsecode == null ? null : responsecode,
  };
}

class Data {
  Data({
    this.name,
    this.sessionId,
    this.kyc,
    this.bvn,
  });

  final String name;
  final String sessionId;
  final dynamic kyc;
  final dynamic bvn;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json['name'] == null ? null : json['name'],
    sessionId: json['session_id'] == null ? null : json['session_id'],
    kyc: json['kyc'],
    bvn: json['bvn'],
  );

  Map<String, dynamic> toJson() => {
    'name': name == null ? null : name,
    'session_id': sessionId == null ? null : sessionId,
    'kyc': kyc,
    'bvn': bvn,
  };
}
