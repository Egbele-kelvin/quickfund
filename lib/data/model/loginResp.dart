class LoginResp {
  LoginResp({
    this.status,
    this.message,
    this.data,
    this.responseCode,
  });

  final bool status;
  final String message;
  final Data data;
  final int responseCode;

  factory LoginResp.fromJson(Map<String, dynamic> json) => LoginResp(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : Data.fromJson(json['data']),
    responseCode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : data.toJson(),
    'responsecode': responseCode == null ? null : responseCode,
  };
}

class Data {
  Data({
    this.user,
    this.token,
    this.accounts,
  });

  final User user;
  final Token token;
  final List<Account> accounts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json['user'] == null ? null : User.fromJson(json['user']),
    token: json['token'] == null ? null : Token.fromJson(json['token']),
    accounts: json['accounts'] == null ? null : List<Account>.from(json['accounts'].map((x) => Account.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'user': user == null ? null : user.toJson(),
    'token': token == null ? null : token.toJson(),
    'accounts': accounts == null ? null : List<dynamic>.from(accounts.map((x) => x.toJson())),
  };
}

class Account {
  Account({
    this.id,
    this.userId,
    this.accountNumber,
    this.customerName,
    this.accessLevel,
    this.accountType,
    this.dateCreated,
    this.accountBalance,
    this.nuban,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int userId;
  final String accountNumber;
  final dynamic customerName;
  final dynamic accessLevel;
  final dynamic accountType;
  final dynamic dateCreated;
  final int accountBalance;
  final dynamic nuban;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json['id'] == null ? null : json['id'],
    userId: json['user_id'] == null ? null : json['user_id'],
    accountNumber: json['account_number'] == null ? null : json['account_number'],
    customerName: json['customer_name'],
    accessLevel: json['access_level'],
    accountType: json['account_type'],
    dateCreated: json['date_created'],
    accountBalance: json['account_balance'] == null ? null : json['account_balance'],
    nuban: json['nuban'],
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id == null ? null : id,
    'user_id': userId == null ? null : userId,
    'account_number': accountNumber == null ? null : accountNumber,
    'customer_name': customerName,
    'access_level': accessLevel,
    'account_type': accountType,
    'date_created': dateCreated,
    'account_balance': accountBalance == null ? null : accountBalance,
    'nuban': nuban,
    'created_at': createdAt == null ? null : createdAt.toIso8601String(),
    'updated_at': updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class Token {
  Token({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });

  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    tokenType: json['token_type'] == null ? null : json['token_type'],
    expiresIn: json['expires_in'] == null ? null : json['expires_in'],
    accessToken: json['access_token'] == null ? null : json['access_token'],
    refreshToken: json['refresh_token'] == null ? null : json['refresh_token'],
  );

  Map<String, dynamic> toJson() => {
    'token_type': tokenType == null ? null : tokenType,
    'expires_in': expiresIn == null ? null : expiresIn,
    'access_token': accessToken == null ? null : accessToken,
    'refresh_token': refreshToken == null ? null : refreshToken,
  };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.accountTrackRef,
    this.customerId,
    this.title,
    this.maritalStatus,
    this.branchId,
    this.state,
    this.address,
    this.dob,
    this.gender,
    this.phone,
    this.coreId,
    this.email,
    this.selfie,
    this.signature,
    this.mbPin,
    this.status,
    this.lockTime,
    this.statusMessage,
    this.phoneNotification,
    this.emailNotification,
    this.nationale,
    this.identificationNumber,
    this.createdAt,
    this.updatedAt,
    this.accounts,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final dynamic accountTrackRef;
  final String customerId;
  final String title;
  final String maritalStatus;
  final int branchId;
  final String state;
  final String address;
  final String dob;
  final String gender;
  final String phone;
  final dynamic coreId;
  final String email;
  final String selfie;
  final String signature;
  final String mbPin;
  final String status;
  final dynamic lockTime;
  final String statusMessage;
  final int phoneNotification;
  final int emailNotification;
  final dynamic nationale;
  final dynamic identificationNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Account> accounts;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] == null ? null : json['id'],
    firstName: json['first_name'] == null ? null : json['first_name'],
    lastName: json['last_name'] == null ? null : json['last_name'],
    middleName: json['middle_name'] == null ? null : json['middle_name'],
    accountTrackRef: json['account_track_ref'],
    customerId: json['customer_id'] == null ? null : json['customer_id'],
    title: json['title'] == null ? null : json['title'],
    maritalStatus: json['marital_status'] == null ? null : json['marital_status'],
    branchId: json['branch_id'] == null ? null : json['branch_id'],
    state: json['state'] == null ? null : json['state'],
    address: json['address'] == null ? null : json['address'],
    dob: json['dob'] == null ? null : json['dob'],
    gender: json['gender'] == null ? null : json['gender'],
    phone: json['phone'] == null ? null : json['phone'],
    coreId: json['core_id'],
    email: json['email'] == null ? null : json['email'],
    selfie: json['selfie'] == null ? null : json['selfie'],
    signature: json['signature'] == null ? null : json['signature'],
    mbPin: json['mb_pin'] == null ? null : json['mb_pin'],
    status: json['status'] == null ? null : json['status'],
    lockTime: json['lock_time'],
    statusMessage: json['status_message'] == null ? null : json['status_message'],
    phoneNotification: json['phone_notification'] == null ? null : json['phone_notification'],
    emailNotification: json['email_notification'] == null ? null : json['email_notification'],
    nationale: json['nationale'],
    identificationNumber: json['identification_number'],
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
    accounts: json['accounts'] == null ? null : List<Account>.from(json['accounts'].map((x) => Account.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id == null ? null : id,
    'first_name': firstName == null ? null : firstName,
    'last_name': lastName == null ? null : lastName,
    'middle_name': middleName == null ? null : middleName,
    'account_track_ref': accountTrackRef,
    'customer_id': customerId == null ? null : customerId,
    'title': title == null ? null : title,
    'marital_status': maritalStatus == null ? null : maritalStatus,
    'branch_id': branchId == null ? null : branchId,
    'state': state == null ? null : state,
    'address': address == null ? null : address,
    'dob': dob == null ? null : dob,
    'gender': gender == null ? null : gender,
    'phone': phone == null ? null : phone,
    'core_id': coreId,
    'email': email == null ? null : email,
    'selfie': selfie == null ? null : selfie,
    'signature': signature == null ? null : signature,
    'mb_pin': mbPin == null ? null : mbPin,
    'status': status == null ? null : status,
    'lock_time': lockTime,
    'status_message': statusMessage == null ? null : statusMessage,
    'phone_notification': phoneNotification == null ? null : phoneNotification,
    'email_notification': emailNotification == null ? null : emailNotification,
    'nationale': nationale,
    'identification_number': identificationNumber,
    'created_at': createdAt == null ? null : createdAt.toIso8601String(),
    'updated_at': updatedAt == null ? null : updatedAt.toIso8601String(),
    'accounts': accounts == null ? null : List<dynamic>.from(accounts.map((x) => x.toJson())),
  };
}
