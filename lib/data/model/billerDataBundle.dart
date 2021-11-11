// To parse this JSON data, do
//
//     final billerDataBundle = billerDataBundleFromJson(jsonString);

import 'dart:convert';

BillerDataBundle billerDataBundleFromJson(String str) => BillerDataBundle.fromJson(json.decode(str));

String billerDataBundleToJson(BillerDataBundle data) => json.encode(data.toJson());

class BillerDataBundle {
  BillerDataBundle({
    this.status,
    this.message,
    this.data,
    this.responsecode,
  });

  final bool status;
  final String message;
  final List<BillerDataBundleDatum> data;
  final int responsecode;

  factory BillerDataBundle.fromJson(Map<String, dynamic> json) => BillerDataBundle(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<BillerDataBundleDatum>.from(json["data"].map((x) => BillerDataBundleDatum.fromJson(x))),
    responsecode: json["responsecode"] == null ? null : json["responsecode"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "responsecode": responsecode == null ? null : responsecode,
  };
}

class BillerDataBundleDatum {
  BillerDataBundleDatum({
    this.amount,
    this.name,
    this.id,
    this.billerName,
    this.billerId,
    this.categoryName,
    this.categoryId,
  });

  final int amount;
  final String name;
  final String id;
  final String billerName;
  final String billerId;
  final String categoryName;
  final String categoryId;

  factory BillerDataBundleDatum.fromJson(Map<String, dynamic> json) => BillerDataBundleDatum(
    amount: json["Amount"] == null ? null : json["Amount"],
    name: json["Name"] == null ? null : json["Name"],
    id: json["ID"] == null ? null : json["ID"],
    billerName: json["BillerName"] == null ? null : json["BillerName"],
    billerId: json["BillerID"] == null ? null : json["BillerID"],
    categoryName: json["CategoryName"] == null ? null : json["CategoryName"],
    categoryId: json["CategoryID"] == null ? null : json["CategoryID"],
  );

  Map<String, dynamic> toJson() => {
    "Amount": amount == null ? null : amount,
    "Name": name == null ? null : name,
    "ID": id == null ? null : id,
    "BillerName": billerName == null ? null : billerName,
    "BillerID": billerId == null ? null : billerId,
    "CategoryName": categoryName == null ? null : categoryName,
    "CategoryID": categoryId == null ? null : categoryId,
  };
}
