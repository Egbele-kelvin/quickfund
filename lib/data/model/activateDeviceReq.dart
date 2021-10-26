class ActivateDeviceReq {
  ActivateDeviceReq({
    this.phone,
    this.password,
    this.deviceId,
    this.deviceName,
  });

  final String phone;
  final String password;
  final String deviceId;
  final String deviceName;

  factory ActivateDeviceReq.fromJson(Map<String, dynamic> json) => ActivateDeviceReq(
    phone: json['phone'] == null ? null : json['phone'],
    password: json['password'] == null ? null : json['password'],
    deviceId: json['device_id'] == null ? null : json['device_id'],
    deviceName: json['device_name'] == null ? null : json['device_name']
  );

  Map<String, dynamic> toJson() => {
    'phone': phone == null ? null : phone,
    'password': password == null ? null : password,
    'device_id': deviceId == null ? null : deviceId,
    'device_name': deviceName == null ? null : deviceName
  };
}
