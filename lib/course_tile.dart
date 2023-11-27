import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  final String courseName;
  final String courseId;
  final int courseCredit;
  final String courseGrade;
  final Function()? removeCourse;
  final Function()? editCourse;


  const CourseTile({super.key, required this.courseName,required this.courseId,required this.courseCredit,required this.courseGrade, required this.removeCourse, required this.editCourse});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black, border: Border.all(width: 2, color: Colors.amber),borderRadius: const BorderRadius.horizontal(left: Radius.circular(5), right: Radius.circular(5))),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 17),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  courseName,
                  style: TextStyle(
                    color: Colors.orange[200],
                  ),         
                ),
                Text(
                  courseId,
                  style: TextStyle(
                  fontSize: 10,
                  color: Colors.orange[800],
                  ),
                ),
              ],            
            ),
            Column(
              children: [
                Text(
                  courseCredit.toString(),
                  style: TextStyle(
                    color: Colors.orange[200],
                  ),         
                ),
                Text(
                  'Credits',
                  style: TextStyle(
                  fontSize: 10,
                  color: Colors.orange[800],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  courseGrade,
                  style: TextStyle(
                    color: Colors.orange[200],
                  ),         
                ),
                Text(
                  'Grades',
                  style: TextStyle(
                  fontSize: 10,
                  color: Colors.orange[800],
                  ),
                ),
              ],
            ),
                        
          ],
        ),

        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: editCourse, icon: const Icon(Icons.edit, color: Colors.amber,)),

              IconButton(
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.amber,
                ),
                onPressed: removeCourse,
              ),
            ],
          ),
        ),
    ),
  );
  }
}
