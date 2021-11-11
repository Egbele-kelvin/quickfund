class PayBundleResp {
  PayBundleResp({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<dynamic> data;
  final int responsecode;

  factory PayBundleResp.fromJson(Map<String, dynamic> json) => PayBundleResp(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : List<dynamic>.from(json['data'].map((x) => x)),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : List<dynamic>.from(data.map((x) => x)),
    'responsecode': responsecode == null ? null : responsecode,
  };
}
