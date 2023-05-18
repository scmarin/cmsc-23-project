import 'package:flutter/material.dart';
import '../provider/todays_entry_provider.dart';
import 'package:provider/provider.dart';

class EditEntry extends StatefulWidget {
  const EditEntry({super.key});

  @override
  State<EditEntry> createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  @override
  void initState() {
    super.initState();
    _data = context.read<TodaysEntryProvider>().data;
  }

  late Map<String, dynamic> _data;
  final _formKey = GlobalKey<FormState>();
  final List<String> _symptoms = [
    "Fever (37.8 C and above)",
    "Feeling feverish",
    "Muscle or joint pains",
    "Cough",
    "Colds",
    "Sore throat",
    "Difficulty of breathing",
    "Diarrhea",
    "Loss of taste",
    "Loss of smell"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editing Today's Entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    Text("Enter Entry for Today", style: headerTextStyle()),
                    Text("Symptoms:", style: subheaderTextStyle()),
                    ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      shrinkWrap: true,
                      itemCount: _symptoms.length,
                      itemBuilder: (context, index) => CheckboxListTile(
                          value: _data["symptoms"].contains(_symptoms[index]),
                          onChanged: (bool? value) {
                            if (value!) {
                              setState(() =>
                                  _data["symptoms"].add(_symptoms[index]));
                            } else {
                              setState(() =>
                                  _data["symptoms"].remove(_symptoms[index]));
                            }
                          },
                          title: Text(_symptoms[index])),
                    ),
                    Text("Symptoms:", style: subheaderTextStyle()),
                    CheckboxListTile(
                      value: _data["hasContact"],
                      onChanged: (bool? value) {
                        setState(() {
                          _data["hasContact"] = value!;
                        });
                      },
                      title: const Text(
                          "Have you had contact with anyone with a confirmed COVID-19 case?"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context
                              .read<TodaysEntryProvider>()
                              .addData(_data["symptoms"], _data["hasContact"]);
                          Navigator.pop(context);
                        },
                        child: const Text("Submit Entry"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle headerTextStyle() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
  }

  TextStyle subheaderTextStyle() {
    return const TextStyle(fontStyle: FontStyle.italic, fontSize: 16);
  }
}
