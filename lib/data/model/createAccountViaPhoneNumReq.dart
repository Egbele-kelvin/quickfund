class CreateAccountViaPhoneNumReq {
  CreateAccountViaPhoneNumReq({
    this.gender,
    this.phone,
    this.firstName,
    this.lastName,
    this.middleName,
    this.title,
    this.dob,
    this.maritalStatus,
    this.email,
    this.address,
    this.state,
    this.branchId,
    this.selfie,
    this.signature,
    this.password,
    this.passwordConfirmation,
    this.bvn,
    this.deviceId,
    this.deviceName,
  });

  final String gender;
  final String phone;
  final String firstName;
  final String lastName;
  final String middleName;
  final String title;
  final String dob;
  final String maritalStatus;
  final String email;
  final String address;
  final String state;
  final int branchId;
  final String selfie;
  final String signature;
  final String password;
  final String passwordConfirmation;
  final String bvn;
  final String deviceId;
  final String deviceName;

  factory CreateAccountViaPhoneNumReq.fromJson(Map<String, dynamic> json) => CreateAccountViaPhoneNumReq(
    gender: json['gender'] == null ? null : json['gender'],
    phone: json['phone'] == null ? null : json['phone'],
    firstName: json['first_name'] == null ? null : json['first_name'],
    lastName: json['last_name'] == null ? null : json['last_name'],
    middleName: json['middle_name'] == null ? null : json['middle_name'],
    title: json['title'] == null ? null : json['title'],
    dob: json['dob'] == null ? null : json['dob'],
    maritalStatus: json['marital_status'] == null ? null : json['marital_status'],
    email: json['email'] == null ? null : json['email'],
    address: json['address'] == null ? null : json['address'],
    state: json['state'] == null ? null : json['state'],
    branchId: json['branch_id'] == null ? null : json['branch_id'],
    selfie: json['selfie'] == null ? null : json['selfie'],
    signature: json['signature'] == null ? null : json['signature'],
    password: json['password'] == null ? null : json['password'],
    passwordConfirmation: json['password_confirmation'] == null ? null : json['password_confirmation'],
    bvn: json['bvn'] == null ? null : json['bvn'],
    deviceId: json['device_id'] == null ? null : json['device_id'],
    deviceName: json['device_name'] == null ? null : json['device_name'],
  );

  Map<String, dynamic> toJson() => {
    'gender': gender == null ? null : gender,
    'phone': phone == null ? null : phone,
    'first_name': firstName == null ? null : firstName,
    'last_name': lastName == null ? null : lastName,
    'middle_name': middleName == null ? null : middleName,
    'title': title == null ? null : title,
    'dob': dob == null ? null : dob,
    'marital_status': maritalStatus == null ? null : maritalStatus,
    'email': email == null ? null : email,
    'address': address == null ? null : address,
    'state': state == null ? null : state,
    'branch_id': branchId == null ? null : branchId,
    'selfie': selfie == null ? null : selfie,
    'signature': signature == null ? null : signature,
    'password': password == null ? null : password,
    'password_confirmation': passwordConfirmation == null ? null : passwordConfirmation,
    'bvn': bvn == null ? null : bvn,
    'device_id': deviceId == null ? null : deviceId,
    'device_name': deviceName == null ? null : deviceName,
  };
}
