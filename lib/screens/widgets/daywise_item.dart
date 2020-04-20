import 'package:flutter/material.dart';
import 'package:workmylife/models/current_date.dart';
import 'package:workmylife/models/exercise.dart';
import 'package:workmylife/screens/widgets/exercise_item.dart';

class DayWiseItem extends StatefulWidget {
  final int _dayCount;
  final int _dayName;
  DayWiseItem(this._dayCount, this._dayName);

  @override
  _DayWiseItemState createState() => _DayWiseItemState();
}

class _DayWiseItemState extends State<DayWiseItem> {
  int _count = 0;
  String _currentDay = "";
  List<Exercise> _list = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget._dayName > 7) {
        _count = widget._dayName - 7;
      } else {
        _count = widget._dayName;
      }
      _currentDay = CurrentDate(_count).setCurrentDay();
      _list = CurrentDate(_count).setList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _count != DateTime.now().weekday
          ? Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: _count == DateTime.now().weekday
                      ? Colors.orange
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Day - ${widget._dayCount}   $_currentDay",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300)),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(color: Colors.deepOrange, blurRadius: 10)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: _count == DateTime.now().weekday
                            ? Colors.orange
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Day - ${widget._dayCount}   $_currentDay",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Please select all that suits your limit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300)),
                  ),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (_, index) {
                          return ExerciseItem(
                            index,
                            _list,
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
