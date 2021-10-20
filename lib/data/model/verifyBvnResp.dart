class VerifyBvnResp {
  VerifyBvnResp({
    this.status,
    this.message,
    this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory VerifyBvnResp.fromJson(Map<String, dynamic> json) => VerifyBvnResp(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : Data.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.bvn,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.otherNames,
    this.dob,
  });

  final String bvn;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String otherNames;
  final String dob;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bvn: json['BVN'] == null ? null : json['BVN'],
    phoneNumber: json['phoneNumber'] == null ? null : json['phoneNumber'],
    firstName: json['FirstName'] == null ? null : json['FirstName'],
    lastName: json['LastName'] == null ? null : json['LastName'],
    otherNames: json['OtherNames'] == null ? null : json['OtherNames'],
    dob: json['DOB'] == null ? null : json['DOB'],
  );

  Map<String, dynamic> toJson() => {
    'BVN': bvn == null ? null : bvn,
    'phoneNumber': phoneNumber == null ? null : phoneNumber,
    'FirstName': firstName == null ? null : firstName,
    'LastName': lastName == null ? null : lastName,
    'OtherNames': otherNames == null ? null : otherNames,
    'DOB': dob == null ? null : dob,
  };
}
