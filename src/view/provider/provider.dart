import 'package:flutter/cupertino.dart';
import 'package:knovator/src/view/response/dashboard_screen.dart';
import '../../../utilities/database/emp_db.dart';
import '../response/emp_db_response.dart';

class HomeProvider extends ChangeNotifier {
  List<EmployeeDbResponse> _employeeDbList = [];
  List<EmployeeDbResponse> get employeeDbList => _employeeDbList;
  set employeeDbList(List<EmployeeDbResponse> value) {
    _employeeDbList = value;
    notifyListeners();
  }

  fetchData() async {
    employeeDbList = await EmployeeDB().fetchData();
    print(
        '===========================${employeeDbList.length}===========================');
  }

  deleteData(int employeeId) async {
    await EmployeeDB().deleteData(employeeId);
    // await fetchData();
    employeeDbList
        .removeWhere((element) => (element.employeeEducation == employeeId));
    notifyListeners();
  }

  editData(EmployeeDbResponse employeeResponse) async {
    await EmployeeDB().editData(EmployeeDbResponse(
        employeeExperience: employeeResponse.employeeExperience,
        employeeEmail: employeeResponse.employeeEmail,
        employeeName: employeeResponse.employeeName,
        employeeNumber: employeeResponse.employeeNumber,
        employeeEducation: employeeResponse.employeeEducation));
    await fetchData();
    notifyListeners();
  }

  insertData() async {
    int isadd = await EmployeeDB().insertEmployeeData(
      json: EmployeeDbResponse(
        // employeeSrId: int.parse(employeeIdcontroller.text),
        employeeName: employeeNamecontroller.text,
        employeeEmail: employeeEmailcontroller.text,
        employeeNumber: employeeNumbercontroller.text,
        employeeExperience: employeeExperiencecontroller.text,
      ),
    );
    print('==============================$isadd==============================');
  }
}
