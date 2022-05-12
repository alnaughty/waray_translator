class Ngrams {
  List<List<String>> init(int n, String text) {
    List<String> src = text.split(" ");
    List<List<String>> ngrams = [];
    for (int i = 0; i < src.length - n + 1; i++) {
      List<String> ff = [];
      for (int j = i; j < i + n; j++) {
        ff.add(src[j]);
      }
      ngrams.add(ff);
    }
    return ngrams;
  }
}
