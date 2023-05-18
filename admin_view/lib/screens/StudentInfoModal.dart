import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/Student.dart';

class StudentInfoModal extends StatelessWidget {
  Student student;

  StudentInfoModal({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(student.name),
      content: SingleChildScrollView(
        child: Column(
          children: studentInfo(student, context),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Back"),
        )
      ],
    );
  }

  List<Widget> studentInfo(Student student, BuildContext context) {
    Map<String, dynamic> studentMap = student.toJson(student);
    List<Widget> studentInfoWidgetList = [];
    studentMap.forEach((key, value) {
      studentInfoWidgetList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                key,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.centerLeft,
                child: Text((value.toString())))
          ],
        ),
      );
    });

    return studentInfoWidgetList;
  }
}
