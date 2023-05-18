import 'package:flutter/material.dart';
import '../provider/todays_entry_provider.dart';
import 'package:provider/provider.dart';
import './EditEntry.dart';

class TodaysEntryRoute extends StatefulWidget {
  const TodaysEntryRoute({super.key});

  @override
  State<TodaysEntryRoute> createState() => _TodaysEntryRouteState();
}

class _TodaysEntryRouteState extends State<TodaysEntryRoute> {
  @override
  Widget build(BuildContext context) {
    return (context.watch<TodaysEntryProvider>().hasEntry ? entry() : form());
  }

  Widget form() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Entry"),
      ),
      body: const SymptomsForm(),
    );
  }

  Widget entry() {
    List<Widget> symptomsWidgetList = [];
    for (String symptom
        in context.watch<TodaysEntryProvider>().data["symptoms"]) {
      symptomsWidgetList.add(Text(symptom));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Entry"),
      ),
      body: Column(
        children: [
          Text("Today's Entry Summary", style: headerTextStyle()),
          Text("Symptoms:", style: subheaderTextStyle()),
          (symptomsWidgetList.isEmpty)
              ? const Text("No symptoms.")
              : Column(
                  children: symptomsWidgetList,
                ),
          Text("Close Contact:", style: subheaderTextStyle()),
          Text(context
              .watch<TodaysEntryProvider>()
              .data["hasContact"]
              .toString())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditEntry()));
        },
        child: const Icon(Icons.edit),
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

class SymptomsForm extends StatefulWidget {
  const SymptomsForm({super.key});

  @override
  State<SymptomsForm> createState() => _SymptomsFormState();
}

class _SymptomsFormState extends State<SymptomsForm> {
  final Map<String, dynamic> _data = {
    "symptoms": <String>[],
    "hasContact": false
  };
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
    return Padding(
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
                            setState(
                                () => _data["symptoms"].add(_symptoms[index]));
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
                        context.read<TodaysEntryProvider>().makeEntry();
                      },
                      child: const Text("Submit Entry"))
                ],
              ),
            ),
          )
        ],
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
