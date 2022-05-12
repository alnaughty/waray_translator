import 'package:eng_war_translator/services/data_handler.dart';
import 'package:eng_war_translator/services/string_lookup.dart';
import 'package:eng_war_translator/services/translate_helper.dart';

class WarayTranslator extends TranslateHelper {
  final DataHandler _handler = DataHandler();
  final StringLookup _lookup = StringLookup();
  Future<String> translate(String words) async {
    try {
      String _ = _lookup.fullgram(words, source: await _handler.load());
      return _;
      // return ":";
    } catch (e) {
      return words;
    }
  }
}
