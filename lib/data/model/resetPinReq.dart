class ResetPin {
  ResetPin({
    this.currentPin,
    this.pin,
    this.pinConfirmation,
    this.otp,
    this.phone,
  });

  final String currentPin;
  final String pin;
  final String pinConfirmation;
  final String otp;
  final String phone;

  factory ResetPin.fromJson(Map<String, dynamic> json) => ResetPin(
    currentPin: json['current_pin'] == null ? null : json['current_pin'],
    pin: json['pin'] == null ? null : json['pin'],
    pinConfirmation: json['pin_confirmation'] == null ? null : json['pin_confirmation'],
    otp: json['otp'] == null ? null : json['otp'],
    phone: json['phone'] == null ? null : json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'current_pin': currentPin == null ? null : currentPin,
    'pin': pin == null ? null : pin,
    'pin_confirmation': pinConfirmation == null ? null : pinConfirmation,
    'otp': otp == null ? null : otp,
    'phone': phone == null ? null : phone,
  };
}
