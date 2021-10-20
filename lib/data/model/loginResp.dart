class LoginResp {
  LoginResp({
    this.status,
    this.message,
    this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory LoginResp.fromJson(Map<String, dynamic> json) => LoginResp(
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
    this.token,
  });

  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json['token'] == null ? null : json['token'],
  );

  Map<String, dynamic> toJson() => {
    'token': token == null ? null : token,
  };
}
