import 'package:eng_war_translator/global/constant.dart';
import 'package:eng_war_translator/services/checker.dart';
import 'package:eng_war_translator/services/data_handler.dart';
import 'package:eng_war_translator/services/ngram.dart';
import 'package:eng_war_translator/services/translate_helper.dart';
import 'package:sentence_boundary/sentence_boundary.dart';

class StringLookup extends TranslateHelper {
  final DataHandler _handler = DataHandler();
  final SentenceBoundary _sentenceBoundary = SentenceBoundary();
  final StringChecker _checker = StringChecker();
  final Ngrams _ngrams = Ngrams();
  // String monogram(String ff) {
  //   List<List<String>> data = _sentenceBoundary.detect(ff);
  //   return "";
  // }

  // String bigram(String ff) {
  //   List<List<String>> data = _sentenceBoundary.detect(ff);
  //   return "";
  // }

  String zgram(String ff, {required List<List<String>> source, int n = 3}) {
    List<List<String>> dgram = _ngrams.init(n, ff);
    print("dgram : $dgram");
    List<String> foo = [];
    for (List<String> fgram in dgram) {
      List<List<String>> data = _sentenceBoundary.detect(fgram.join(" "));
      print("EXTRACTED $data");
      for (List<String> datum in data) {
        for (String dat in datum) {
          print(pluralizer(dat));
        }
      }
      // for (List<String> datum in data) {
      //   print("DATUM : $datum");
      //   String foundName = "";
      //   List<String> origDatum = List.from(datum);
      //   List<String> nDat = [];
      //   for (String dd in datum) {
      //     print(dd);
      //     if (names.contains(dd)) {
      //       print("A NAME HAS BEEN FOUND!");
      //       foundName = dd;
      //       dd = "Tom";
      //     }
      //     nDat.add(dd);
      //   }
      //   print("NEW DATUM : $nDat");
      //   print(foundName);
      //   String newData =
      //       nDat.join(" ").toLowerCase().replaceAll(RegExp(r"[^\w\s]"), "");
      //   // List<String> f = _checker.init(
      //   //     nDat.join(" ").toLowerCase().replaceAll(RegExp(r"[^\w\s]"), ""),
      //   //     source: source);
      //   // print(f);
      //   print("NEW DATA : $newData");
      //   List<String> __G = _checker.init(newData, source: source);
      //   print("NEW DATA RESULT: ${__G}");
      //   if (datum.join(" ").toLowerCase().replaceAll(RegExp(r"[^\w\s]"), "") ==
      //       newData.toLowerCase().replaceAll(RegExp(r"[^\w\s]"), "")) {
      //     print("UTRO!");
      //     break;
      //   } else {
      //     foo.add(newData
      //         .replaceAll("Tom", foundName)
      //         .replaceAll("tom", foundName));
      //     break;
      //   }
      // }
    }
    print("FOOO : $foo");
    return foo.join(" ");
  }

  String fullgram(String ff, {required List<List<String>> source}) {
    List<List<String>> data = _sentenceBoundary.detect(ff);
    List<List<String>> foo = [];
    for (List<String> datum in data) {
      /// Check String
      String foundName = "";
      List<String> ndatum = [];
      for (String char in datum) {
        if (names.map((e) => e.toLowerCase()).contains(char.toLowerCase())) {
          foundName = char;
          char = "Tom";
        }
        ndatum.add(char);
      }
      final String __ = ndatum.join(" ");
      List<String> f = _checker.init(__, source: source);
      print(f);
      print(__);
      if (__.toLowerCase() == f.join(" ")) {
        print("WARAY BAG-O");
        foo.add(zgram(
          __,
          source: source,
          n: 1,
        ).split(" "));
      } else {
        foo.add(f.join(" ").replaceAll("Tom", foundName).split(" "));
      }
    }
    return foo.map((e) => e.join(" ")).join(" ").replaceAll("\n", "");
  }
}
