class CategoriesOfBillsById {
  CategoriesOfBillsById({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<CategoryByIdData> data;
  final int responsecode;

  factory CategoriesOfBillsById.fromJson(Map<String, dynamic> json) => CategoriesOfBillsById(
    status: json['status'] == null ? null : json['status'],
    message: json['message'] == null ? null : json['message'],
    data: json['data'] == null ? null : List<CategoryByIdData>.from(json['data'].map((x) => CategoryByIdData.fromJson(x))),
    responsecode: json['responsecode'] == null ? null : json['responsecode'],
  );

  Map<String, dynamic> toJson() => {
    'status': status == null ? null : status,
    'message': message == null ? null : message,
    'data': data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    'responsecode': responsecode == null ? null : responsecode,
  };
}

class CategoryByIdData {
  CategoryByIdData({
    this.categoryId,
    this.billerId,
    this.billerCategoryId,
    this.narration,
    this.currencyCode,
    this.currencySymbol,
    this.customerField1,
    this.customerField2,
    this.supportEmail,
    this.surcharge,
    this.url,
    this.logoUrl,
    this.isActive,
    this.shortName,
    this.customSectionUrl,
    this.id,
    this.name,
    this.status,
    this.statusDetails,
    this.requestStatus,
    this.responseDescription,
    this.responseStatus,
  });

  final String categoryId;
  final int billerId;
  final dynamic billerCategoryId;
  final String narration;
  final String currencyCode;
  final String currencySymbol;
  final String customerField1;
  final String customerField2;
  final String supportEmail;
  final int surcharge;
  final dynamic url;
  final String logoUrl;
  final bool isActive;
  final String shortName;
  final String customSectionUrl;
  final String id;
  final String name;
  final bool status;
  final dynamic statusDetails;
  final bool requestStatus;
  final dynamic responseDescription;
  final dynamic responseStatus;

  factory CategoryByIdData.fromJson(Map<String, dynamic> json) => CategoryByIdData(
    categoryId: json['CategoryId'] == null ? null : json['CategoryId'],
    billerId: json['BillerID'] == null ? null : json['BillerID'],
    billerCategoryId: json['BillerCategoryID'],
    narration: json['Narration'] == null ? null : json['Narration'],
    currencyCode: json['CurrencyCode'] == null ? null : json['CurrencyCode'],
    currencySymbol: json['CurrencySymbol'] == null ? null : json['CurrencySymbol'],
    customerField1: json['CustomerField1'] == null ? null : json['CustomerField1'],
    customerField2: json['CustomerField2'] == null ? null : json['CustomerField2'],
    supportEmail: json['SupportEmail'] == null ? null : json['SupportEmail'],
    surcharge: json['Surcharge'] == null ? null : json['Surcharge'],
    url: json['Url'],
    logoUrl: json['LogoUrl'] == null ? null : json['LogoUrl'],
    isActive: json['IsActive'] == null ? null : json['IsActive'],
    shortName: json['ShortName'] == null ? null : json['ShortName'],
    customSectionUrl: json['CustomSectionUrl'] == null ? null : json['CustomSectionUrl'],
    id: json['ID'] == null ? null : json['ID'],
    name: json['Name'] == null ? null : json['Name'],
    status: json['Status'] == null ? null : json['Status'],
    statusDetails: json['StatusDetails'],
    requestStatus: json['RequestStatus'] == null ? null : json['RequestStatus'],
    responseDescription: json['ResponseDescription'],
    responseStatus: json['ResponseStatus'],
  );

  Map<String, dynamic> toJson() => {
    'CategoryId': categoryId == null ? null : categoryId,
    'BillerID': billerId == null ? null : billerId,
    'BillerCategoryID': billerCategoryId,
    'Narration': narration == null ? null : narration,
    'CurrencyCode': currencyCode == null ? null : currencyCode,
    'CurrencySymbol': currencySymbol == null ? null : currencySymbol,
    'CustomerField1': customerField1 == null ? null : customerField1,
    'CustomerField2': customerField2 == null ? null : customerField2,
    'SupportEmail': supportEmail == null ? null : supportEmail,
    'Surcharge': surcharge == null ? null : surcharge,
    'Url': url,
    'LogoUrl': logoUrl == null ? null : logoUrl,
    'IsActive': isActive == null ? null : isActive,
    'ShortName': shortName == null ? null : shortName,
    'CustomSectionUrl': customSectionUrl == null ? null : customSectionUrl,
    'ID': id == null ? null : id,
    'Name': name == null ? null : name,
    'Status': status == null ? null : status,
    'StatusDetails': statusDetails,
    'RequestStatus': requestStatus == null ? null : requestStatus,
    'ResponseDescription': responseDescription,
    'ResponseStatus': responseStatus,
  };
}
