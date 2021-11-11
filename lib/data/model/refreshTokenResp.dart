class RefreshTokenResp {
  RefreshTokenResp({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final dynamic message;
  final RefreshTokenData data;
  final int responsecode;

  factory RefreshTokenResp.fromJson(Map<String, dynamic> json) => RefreshTokenResp(
    status: json['status'] == null ? null : json['status'],
    message: json['message'],
    data: json['data'] == null ? null : RefreshTokenData.fromJson(json['data']),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message,
    'data': data == null ? null : data.toJson(),
    'responsecode': responsecode == null ? null : responsecode,
  };
}

class RefreshTokenData {
  RefreshTokenData({
    this.token,
  });

  final Token token;

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) => RefreshTokenData(
    token: json['token'] == null ? null : Token.fromJson(json['token']),
  );

  Map<String, dynamic> toJson() => {
    'token': token == null ? null : token.toJson(),
  };
}

class Token {
  Token({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });

  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    tokenType: json['token_type'] == null ? null : json['token_type'],
    expiresIn: json['expires_in'] == null ? null : json['expires_in'],
    accessToken: json['access_token'] == null ? null : json['access_token'],
    refreshToken: json['refresh_token'] == null ? null : json['refresh_token'],
  );

  Map<String, dynamic> toJson() => {
    'token_type': tokenType == null ? null : tokenType,
    'expires_in': expiresIn == null ? null : expiresIn,
    'access_token': accessToken == null ? null : accessToken,
    'refresh_token': refreshToken == null ? null : refreshToken,
  };
}
