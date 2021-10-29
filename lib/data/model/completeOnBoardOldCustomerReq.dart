class CompleteOnBoardOldCustomerReq {
  CompleteOnBoardOldCustomerReq({
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.deviceId,
    this.deviceName,
  });

  final String phone;
  final String password;
  final String passwordConfirmation;
  final String deviceId;
  final String deviceName;

  factory CompleteOnBoardOldCustomerReq.fromJson(Map<String, dynamic> json) => CompleteOnBoardOldCustomerReq(
    phone: json['phone'] == null ? null : json['phone'],
    password: json['password'] == null ? null : json['password'],
    passwordConfirmation: json['password_confirmation'] == null ? null : json['password_confirmation'],
    deviceId: json['device_id'] == null ? null : json['device_id'],
    deviceName: json['device_name'] == null ? null : json['device_name'],
  );

  Map<String, dynamic> toJson() => {
    'phone': phone == null ? null : phone,
    'password': password == null ? null : password,
    'password_confirmation': passwordConfirmation == null ? null : passwordConfirmation,
    'device_id': deviceId == null ? null : deviceId,
    'device_name': deviceName == null ? null : deviceName,
  };
}
