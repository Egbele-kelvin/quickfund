class ForgotPasswordReq {
  ForgotPasswordReq({
    this.quest1,
    this.quest2,
    this.answer1,
    this.answer2,
    this.password,
    this.passwordConfirmation,
    this.otp,
    this.phone,
  });

  final dynamic quest1;
  final dynamic quest2;
  final String answer1;
  final String answer2;
  final String password;
  final String passwordConfirmation;
  final String otp;
  final String phone;

  factory ForgotPasswordReq.fromJson(Map<String, dynamic> json) => ForgotPasswordReq(
    quest1: json['quest1'] == null ? null : json['quest1'],
    quest2: json['quest2'] == null ? null : json['quest2'],
    answer1: json['answer1'] == null ? null : json['answer1'],
    answer2: json['answer2'] == null ? null : json['answer2'],
    password: json['password'] == null ? null : json['password'],
    passwordConfirmation: json['password_confirmation'] == null ? null : json['password_confirmation'],
    otp: json['otp'] == null ? null : json['otp'],
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'quest1': quest1 == null ? null : quest1,
    'quest2': quest2 == null ? null : quest2,
    'answer1': answer1 == null ? null : answer1,
    'answer2': answer2 == null ? null : answer2,
    'password': password == null ? null : password,
    'password_confirmation': passwordConfirmation == null ? null : passwordConfirmation,
    'otp': otp == null ? null : otp,
    'phone': phone == null ? null : phone,
  };
}
