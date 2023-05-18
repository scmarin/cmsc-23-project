import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/Student.dart';
import '../providers/StudentProvider.dart';
import 'StudentInfoModal.dart';

class StudentListRoute extends StatefulWidget {
  const StudentListRoute({super.key});

  @override
  State<StudentListRoute> createState() => _StudentListRouteState();
}

class _StudentListRouteState extends State<StudentListRoute> {
  @override
  void initState() {
    super.initState();
    Student studentSample = Student.fromJson({
      'name': "Sean",
      'username': "sejo",
      'college': "CAS",
      'course': "BSCS",
      'studentNo': "2021",
      'preExistingIllnesses': ["Lmao", "lmao 2"],
      'entries': [
        {"symptoms": [], "hasContact": false}
      ],
      'status': "Cleared"
    });
    studentList.add(studentSample);
  }

  List<Student> studentList = [];

  int studentsQuarantined = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
      ),
      body: Column(
        children: [
          Text("Students quarantined: $studentsQuarantined"),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  studentListTile(studentList, index, context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: studentList.length)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => filterDialog(context));
        },
        child: const Icon(Icons.filter_alt_outlined),
      ),
    );
  }

  Widget filterDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter students by..."),
      content: ListView(
        children: [
          ListTile(
            title: const Text("Date"),
            onTap: () {
              print("filter by date");
            },
          ),
          ListTile(
            title: const Text("Course"),
            onTap: () {
              print("filter by course");
            },
          ),
          ListTile(
            title: const Text("College"),
            onTap: () {
              print("filter by college");
            },
          ),
          ListTile(
            title: const Text("Student No."),
            onTap: () {
              print("filter by student no.");
            },
          ),
        ],
      ),
    );
  }

  Widget studentListTile(
      List<Student> studentList, int index, BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(studentList[index].name),
      trailing: TextButton(
        child: const Text("Add to Quarantine"),
        onPressed: () {
          if (studentList[index].status != "Under Quarantine") {
            studentList[index].status = "Under Quarantine";
            setState(() {
              studentsQuarantined++;
            });
          }
        },
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => StudentInfoModal(
            student: studentList[index],
          ),
        );
      },
    );
  }
}
