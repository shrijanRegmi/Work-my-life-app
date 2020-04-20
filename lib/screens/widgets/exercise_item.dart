import 'package:flutter/material.dart';
import 'package:workmylife/models/exercise.dart';

class ExerciseItem extends StatefulWidget {
  final int _index;
  final List<Exercise> _list;
  ExerciseItem(this._index, this._list) : super();

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget._list[widget._index].checkVal =
              !widget._list[widget._index].checkVal;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Checkbox(
              activeColor: Colors.deepPurple,
              value: widget._list[widget._index].checkVal,
              onChanged: (value) {
                setState(() {
                  widget._list[widget._index].checkVal = value;
                });
              },
            ),
            SizedBox(
              width: 20,
            ),
            Text(widget._list[widget._index].title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
