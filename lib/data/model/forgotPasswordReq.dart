class ForgotPasswordReq {
  ForgotPasswordReq({
    this.answer1,
    this.answer2,
    this.password,
    this.passwordConfirmation,
    this.phone,
  });

  final String answer1;
  final String answer2;
  final String password;
  final String passwordConfirmation;
  final String phone;

  factory ForgotPasswordReq.fromJson(Map<String, dynamic> json) => ForgotPasswordReq(
    answer1: json['answer1'] == null ? null : json['answer1'],
    answer2: json['answer2'] == null ? null : json['answer2'],
    password: json['password'] == null ? null : json['password'],
    passwordConfirmation: json['password_confirmation'] == null ? null : json['password_confirmation'],
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'answer1': answer1 == null ? null : answer1,
    'answer2': answer2 == null ? null : answer2,
    'password': password == null ? null : password,
    'password_confirmation': passwordConfirmation == null ? null : passwordConfirmation,
    'phone': phone == null ? null : phone,
  };
}
