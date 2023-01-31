import 'package:meta/meta.dart';
import 'dart:convert';

EmployeeDbResponse employeeDbResponseFromJson(String str) =>
    EmployeeDbResponse.fromJson(json.decode(str));

String employeeDbResponseToJson(EmployeeDbResponse data) =>
    json.encode(data.toJson());

class EmployeeDbResponse {
  EmployeeDbResponse({
    @required this.employeeEducation,
    @required this.employeeName,
    @required this.employeeEmail,
    @required this.employeeNumber,
    @required this.employeeExperience,
  });

  String? employeeEducation;
  String? employeeName;
  String? employeeEmail;
  String? employeeNumber;
  String? employeeExperience;

  factory EmployeeDbResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeDbResponse(
        employeeEducation: json["employee_education"] == null
            ? ""
            : json["employee_education"],
        employeeName:
            json["employee_name"] == null ? " " : json["employee_name"],
        employeeEmail:
            json["employee_email"] == null ? "" : json["employee_email"],
        employeeNumber:
            json["employee_number"] == null ? "" : json["employee_number"],
        employeeExperience: json["employee_Experience"] == null
            ? ""
            : json["employee_experience"],
      );

  Map<String, dynamic> toJson() => {
        "employee_education":
            employeeEducation == null ? null : employeeEducation,
        "employee_name": employeeName == null ? null : employeeName,
        "employee_email": employeeEmail == null ? null : employeeEmail,
        "employee_number": employeeNumber == null ? null : employeeNumber,
        "employee_experience":
            employeeExperience == null ? null : employeeExperience,
      };
}
// employeeExperiencecontroller 
//  employeeEducationcontroller