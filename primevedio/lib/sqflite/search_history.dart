class SearchValue {
  late String word;

  SearchValue(this.word);

  SearchValue.fromMap(Map map) {
    word = map[word];
  }
}
