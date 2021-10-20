class CreateAccountViaPhoneNumResp {
  CreateAccountViaPhoneNumResp({
    this.status,
    this.message,
    this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory CreateAccountViaPhoneNumResp.fromJson(Map<String, dynamic> json) => CreateAccountViaPhoneNumResp(
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
    this.accountNumber,
    this.user,
  });

  final String accountNumber;
  final User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accountNumber: json['account_number'] == null ? null : json['account_number'],
    user: json['user'] == null ? null : User.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    'account_number': accountNumber == null ? null : accountNumber,
    'user': user == null ? null : user.toJson(),
  };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.middleName,
    this.title,
    this.phone,
    this.dob,
    this.gender,
    this.maritalStatus,
    this.email,
    this.address,
    this.selfie,
    this.state,
    this.branchId,
    this.signature,
    this.coreId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.customerId,
  });

  final String firstName;
  final String lastName;
  final String middleName;
  final String title;
  final String phone;
  final String dob;
  final String gender;
  final String maritalStatus;
  final String email;
  final String address;
  final String selfie;
  final String state;
  final int branchId;
  final String signature;
  final String coreId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final String customerId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json['first_name'] == null ? null : json['first_name'],
    lastName: json['last_name'] == null ? null : json['last_name'],
    middleName: json['middle_name'] == null ? null : json['middle_name'],
    title: json['title'] == null ? null : json['title'],
    phone: json['phone'] == null ? null : json['phone'],
    dob: json['dob'] == null ? null : json['dob'],
    gender: json['gender'] == null ? null : json['gender'],
    maritalStatus: json['marital_status'] == null ? null : json['marital_status'],
    email: json['email'] == null ? null : json['email'],
    address: json['address'] == null ? null : json['address'],
    selfie: json['selfie'] == null ? null : json['selfie'],
    state: json['state'] == null ? null : json['state'],
    branchId: json['branch_id'] == null ? null : json['branch_id'],
    signature: json['signature'] == null ? null : json['signature'],
    coreId: json['core_id'] == null ? null : json['core_id'],
    updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    id: json['id'] == null ? null : json['id'],
    customerId: json['customer_id'] == null ? null : json['customer_id'],
  );

  Map<String, dynamic> toJson() => {
    'first_name': firstName == null ? null : firstName,
    'last_name': lastName == null ? null : lastName,
    'middle_name': middleName == null ? null : middleName,
    'title': title == null ? null : title,
    'phone': phone == null ? null : phone,
    'dob': dob == null ? null : dob,
    'gender': gender == null ? null : gender,
    'marital_status': maritalStatus == null ? null : maritalStatus,
    'email': email == null ? null : email,
    'address': address == null ? null : address,
    'selfie': selfie == null ? null : selfie,
    'state': state == null ? null : state,
    'branch_id': branchId == null ? null : branchId,
    'signature': signature == null ? null : signature,
    'core_id': coreId == null ? null : coreId,
    'updated_at': updatedAt == null ? null : updatedAt.toIso8601String(),
    'created_at': createdAt == null ? null : createdAt.toIso8601String(),
    'id': id == null ? null : id,
    'customer_id': customerId == null ? null : customerId,
  };
}
