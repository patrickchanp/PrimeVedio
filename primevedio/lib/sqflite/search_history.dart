class SearchValue {
  late String searchWord;
  // late DateTime createTime;

  //时间排序

  SearchValue(this.searchWord);

  SearchValue.fromMap(Map map) {
    searchWord = map[searchWord];
  }
}
