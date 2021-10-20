class InitiateBvn {
  InitiateBvn({
    this.bvn,
  });

  final String bvn;

  factory InitiateBvn.fromJson(Map<String, dynamic> json) => InitiateBvn(
    bvn: json['bvn'] == null ? null : json['bvn'],
  );

  Map<String, dynamic> toJson() => {
    'bvn': bvn == null ? null : bvn,
  };
}
