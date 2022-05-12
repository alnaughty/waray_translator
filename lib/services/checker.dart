import 'package:eng_war_translator/global/app.dart';
import 'package:eng_war_translator/services/data_handler.dart';

class StringChecker {
  final DataHandler _dh = DataHandler();
  final RegExp _specReg = RegExp(r"[^\w\s]");
  List<String> init(String text, {required List<List<String>> source}) {
    String originalText = text;
    List<String> _inp = _dh.getInputData(source);
    List<String> _inpCopy =
        List.from(_inp.map((e) => e.replaceAll(_specReg, "").toLowerCase()));
    List<String> _target = _dh.getTargetData(source);
    List<String> _targetCopy =
        List.from(_target.map((e) => e.replaceAll(_specReg, "").toLowerCase()));
    List<List<String>> __sourceCopy = List.from(
      source.where(
        (element) => element[0]
            .toLowerCase()
            .replaceAll(_specReg, "")
            .contains(text.replaceAll(_specReg, "").toLowerCase()),
      ),
    );
    List<String> outputs = [
      ...minimizeChoice(text.replaceAll(_specReg, "").toLowerCase(),
          source: __sourceCopy),
    ];
    if (outputs.isEmpty) return [originalText];

    return outputs;
  }

  List<String> minimizeChoice(String text,
      {required List<List<String>> source}) {
    List<String> filtered = [];
    for (List<String> dd in source) {
      for (String dx in dd) {
        List<String> toCheck = dx.split("\t");

        if (toCheck.contains(text) ||
            dx.replaceAll(_specReg, "").toLowerCase() == text) {
          if (filtered.isEmpty) {
            filtered.add(dd[1]);
          }
        }
      }
    }
    return filtered.isEmpty ? text.split(" ") : filtered;
  }
}
