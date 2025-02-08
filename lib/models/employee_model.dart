class EmployeeModel {
  int? id;
  String? name;
  String? role;
  String? startDate;
  String? endDate;
  int? isDeleted;

  EmployeeModel({this.endDate, this.id, this.name, this.role, this.startDate, this.isDeleted});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['role'] = role;
    data['name'] = name;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['isDeleted'] = isDeleted;

    return data;
  }
}
