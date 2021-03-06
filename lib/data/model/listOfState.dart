class ListOfState {
  ListOfState({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<StateData> data;
  final int responsecode;

  factory ListOfState.fromJson(Map<String, dynamic> json) => ListOfState(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : List<StateData>.from(json['data'].map((x) => StateData.fromJson(x))),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    'responsecode': responsecode == null ? null : responsecode,
  };
}

class StateData {
  StateData({
    this.name,
  });

  final String name;

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
    name: json['name'] == null ? null : json['name'],
  );

  Map<String, dynamic> toJson() => {
    'name': name == null ? null : name,
  };
}
