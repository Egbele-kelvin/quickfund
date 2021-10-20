class ListOfSecurityQuestion {
  ListOfSecurityQuestion({
    this.status,
    this.data,
  });

  final bool status;
  final List<dynamic> data;

  factory ListOfSecurityQuestion.fromJson(Map<String, dynamic> json) => ListOfSecurityQuestion(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
  };
}
