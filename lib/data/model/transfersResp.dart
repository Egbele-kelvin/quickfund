class TransferResp {
  TransferResp({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final dynamic data;
  final int responsecode;

  factory TransferResp.fromJson(Map<String, dynamic> json) => TransferResp(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'],
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data,
    'responsecode': responsecode == null ? null : responsecode,
  };
}
