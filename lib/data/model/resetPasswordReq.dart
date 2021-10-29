class ResetPassword {
  ResetPassword({
    this.currentPassword,
    this.password,
    this.passwordConfirmation,
    this.otp,
    this.phone,
  });

  final String currentPassword;
  final String password;
  final String passwordConfirmation;
  final String otp;
  final String phone;

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
    currentPassword: json['current_password'] == null ? null : json['current_password'],
    password: json['password'] == null ? null : json['password'],
    passwordConfirmation: json['password_confirmation'] == null ? null : json['password_confirmation'],
    otp: json['otp'] == null ? null : json['otp'],
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'current_password': currentPassword == null ? null : currentPassword,
    'password': password == null ? null : password,
    'password_confirmation': passwordConfirmation == null ? null : passwordConfirmation,
    'otp': otp == null ? null : otp,
    'phone': phone == null ? null : phone,
  };
}
