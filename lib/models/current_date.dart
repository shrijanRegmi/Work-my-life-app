import 'package:workmylife/models/exercise.dart';

class CurrentDate {
  final _date;
  CurrentDate(this._date);

  setCurrentDay() {
    var _currentDay = "";
    switch (_date) {
      case 1:
        _currentDay = "Monday";
        break;
      case 2:
        _currentDay = "Tuesday";
        break;
      case 3:
        _currentDay = "Wednesday";
        break;
      case 4:
        _currentDay = "Thursday";
        break;
      case 5:
        _currentDay = "Friday";
        break;
      case 6:
        _currentDay = "Saturday";
        break;
      case 7:
        _currentDay = "Sunday";
        break;
      default:
    }
    return _currentDay;
  }

  setList() {
    var _list;
    switch (_date) {
      case 1:
        _list = exercisesMonday;
        break;
      case 2:
        _list = exercisesTueday;
        break;
      case 3:
        _list = exercisesWednesday;
        break;
      case 4:
        _list = exercisesThursday;
        break;
      case 5:
        _list = exercisesFriday;
        break;
      case 6:
        _list = exercisesSaturday;
        break;
      case 7:
        _list = exercisesSunday;
        break;
      default:
    }
    return _list;
  }
}
