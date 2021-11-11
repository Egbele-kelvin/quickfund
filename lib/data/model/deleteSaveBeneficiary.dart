class DeleteSaveBeneficiary {
  DeleteSaveBeneficiary({
    this.beneficiaryId,
  });

  final dynamic beneficiaryId;

  factory DeleteSaveBeneficiary.fromJson(Map<String, dynamic> json) => DeleteSaveBeneficiary(
    beneficiaryId: json['beneficiary_id'] == null ? null : json['beneficiary_id'],
  );

  Map<String, dynamic> toJson() => {
    'beneficiary_id': beneficiaryId == null ? null : beneficiaryId,
  };
}
