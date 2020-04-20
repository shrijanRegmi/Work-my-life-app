import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveData with ChangeNotifier {
  int _startDate = 0;
  String _endDate = "";
  bool _isBtnAlreadyPressed = false;

  SharedPreferences _preferences;

  setDate(final _startDate, final _endDate) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setBool("isPressedFirstTime", true);
    _preferences.setInt("startDate", _startDate);
    _preferences.setString(
        "endDate",
        DateTime(DateTime.now().year, DateTime.now().month, _endDate)
            .toString());
  }

  getDate() async {
    _preferences = await SharedPreferences.getInstance();
    _startDate = _preferences.getInt("startDate") ?? 0;
    _endDate = _preferences.getString("endDate") ?? "";
    notifyListeners();
  }

  btnPressed() async {
    _preferences = await SharedPreferences.getInstance();
    _isBtnAlreadyPressed = _preferences.getBool("isPressedFirstTime");
    notifyListeners();
  }

  int get startDate {
    return _startDate;
  }

  String get endDate {
    return _endDate;
  }

  bool get isBtnAlreadyPressed {
    return _isBtnAlreadyPressed;
  }
}
