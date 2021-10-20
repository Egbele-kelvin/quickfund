class OtpResp {
  OtpResp({
    this.status,
    this.message,
    this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory OtpResp.fromJson(Map<String, dynamic> json) => OtpResp(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : Data.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.code,
  });

  final String code;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    code: json['code'] == null ? null : json['code'],
  );

  Map<String, dynamic> toJson() => {
    'code': code == null ? null : code,
  };
}
