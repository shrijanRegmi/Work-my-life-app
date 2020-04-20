import 'package:flutter/material.dart';
import 'package:workmylife/models/exercise.dart';
import 'package:workmylife/screens/widgets/exercise_item.dart';
import 'package:workmylife/screens/widgets/header.dart';
import 'package:workmylife/screens/widgets/lets_go_btn.dart';
import 'package:workmylife/screens/widgets/rep_and_set.dart';
import 'package:workmylife/screens/workout_screen.dart';

class RandomScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      exercises.shuffle();
    });
  }

  @override
  void dispose() {
    exercises.forEach((f) {
      f.checkVal = false;
    });
    super.dispose();
  }

  var _reps = "auto";
  int _sets = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Container(
          color: Colors.orange,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Header(Colors.deepPurple),
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
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Please select all that suits your limit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300)),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (_, index) {
                                return ExerciseItem(index, exercises);
                              }),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              LetsGoBtn(Colors.deepPurple, () {
                List<Exercise> _newList = [];
                exercises.forEach((f) {
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
                  _scaffoldKey.currentState.showSnackBar((SnackBar(
                      content: Text("Please check atleast 1 exercise !"))));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
