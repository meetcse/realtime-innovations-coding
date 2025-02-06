class EmployeeModel {
  int? id;
  String? name;
  String? role;
  String? startDate;
  String? endDate;

  EmployeeModel({this.endDate, this.id, this.name, this.role, this.startDate});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['role'] = role;
    data['name'] = name;
    data['startDate'] = startDate;
    data['endDate'] = endDate;

    return data;
  }
}
