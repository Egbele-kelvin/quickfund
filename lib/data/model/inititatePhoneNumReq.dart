class InitiatePhoneReq {
  InitiatePhoneReq({
    this.phone,
  });

  final String phone;

  factory InitiatePhoneReq.fromJson(Map<String, dynamic> json) => InitiatePhoneReq(
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'phone': phone == null ? null : phone,
  };
}
