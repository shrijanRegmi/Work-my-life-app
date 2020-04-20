import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workmylife/models/exercise.dart';

class WorkoutScreen extends StatefulWidget {
  final List<Exercise> _exercises;
  final _reps;
  final int _sets;
  WorkoutScreen(this._exercises, this._reps, this._sets);
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isPlaying = false;

  int _exerciseTime = 0;
  int _restTime = 41;
  int _index = 0;
  int _sets = 1;

  Timer _exerciseTimer;
  Timer _restTimer;

  String _exerciseState = "";
  String _mode = "Manual";

  _startExerciseTimer() {
    _exerciseTimer =
        Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_exerciseTime < 1 || !_isPlaying) {
          timer.cancel();
          if (_exerciseTime < 1) {
            _exerciseState = "Completed";
            _startRestTimer();
          }
        } else {
          _exerciseTime--;
        }
      });
    });
  }

  _startRestTimer() {
    _restTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_restTime < 1 || !_isPlaying) {
          timer.cancel();
          if (_restTime < 1) {
            if (_index + 1 < widget._exercises.length) {
              _index++;
              _showInfoDialog("timer");
            } else {
              if (_sets < widget._sets) {
                _isPlaying = false;
                _showNewSetStartDialog();
              } else {
                _isPlaying = false;
                _showCompletedDialog();
              }
            }
            _exerciseState = "";
          }
        } else {
          _restTime = _restTime - 1;
        }
      });
    });
  }

  _showInfoDialog(final _source) async {
    await Future.delayed(Duration(milliseconds: 100));
    if (_mode == "Auto" && _source != "info") {
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
        setState(() {
          _isPlaying = true;
          if (widget._reps != "auto") {
            setState(() {
              _exerciseTime =
                  (int.parse(widget._reps) * widget._exercises[_index].duration)
                      .toInt();
            });
          } else {
            setState(() {
              _exerciseTime = (20 * widget._exercises[_index].duration).toInt();
            });
          }
          _restTime = 41;
        });
        _startExerciseTimer();
      });
    }
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return StatefulBuilder(builder: (_, setState) {
            return AlertDialog(
              title: Text(
                widget._exercises[_index].title,
              ),
              content: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Image.asset(widget._exercises[_index].imgPath,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("ka kjfjdlkjf alks jakla  kla j lkajlkjajl",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                _source != "info" && _source != "timer"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Select the mode: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300)),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_mode == "Auto") {
                                      _mode = "Manual";
                                    } else {
                                      _mode = "Auto";
                                    }
                                  });
                                  _setStateTime();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ClipOval(
                                    child: Container(
                                        color: Colors.black87,
                                        width: 40,
                                        height: 40,
                                        child: Center(
                                            child: Text(_mode.substring(0, 1),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("$_mode mode"),
                              ));
                              Navigator.pop(context);
                              setState(() {
                                _isPlaying = true;
                                if (widget._reps != "auto") {
                                  _exerciseTime = (int.parse(widget._reps) *
                                          widget._exercises[_index].duration)
                                      .toInt();
                                } else {
                                  _exerciseTime =
                                      (20 * widget._exercises[_index].duration)
                                          .toInt();
                                }
                                _restTime = 41;
                              });
                              _startExerciseTimer();
                            },
                            icon: Icon(Icons.check),
                            iconSize: 30,
                          )
                        ],
                      )
                    : _mode == "Auto" && _source == "timer"
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              if (_source != "info") {
                                setState(() {
                                  _isPlaying = true;
                                  if (widget._reps != "auto") {
                                    _exerciseTime = (int.parse(widget._reps) *
                                            widget._exercises[_index].duration)
                                        .toInt();
                                  } else {
                                    _exerciseTime = (20 *
                                            widget._exercises[_index].duration)
                                        .toInt();
                                  }
                                  _restTime = 41;
                                });
                                _startExerciseTimer();
                              }
                            },
                            icon: Icon(Icons.check),
                            iconSize: 30,
                          )
              ],
            );
          });
        });
  }

  _showCompletedDialog() async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("Completed"),
            content: Text("Well done you have completed all the exersises"),
            actions: <Widget>[
              FlatButton(
                color: Colors.transparent,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Go back"),
              ),
            ],
          );
        });
  }

  _showNewSetStartDialog() async {
    if (_mode == "Auto") {
      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
        setState(() {
          _index = 0;
          _sets++;
          _showInfoDialog("timer");
        });
      });
    }
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("Set-$_sets Completed"),
            content: Text(
                _mode == "Auto" ? "Starting new set..." : "Start new set?"),
            actions: <Widget>[
              _mode == "Auto"
                  ? Container()
                  : FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _index = 0;
                          _sets++;
                          _showInfoDialog("timer");
                        });
                      },
                      color: Colors.transparent,
                      textColor: Colors.black,
                      child: Text("OK"),
                    )
            ],
          );
        });
  }

  @override
  void initState() {
    _showInfoDialog("");
    if (widget._reps != "auto") {
      setState(() {
        _exerciseTime =
            (int.parse(widget._reps) * widget._exercises[_index].duration)
                .toInt();
      });
    } else {
      setState(() {
        _exerciseTime = (20 * widget._exercises[_index].duration).toInt();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_exerciseTimer != null) {
      _exerciseTimer.cancel();
    }
    if (_restTimer != null) {
      _restTimer.cancel();
    }
    super.dispose();
  }

  _setStateTime() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              _appbarSection(),
              Expanded(child: _timerSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appbarSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          Text(
              _exerciseState != ""
                  ? "$_exerciseState (${_index + 1}/${widget._exercises.length})"
                  : "",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          StatefulBuilder(builder: (_, setState) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (_mode == "Auto") {
                    _mode = "Manual";
                  } else {
                    _mode = "Auto";
                  }
                });
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("$_mode mode"),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ClipOval(
                  child: Container(
                      color: Colors.black87,
                      width: 40,
                      height: 40,
                      child: Center(
                          child: Text(_mode.substring(0, 1),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)))),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _timerSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        children: <Widget>[
          _info(),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: SvgPicture.asset("images/timer.svg")),
                Positioned.fill(
                    child: Center(
                        child: _restTime <= 40
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("$_restTime",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 32)),
                                  Text("Rest Time",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22))
                                ],
                              )
                            : Text("$_exerciseTime",
                                style: TextStyle(
                                    color:
                                        _exerciseTime <= 10 && _exerciseTime > 5
                                            ? Colors.yellow[300]
                                            : _exerciseTime <= 5
                                                ? Colors.red[300]
                                                : Colors.white,
                                    fontSize: 32))))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                  if (_isPlaying) {
                    _startExerciseTimer();
                  } else {
                    _exerciseTimer.cancel();
                    if (_restTimer != null) {
                      _restTimer.cancel();
                    }
                  }
                },
                icon: _isPlaying
                    ? Icon(Icons.pause_circle_outline)
                    : Icon(Icons.play_circle_outline),
                color: Colors.white,
                iconSize: 60,
              ),
              Text("Set: $_sets",
                  style: TextStyle(color: Colors.white, fontSize: 20))
            ],
          )
        ],
      ),
    );
  }

  Widget _info() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("${_index + 1}. ${widget._exercises[_index].title}",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          GestureDetector(
            onTap: () {
              _showInfoDialog("info");
            },
            child: ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: Colors.white,
                child: Image.asset(widget._exercises[_index].imgPath,
                    fit: BoxFit.cover),
              ),
            ),
          )
        ],
      ),
    );
  }
}
