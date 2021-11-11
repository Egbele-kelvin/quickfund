class ResetSecurityQuestionReq {
  ResetSecurityQuestionReq({
    this.quest1,
    this.answer1,
    this.quest2,
    this.answer2,
    this.phone,
    this.userId,
  });

  final dynamic quest1;
  final String answer1;
  final dynamic quest2;
  final String answer2;
  final String phone;
  final dynamic userId;

  factory ResetSecurityQuestionReq.fromJson(Map<String, dynamic> json) => ResetSecurityQuestionReq(
    quest1: json['quest1'] == null ? null : json['quest1'],
    answer1: json['answer1'] == null ? null : json['answer1'],
    quest2: json['quest2'] == null ? null : json['quest2'],
    answer2: json['answer2'] == null ? null : json['answer2'],
    phone: json['phone'] == null ? null : json['phone'],
    userId: json['user_id'] == null ? null : json['user_id'],
  );

  Map<String, dynamic> toJson() => {
    'quest1': quest1 == null ? null : quest1,
    'answer1': answer1 == null ? null : answer1,
    'quest2': quest2 == null ? null : quest2,
    'answer2': answer2 == null ? null : answer2,
    'phone': phone == null ? null : phone,
    'user_id': userId == null ? null : userId,
  };
}
