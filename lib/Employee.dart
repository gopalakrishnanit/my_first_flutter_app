class Employee {
  //String id;
  String affiliate_name;
  String rank_name;

  Employee({this.affiliate_name, this.rank_name});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      // id: json['id'] as String,
      affiliate_name: json['affiliate_name'] as String,
      rank_name: json['rank_name'] as String,
    );
  }
}
