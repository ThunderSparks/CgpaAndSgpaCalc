
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'buttons.dart';

class NewTile extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController idController;
  final TextEditingController creditController;
  final TextEditingController gradeController;
  final List? editList;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const NewTile(
      {super.key,
      required this.nameController,
      required this.idController,
      required this.creditController,
      required this.gradeController,
      required this.onSave,
      required this.onCancel,
      this.editList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange,
      content: SizedBox(
        height: 330,
        child: Column(
          children: [
            //Course's Name
            TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(4)],
              textCapitalization: TextCapitalization.characters,
              controller: nameController..text = editList?[0] ?? '',
              decoration: InputDecoration(
                  label: Text(
                    'Course Name',
                    style: TextStyle(color: Colors.orange[50]),
                  ),
                  hintText: 'Eg: CS',
                  hintStyle: TextStyle(color: Colors.amber[50])),
              style: TextStyle(color: Colors.amber[100]),
            ),

            //courses's id
            TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(4)],
              textCapitalization: TextCapitalization.characters,
              controller: idController..text = editList?[1] ?? '',
              decoration: InputDecoration(
                  label: Text(
                    'Course code',
                    style: TextStyle(color: Colors.orange[50]),
                  ),
                  hintText: 'Eg: F111',
                  hintStyle: TextStyle(color: Colors.amber[50])),
              style: TextStyle(color: Colors.amber[100]),
            ),

            //courses's credit
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(1)],
              controller: creditController
                ..text = editList?[2].toString() ?? '',
              decoration: InputDecoration(
                  label: Text(
                    'Credits',
                    style: TextStyle(color: Colors.orange[50]),
                  ),
                  hintText: 'Eg: 4',
                  hintStyle: TextStyle(color: Colors.amber[50])),
              style: TextStyle(color: Colors.amber[100]),
            ),

            //courses's grade
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-E -? ]')),
                LengthLimitingTextInputFormatter(2)
              ],
              textCapitalization: TextCapitalization.characters,
              controller: gradeController..text = editList?[3] ?? '',
              decoration: InputDecoration(
                  label: Text(
                    'Grade',
                    style: TextStyle(color: Colors.orange[50]),
                  ),
                  hintText: 'Eg: A-',
                  hintStyle: TextStyle(color: Colors.amber[50])),
              style: TextStyle(color: Colors.amber[100]),
            ),

            // Cancel or save
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Save
                  Button(
                    name: 'Save',
                    onPressed: onSave,
                  ),

                  // Cancel
                  Button(
                    name: 'Cancel',
                    onPressed: onCancel,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
