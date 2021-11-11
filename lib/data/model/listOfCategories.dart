class CategoriesOfBills {
  CategoriesOfBills({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<CategoryData> data;
  final int responsecode;

  factory CategoriesOfBills.fromJson(Map<String, dynamic> json) => CategoriesOfBills(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : List<CategoryData>.from(json['data'].map((x) => CategoryData.fromJson(x))),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    'responsecode': responsecode == null ? null : responsecode,
  };
}

class CategoryData {
  CategoryData({
    this.description,
    this.isAirtime,
    this.billerCategoryId,
    this.id,
    this.name,
    this.status,
    this.statusDetails,
    this.requestStatus,
    this.responseDescription,
    this.responseStatus,
  });

  final String description;
  final bool isAirtime;
  final int billerCategoryId;
  final String id;
  final String name;
  final bool status;
  final dynamic statusDetails;
  final bool requestStatus;
  final dynamic responseDescription;
  final dynamic responseStatus;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    description: json['Description'] == null ? null : json['Description'],
    isAirtime: json['IsAirtime'] == null ? null : json['IsAirtime'],
    billerCategoryId: json['BillerCategoryID'] == null ? null : json['BillerCategoryID'],
    id: json['ID'] == null ? null : json['ID'],
    name: json['Name'] == null ? null : json['Name'],
    status: json['Status'] == null ? null : json['Status'],
    statusDetails: json['StatusDetails'],
    requestStatus: json['RequestStatus'] == null ? null : json['RequestStatus'],
    responseDescription: json['ResponseDescription'],
    responseStatus: json['ResponseStatus'],
  );

  Map<String, dynamic> toJson() => {
    'Description': description == null ? null : description,
    'IsAirtime': isAirtime == null ? null : isAirtime,
    'BillerCategoryID': billerCategoryId == null ? null : billerCategoryId,
    'ID': id == null ? null : id,
    'Name': name == null ? null : name,
    'Status': status == null ? null : status,
    'StatusDetails': statusDetails,
    'RequestStatus': requestStatus == null ? null : requestStatus,
    'ResponseDescription': responseDescription,
    'ResponseStatus': responseStatus,
  };
}
