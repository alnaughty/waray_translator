import 'package:eng_war_translator/services/data_handler.dart';
import 'package:flutter/services.dart';

class TranslateHelper {
  final DataHandler _dh = DataHandler();

  // final Lemmatizer __lemmatizer = Lemmatizer();
  Future<String> pluralizer(String token) async {
    List<String> char = token.split('').toList();
    if (char.isEmpty) return token;
    if (char[char.length - 1] == "s") {
      char.removeAt(char.length - 1);
      return "mga ${await nounChecker(char.join(''))}";
    } else {
      return await nounChecker(char.join(''));
    }
  }

  Future<String> nounChecker(String token) async {
    final List<List<String>> data = await loadNounData;
    print(data);
    List<String> _inp = _dh.getInputData(data);
    int indexOf = _inp.indexOf(token);
    if (indexOf < 0) return token;
    List<String> _targ = _dh.getTargetData(data);
    return _targ[indexOf];
  }

  Future<List<List<String>>> get loadNounData async {
    var dataSet = await rootBundle.loadString("assets/corpus.txt");
    List<String> listLines = dataSet.split("\n");
    List<List<String>> parsets = [];
    for (String line in listLines) {
      parsets.add(line.split(RegExp(r"[\t]")));
    }
    return parsets;
  }
}
