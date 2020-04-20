import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmylife/models/current_date.dart';
import 'package:workmylife/models/exercise.dart';
import 'package:workmylife/providers/save_data_provider.dart';
import 'package:workmylife/screens/widgets/daywise_item.dart';
import 'package:workmylife/screens/widgets/header.dart';
import 'package:workmylife/screens/widgets/lets_go_btn.dart';
import 'package:workmylife/screens/widgets/rep_and_set.dart';
import 'package:workmylife/screens/workout_screen.dart';

class DayWiseScreen extends StatefulWidget {
  @override
  _DayWiseScreenState createState() => _DayWiseScreenState();
}

class _DayWiseScreenState extends State<DayWiseScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _date = 0;
  List<Exercise> _list = [];

  @override
  void initState() {
    setState(() {
      _list = CurrentDate(DateTime.now().weekday).setList();
    });
    super.initState();
  }

  @override
  void dispose() {
    _list.forEach((f) {
      f.checkVal = false;
    });
    super.dispose();
  }

  var _reps = "auto";
  int _sets = 3;

  @override
  Widget build(BuildContext context) {
    final _saveData = Provider.of<SaveData>(context);
    setState(() {
      _date = _saveData.startDate;
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Container(
          color: Colors.deepPurple,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Header(Colors.orange),
                  SizedBox(
                    height: 20,
                  ),
                  RepAndSet((final _mReps, int _mSets) {
                    setState(() {
                      _reps = _mReps;
                      _sets = _mSets;
                    });
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (_, index) {
                        return DayWiseItem(index + 1, _date++);
                      }),
                  SizedBox(
                    height: 50,
                  ),
                ],
              )),
              LetsGoBtn(Colors.orange, () {
                List<Exercise> _newList = [];
                _list.forEach((f) {
                  if (f.checkVal) {
                    _newList.add(f);
                  }
                });

                if (_newList.length != 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              WorkoutScreen(_newList, _reps, _sets)));
                } else {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text("Please check atleast 1 exercise !"),
                  ));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
