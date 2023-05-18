import 'package:flutter/material.dart';

class TodaysEntryProvider with ChangeNotifier {
  late bool _hasEntry;
  late Map<String, dynamic> _data;

  get hasEntry => _hasEntry;
  get data => _data;

  TodaysEntryProvider() {
    _hasEntry = false;
    _data = {"symptoms": [], "hasContact": false};
  }

  void makeEntry() {
    _hasEntry = true;
    notifyListeners();
  }

  void clearEntry() {
    _hasEntry = false;
    notifyListeners();
  }

  void addData(List<String> symptoms, bool hasContact) {
    _data["symptoms"] = symptoms;
    _data["hasContact"] = hasContact;
    print(_data);
    notifyListeners();
  }
}
