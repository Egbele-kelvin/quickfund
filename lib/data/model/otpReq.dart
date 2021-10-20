class OtpReq {
  OtpReq({
    this.phone,
  });

  final String phone;

  factory OtpReq.fromJson(Map<String, dynamic> json) => OtpReq(
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'phone': phone == null ? null : phone,
  };
}
