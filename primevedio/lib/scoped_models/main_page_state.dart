import 'package:scoped_model/scoped_model.dart';

class MainStateModel extends Model {
  int _mainCurrentIndex = 0; //首页tab页当前显示页面

  int get mainCurrentIndex => _mainCurrentIndex;

  set mainCurrentIndex(int value) {
    _mainCurrentIndex = value;
    notifyListeners();
  }

  static MainStateModel of(context) => ScopedModel.of<MainStateModel>(context);
}
