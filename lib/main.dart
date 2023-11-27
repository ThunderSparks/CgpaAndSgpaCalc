
import 'package:flutter/material.dart';
import 'course_tile.dart';
import 'new_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // turning off banner
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CGPA & SGPA Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  int currentSemester = 0;
  num cgpaVal = 0.0;
  num sgpaVal = 0.0;
  num semCredit = 0;
  num totalCredit = 0;
  num semGrade = 0;
  num currentGrade = 0;
  bool startUp = true;

  void redoCalculations() {
    //Sem. Credits
    semCredit = 0;
    for (int i = 0; i < courses[currentSemester].length; i++) {
      semCredit += courses[currentSemester][i][2];
    }

    //total Credits
    totalCredit = 0;
    for (int i = 0; i != courses.length; i++) {
      for (int n = 0; n < courses[i].length; n++) {
        totalCredit += courses[i][n][2];
      }
    }
    //CGPA
    cgpaVal = 0;
    currentGrade = 0;
    for (int i = 0; i != courses.length; i++) {
      for (int n = 0; n < courses[i].length; n++) {
        switch (courses[i][n][3]) {
          case 'A':
            currentGrade = 10;
          case 'A-':
            currentGrade = 9;
          case 'B':
            currentGrade = 8;
          case 'B-':
            currentGrade = 7;
          case 'C':
            currentGrade = 6;
          case 'C-':
            currentGrade = 5;
          case 'D':
            currentGrade = 4;
          case 'D-':
            currentGrade = 3;
          case 'E':
            currentGrade = 2;
          default:
            currentGrade = 0;
        }
        cgpaVal += (currentGrade * courses[i][n][2]);
      }
    }
    cgpaVal = cgpaVal / totalCredit;
    cgpaVal = num.parse(cgpaVal.toStringAsFixed(2));
    //SGPA

    sgpaVal = 0;
    currentGrade = 0;
      for (int n = 0; n < courses[currentSemester].length; n++) {
        switch (courses[currentSemester][n][3]) {
          case 'A':
            currentGrade = 10;
          case 'A-':
            currentGrade = 9;
          case 'B':
            currentGrade = 8;
          case 'B-':
            currentGrade = 7;
          case 'C':
            currentGrade = 6;
          case 'C-':
            currentGrade = 5;
          case 'D':
            currentGrade = 4;
          case 'D-':
            currentGrade = 3;
          case 'E':
            currentGrade = 2;
          default:
            currentGrade = 0;
        }
        sgpaVal += (currentGrade * courses[currentSemester][n][2]);
      }
    
    sgpaVal = sgpaVal / semCredit;
    sgpaVal = num.parse(sgpaVal.toStringAsFixed(2));


    setState(() {
      totalCredit = totalCredit;
      semCredit = semCredit;
      cgpaVal = cgpaVal;
      sgpaVal = sgpaVal;
    });
  }

  void editCourse(index) {
    showDialog(
        context: context,
        builder: (context) {
          return NewTile(
            editList: courses[currentSemester][index],
            nameController: _nameController,
            idController: _idController,
            gradeController: _gradeController,
            creditController: _creditController,
            onSave: () => changeCourse(index),
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void changeCourse(int index) {
    setState(() {
      courses[currentSemester][index] = [
        _nameController.text,
        _idController.text,
        int.parse(_creditController.text),
        _gradeController.text,
      ];

      _nameController.clear();
      _idController.clear();
      _creditController.clear();
      _gradeController.clear();
    });
    redoCalculations();
    Navigator.of(context).pop();
  }

  void deleteCourse(int index) {
    setState(() {
      courses[currentSemester].removeAt(index);
    });
    redoCalculations();
  }

  void addCourse() {
    showDialog(
        context: context,
        builder: (context) {
          return NewTile(
            nameController: _nameController,
            idController: _idController,
            gradeController: _gradeController,
            creditController: _creditController,
            onSave: saveCourse,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void addSemester() {
    setState(() {
      courses.add([]);
      currentSemester = courses.length - 1;
    });
    redoCalculations();
  }

  void deleteSemester() {
    setState(() {
      if (courses.length != 1) {
        courses.removeAt(currentSemester);

        if (currentSemester != 0) {
          currentSemester = currentSemester - 1;
        }
      }
    });
    redoCalculations();
  }

  void switchSemester() {
    setState(() {
      if (currentSemester != courses.length - 1) {
        currentSemester += 1;
      } else {
        currentSemester = 0;
      }
    });
    redoCalculations();
  }

  List<List<List<dynamic>>> courses = [
    [
      ['CS', 'F111', 4, 'A'],
      ['CHEM', 'F111', 1, 'A-'],
    ],
    [
      ['BIO', 'F112', 3, 'B'],
      ['ECO', 'F113', 3, 'C-'],
    ]
  ];

  // saving course
  saveCourse() {
    setState(() {
      courses[currentSemester].insert(courses[currentSemester].length, [
        _nameController.text,
        _idController.text,
        int.parse(_creditController.text),
        _gradeController.text,
      ]);
      _nameController.clear();
      _idController.clear();
      _creditController.clear();
      _gradeController.clear();
    });
    redoCalculations();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (startUp == true) {
      redoCalculations();
      startUp = false;
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shadowColor: Colors.amber[800],
          elevation: 40,
          title: Center(
              child: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 25,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.fade),
          )),
        ),
        body: Center(
          child: Column(
            children: [
              // List of courses
              Expanded(
                child: ListView.builder(
                  itemCount: courses[currentSemester].length,
                  itemBuilder: (context, index) {
                    return CourseTile(
                      courseName: courses[currentSemester][index][0],
                      courseId: courses[currentSemester][index][1],
                      courseCredit: courses[currentSemester][index][2],
                      courseGrade: courses[currentSemester][index][3],
                      removeCourse: () => deleteCourse(index),
                      editCourse: () => editCourse(index),
                    );
                  },
                ),
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //CGPA
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 2, color: Colors.amber),
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(15),
                                right: Radius.circular(5))),
                        height: 50,
                        width: 50,
                        child: Column(
                          children: [
                            Text(
                              cgpaVal.toString(),
                              style: TextStyle(
                                  color: Colors.orange[200], fontSize: 18),
                            ),
                            Text(
                              'CGPA',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //SGPA
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 2, color: Colors.amber),
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(5),
                                right: Radius.circular(5))),
                        height: 50,
                        width: 50,
                        child: Column(
                          children: [
                            Text(
                              sgpaVal.toString(),
                              style: TextStyle(
                                  color: Colors.orange[200], fontSize: 18),
                            ),
                            Text(
                              'SGPA',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Sem. Credits
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 2, color: Colors.amber),
                            borderRadius:  const BorderRadius.horizontal(
                                left: Radius.circular(5),
                                right: Radius.circular(5))),
                        height: 50,
                        width: 80,
                        child: Column(
                          children: [
                            Text(
                              semCredit.toString(),
                              style: TextStyle(
                                  color: Colors.orange[200], fontSize: 18),
                            ),
                            Text(
                              'Sem. Credit',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Total Credit
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 2, color: Colors.amber),
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(5),
                                right: Radius.circular(15))),
                        height: 50,
                        width: 80,
                        child: Column(
                          children: [
                            Text(
                              totalCredit.toString(),
                              style: TextStyle(
                                  color: Colors.orange[200], fontSize: 18),
                            ),
                            Text(
                              'Total Credits',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //Semester Num
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(width: 2, color: Colors.amber),
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(15),
                            right: Radius.circular(15))),
                    margin: const EdgeInsets.only(left: 25, right: 25, top: 17),
                    height: 50,
                    width: 240,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                        right: 18.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.amber,
                            ),
                            onPressed: switchSemester,
                          ),
                          Center(
                            child: Text(
                              'SEMESTER ${currentSemester + 1}',
                              style: TextStyle(color: Colors.orange[200]),
                            ),
                          ),
                          IconButton(
                            icon:
                            const Icon(Icons.delete_rounded, color: Colors.amber),
                            onPressed: deleteSemester,
                          )
                        ],
                      ),
                    ),
                  ),

                  //buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: addSemester,
                        child: const Text('Add semester'),
                      ),
                      TextButton(
                        onPressed: addCourse,
                        child: const Text('Add course'),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
