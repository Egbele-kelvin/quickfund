class VerifyPhoneNumReq {
  VerifyPhoneNumReq({
    this.otp,
    this.phone,
  });

  final String otp;
  final String phone;

  factory VerifyPhoneNumReq.fromJson(Map<String, dynamic> json) => VerifyPhoneNumReq(
    otp: json['otp'] == null ? null : json['otp'],
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'otp': otp == null ? null : otp,
    'phone': phone == null ? null : phone,
  };
}
