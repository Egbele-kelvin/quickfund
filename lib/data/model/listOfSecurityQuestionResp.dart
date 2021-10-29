class ListOfSecurityQuestion {
  bool status;
  List<ListedQuestionData> data;

  ListOfSecurityQuestion({this.status, this.data});

  ListOfSecurityQuestion.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<ListedQuestionData>();
      json['data'].forEach((v) {
        data.add(new ListedQuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListedQuestionData {
  int id;
  String question;
  String createdAt;
  String updatedAt;

  ListedQuestionData({this.id, this.question, this.createdAt, this.updatedAt});

  ListedQuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
