class VerifyPhoneNumResp {
  VerifyPhoneNumResp({
    this.status,
    this.message,
    this.data,
  });

  final bool status;
  final String message;
  final dynamic data;

  factory VerifyPhoneNumResp.fromJson(Map<String, dynamic> json) => VerifyPhoneNumResp(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data,
  };
}
