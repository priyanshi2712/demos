import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knovator/src/view/provider/provider.dart';
import 'package:knovator/src/view/response/emp_db_response.dart';
import 'package:provider/provider.dart';
import '../../../utilities/api/shared_preferences.dart';
import '../../../utilities/routes/routes.dart';
import '../../widget/other/TextFiled.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

final GlobalKey<FormState> _insertFormKey = GlobalKey<FormState>();

final TextEditingController employeeEducationcontroller =
    TextEditingController();
final TextEditingController employeeNamecontroller = TextEditingController();
final TextEditingController employeeEmailcontroller = TextEditingController();
final TextEditingController employeeNumbercontroller = TextEditingController();
final TextEditingController employeeExperiencecontroller =
    TextEditingController();

int? id;
String? name;
String? email;
int? number;
int? age;

final _picker = ImagePicker();
File? _image;
Uint8List? bytesImage;

class _DashboardState extends State<Dashboard> {
  late Future futureAlbum;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<HomeProvider>(builder: (context, provider, _) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              dialog(provider: provider, isAddData: true);
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text("Dashboard"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  SharedPreferencesUtils.preferences!.clear();

                  Navigator.of(context)
                      .pushReplacementNamed(RoutesUtils.logInScreen);

                  HomeProvider signoutGoogle = HomeProvider();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.fetchData();
                        },
                        child: const Text("Get resume"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (provider.employeeDbList.isNotEmpty) ...{
                    ListView.builder(
                        itemCount: provider.employeeDbList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              dense: true,
                              isThreeLine: true,
                              leading: Text(
                                provider.employeeDbList[index].employeeEducation
                                    .toString(),
                              ),
                              title: Text(
                                  provider.employeeDbList[index].employeeName ??
                                      ''),
                              subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.employeeDbList[index]
                                            .employeeEmail ??
                                        ''),
                                    Text(provider.employeeDbList[index]
                                            .employeeNumber ??
                                        ''),
                                  ]),
                              trailing: Wrap(
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () async {
                                      employeeNamecontroller.text = provider
                                          .employeeDbList[index].employeeName!;
                                      employeeEmailcontroller.text = provider
                                          .employeeDbList[index].employeeEmail!;
                                      employeeNumbercontroller.text = provider
                                          .employeeDbList[index]
                                          .employeeNumber!;

                                      employeeExperiencecontroller.text =
                                          provider.employeeDbList[index]
                                              .employeeExperience!;

                                      dialog(
                                          provider: provider,
                                          isAddData: false,
                                          employeeEducation: int.parse(provider
                                              .employeeDbList[index]
                                              .employeeEducation!));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ), // icon-2
                                  IconButton(
                                    onPressed: () async {
                                      await provider.deleteData(int.parse(
                                          provider.employeeDbList[index]
                                              .employeeEducation!));
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  } else ...{
                    const SizedBox()
                  },
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void dialog(
      {required HomeProvider provider,
      bool isAddData = true,
      int employeeEducation = 0}) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                actions: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      Form(
                        key: _insertFormKey,
                        child: Column(
                          children: [
                            CoustomTextFild(
                              customController: employeeEducationcontroller,
                              icons: const Icon(Icons.menu_book),
                              text: 'Enter Education ',
                              textLabel: const Text("Enter your Education"),
                            ),
                            CoustomTextFild(
                              customController: employeeNamecontroller,
                              icons: const Icon(Icons.person),
                              text: 'Enter name',
                              textLabel: const Text("Enter your name"),
                            ),
                            CoustomTextFild(
                              customController: employeeEmailcontroller,
                              icons: const Icon(Icons.mail),
                              text: 'Enter email ',
                              textLabel: const Text("Enter your email"),
                            ),
                            CoustomTextFild(
                              customController: employeeNumbercontroller,
                              icons: const Icon(Icons.dialpad),
                              text: 'Enter number',
                              textLabel: const Text("Enter your number"),
                            ),
                            CoustomTextFild(
                              customController: employeeExperiencecontroller,
                              icons: const Icon(Icons.computer),
                              text: 'Enter Experience',
                              textLabel: const Text("Enter youe Experience"),
                            ),
                          ],
                        ),
                      ),
                      if (isAddData) ...{
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                await provider.insertData();
                                await provider.fetchData();

                                setState(() {
                                  employeeEducationcontroller.clear();
                                  employeeNamecontroller.clear();
                                  employeeEmailcontroller.clear();
                                  employeeNumbercontroller.clear();
                                  employeeExperiencecontroller.clear();
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text("ADD DATA"),
                            ),
                          ),
                        ),
                      } else ...{
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                await provider.editData(
                                  EmployeeDbResponse(
                                      employeeExperience:
                                          employeeExperiencecontroller.text,
                                      employeeEmail:
                                          employeeEmailcontroller.text,
                                      employeeName: employeeNamecontroller.text,
                                      employeeNumber:
                                          employeeNumbercontroller.text,
                                      employeeEducation:
                                          employeeEducationcontroller.text),
                                );

                                setState(() {
                                  employeeEducationcontroller.clear();
                                  employeeNamecontroller.clear();
                                  employeeEmailcontroller.clear();
                                  employeeNumbercontroller.clear();
                                  employeeExperiencecontroller.clear();
                                });
                                Navigator.pop(context);
                              },
                              child: const Text("EDIT DATA"),
                            ),
                          ),
                        ),
                      },
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
