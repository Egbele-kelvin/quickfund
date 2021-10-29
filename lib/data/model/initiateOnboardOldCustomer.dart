class InitiateOnBoardOldCustomer {
  InitiateOnBoardOldCustomer({
    this.phone,
  });

  final String phone;

  factory InitiateOnBoardOldCustomer.fromJson(Map<String, dynamic> json) => InitiateOnBoardOldCustomer(
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'phone': phone == null ? null : phone,
  };
}
