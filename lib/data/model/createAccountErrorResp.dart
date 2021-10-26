class AccountCreationErrorResp {
  AccountCreationErrorResp({
    this.status,
    this.message,
    this.error,
  });

  final bool status;
  final String message;
  final Error error;

  factory AccountCreationErrorResp.fromJson(Map<String, dynamic> json) => AccountCreationErrorResp(
    status: json['status'] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "error": error == null ? null : error.toJson(),
  };
}

class Error {
  Error({
    this.email,
    this.password,
  });

  final List<String> email;
  final List<String> password;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    email: json["email"] == null ? null : List<String>.from(json["email"].map((x) => x)),
    password: json["password"] == null ? null : List<String>.from(json["password"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : List<dynamic>.from(email.map((x) => x)),
    "password": password == null ? null : List<dynamic>.from(password.map((x) => x)),
  };
}
