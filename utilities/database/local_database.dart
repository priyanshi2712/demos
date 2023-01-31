import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelep {
  static String dbName = "firebaserevision_db.db";
  static int dbVersion = 1;
  static Database? database;

  static String employeeTable = "employee_table";
  static String employeeID = "employee_sr_id";
  static String employeeEducation = "employee_sr_id";
  static String employeeName = "employee_name";
  static String employeeEmail = "employee_email";
  static String employeeNumber = "employee_number";
  static String employeeExperience = "employee_age";

  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();

    print(
        '============================= $databasePath =============================');

    final path = join(databasePath, dbName);

    database = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $employeeTable($employeeID INTEGER , $employeeName Text, $employeeEmail Text, $employeeNumber Text, PRIMARY KEY ($employeeID AUTOINCREMENT))',
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < newVersion) {
          switch (oldVersion) {
            case 1:
          }
        }
      },
    );
    print('==========================================================');
  }
}
