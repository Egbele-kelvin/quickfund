class SetupSecurityQuestion {
  SetupSecurityQuestion({
    this.quest1,
    this.quest2,
    this.answer1,
    this.answer2,
    this.phone,
    this.userId,
    this.otp,
    this.pin,
    this.pinConfirmation,
  });

  final int quest1;
  final String quest2;
  final String answer1;
  final String answer2;
  final String phone;
  final String userId;
  final String otp;
  final String pin;
  final String pinConfirmation;

  factory SetupSecurityQuestion.fromJson(Map<String, dynamic> json) => SetupSecurityQuestion(
    quest1: json['quest1'] == null ? null : json['quest1'],
    quest2: json['quest2'] == null ? null : json['quest2'],
    answer1: json['answer1'] == null ? null : json['answer1'],
    answer2: json['answer2'] == null ? null : json['answer2'],
    phone: json['phone'] == null ? null : json['phone'],
    userId: json['user_id'] == null ? null : json['user_id'],
    otp: json['otp'] == null ? null : json['otp'],
    pin: json['pin'] == null ? null : json['pin'],
    pinConfirmation: json['pin_confirmation'] == null ? null : json['pin_confirmation'],
  );

  Map<String, dynamic> toJson() => {
    'quest1': quest1 == null ? null : quest1,
    'quest2': quest2 == null ? null : quest2,
    'answer1': answer1 == null ? null : answer1,
    'answer2': answer2 == null ? null : answer2,
    'phone': phone == null ? null : phone,
    'user_id': userId == null ? null : userId,
    'otp': otp == null ? null : otp,
    'pin': pin == null ? null : pin,
    'pin_confirmation': pinConfirmation == null ? null : pinConfirmation,
  };
}
