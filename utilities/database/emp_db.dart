import 'package:sqflite/sqflite.dart';
import '../../src/view/response/emp_db_response.dart';
import 'local_database.dart';

class EmployeeDB {
  Database? database = DatabaseHelep.database;

  Future<int> insertEmployeeData({required EmployeeDbResponse json}) async {
    Map<String, dynamic> toMap = {
      DatabaseHelep.employeeEducation: json.employeeEducation,
      DatabaseHelep.employeeName: json.employeeName,
      DatabaseHelep.employeeEmail: json.employeeEmail,
      DatabaseHelep.employeeNumber: json.employeeNumber,
      DatabaseHelep.employeeExperience: json.employeeExperience
    };
    int id = await database!.insert(DatabaseHelep.employeeTable, toMap);
    return id;
  }

  Future<List<EmployeeDbResponse>> fetchData() async {
    var result = await database!.query(DatabaseHelep.employeeTable);
    print(result);
    List<EmployeeDbResponse> dummyList = [];
    for (var element in result) {
      EmployeeDbResponse employeeDbResponse = EmployeeDbResponse();
      employeeDbResponse = getEmployeeData(employeeDbResponse, element);

      dummyList.add(employeeDbResponse);
    }
    return dummyList;
  }

  EmployeeDbResponse getEmployeeData(
      EmployeeDbResponse employeeDbResponse, Map<String, Object?> result) {
    employeeDbResponse.employeeEducation =
        result[DatabaseHelep.employeeEducation] as dynamic;
    employeeDbResponse.employeeName =
        result[DatabaseHelep.employeeName] as String?;
    employeeDbResponse.employeeEmail =
        result[DatabaseHelep.employeeEmail] as String?;
    employeeDbResponse.employeeNumber =
        result[DatabaseHelep.employeeNumber] as String?;
    employeeDbResponse.employeeExperience =
        result[DatabaseHelep.employeeExperience] as String?;
    return employeeDbResponse;
  }

  deleteData(int id) async {
    var isDelete = await database!.rawQuery(
      'DELETE FROM ${DatabaseHelep.employeeTable} WHERE ${DatabaseHelep.employeeID}=?',
      [id],
    );
    print(isDelete);
  }

  editData(EmployeeDbResponse employeeData) async {
    var isEdit = await database!.rawQuery(
        'UPDATE ${DatabaseHelep.employeeTable} SET ${DatabaseHelep.employeeName}=?, ${DatabaseHelep.employeeEmail}=?,${DatabaseHelep.employeeNumber}=?,${DatabaseHelep.employeeExperience}=?  WHERE ${DatabaseHelep.employeeExperience}=?',
        [
          employeeData.employeeName,
          employeeData.employeeEmail,
          employeeData.employeeNumber,
          employeeData.employeeExperience,
          employeeData.employeeEducation,
        ]);

    print(
        '==============================${isEdit}==============================');
    return isEdit;
  }
}
