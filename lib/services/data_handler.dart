import 'package:flutter/services.dart';

class DataHandler {
  Future<List<List<String>>> load() async {
    var dataSet = await rootBundle.loadString("assets/corpus.txt");
    List<String> listLines = dataSet.split("\n");
    List<List<String>> parsets = [];
    for (String line in listLines) {
      parsets.add(line.split(RegExp(r"[\t]")));
    }
    return parsets;
  }

  List<String> getInputData(List<List<String>> data) {
    List<String> ff = [];
    for (var x in data) {
      ff.add(x[0]);
    }
    return ff;
  }

  List<String> getTargetData(List<List<String>> data) {
    List<String> ff = [];
    for (var x in data) {
      ff.add(x[x.length - 1]);
    }
    return ff;
  }
}
