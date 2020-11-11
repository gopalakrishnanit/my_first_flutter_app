class Employee {
  String id;

  // ignore: non_constant_identifier_names
  String affiliate_name;

  // ignore: non_constant_identifier_names
  String rank_name;

  // ignore: non_constant_identifier_names
  Employee({this.affiliate_name, this.rank_name, this.id});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      affiliate_name: json['affiliate_name'] as String,
      rank_name: json['rank_name'] as String,
    );
  }
}
