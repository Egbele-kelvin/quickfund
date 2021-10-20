class VerifyOtpReq {
  VerifyOtpReq({
    this.phone,
    this.otp,
  });

  final String phone;
  final String otp;

  factory VerifyOtpReq.fromJson(Map<String, dynamic> json) => VerifyOtpReq(
    phone: json['phone'] == null ? null : json['phone'],
    otp: json['otp'] == null ? null : json['otp'],
  );

  Map<String, dynamic> toJson() => {
    'phone': phone == null ? null : phone,
    'otp': otp == null ? null : otp,
  };
}
