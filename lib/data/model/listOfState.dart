class ListOfState {
  ListOfState({
    this.status,
    this.message,
    this.data,
  });

  final bool status;
  final String message;
  final List<String> data;

  factory ListOfState.fromJson(Map<String, dynamic> json) => ListOfState(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : List<String>.from(json['data'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : List<dynamic>.from(data.map((x) => x)),
  };
}
