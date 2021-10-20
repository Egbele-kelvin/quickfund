class VerifyBvn {
  VerifyBvn({
    this.bvn,
    this.otp,
    this.phone,
  });

  final String bvn;
  final String otp;
  final String phone;

  factory VerifyBvn.fromJson(Map<String, dynamic> json) => VerifyBvn(
    bvn: json['bvn'] == null ? null : json['bvn'],
    otp: json['otp'] == null ? null : json['otp'],
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'bvn': bvn == null ? null : bvn,
    'otp': otp == null ? null : otp,
    'phone': phone == null ? null : phone,
  };
}
