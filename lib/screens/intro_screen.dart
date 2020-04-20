import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmylife/providers/save_data_provider.dart';
import 'package:workmylife/screens/daywise_screen.dart';
import 'package:workmylife/screens/random_screen.dart';
import 'package:workmylife/screens/widgets/intro_btn.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controlAnimation();
  }

  _controlAnimation() {
    _fadeControllerHey =
        AnimationController(vsync: this, duration: const Duration(seconds: 50));
    _fadeAnimationHey = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _fadeControllerHey,
            curve: Interval(0.3, 1.0, curve: Curves.easeInOut)));

    _fadeAnimationHey.addListener(() {
      setState(() {
        if (_fadeAnimationHey.value == 1.0) {
          _isBtnVisible = true;
          Timer(Duration(seconds: 1), () {
            _fadeControllerBtns.forward();
            _fadeAnimationBtns.addListener(() {
              setState(() {
                if (_fadeAnimationBtns.value == 0.0) {
                  _isAnimationCompleted = true;
                }
              });
            });
          });
        }
      });
    });

    _fadeControllerBtns =
        AnimationController(vsync: this, duration: const Duration(seconds: 50));
    _fadeAnimationBtns = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _fadeControllerBtns, curve: Curves.easeInOut));

    _fadeControllerHey.forward();
  }

  Animation<double> _fadeAnimationHey;
  AnimationController _fadeControllerHey;
  Animation<double> _fadeAnimationBtns;
  AnimationController _fadeControllerBtns;

  bool _isBtnVisible = false;
  bool _isAnimationCompleted = false;

  @override
  void dispose() {
    _fadeControllerHey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _saveData = Provider.of<SaveData>(context);
    _saveData.getDate();
    _saveData.btnPressed();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2 + 50,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff161616),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffAFA4A4).withOpacity(0.3),
                        blurRadius: 10,
                      )
                    ]),
                child: Center(
                    child: _isBtnVisible
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text("Please select the mode",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        WhiteBtn("Random", () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RandomScreen()));
                                        }),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        WhiteBtn("Day wise", () {
                                          if (!_saveData.isBtnAlreadyPressed ||
                                              DateTime.now().isAfter(
                                                  DateTime.parse(
                                                      _saveData.endDate))) {
                                            _saveData.setDate(
                                                DateTime.now().weekday,
                                                DateTime.now().day + 7);
                                          }
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DayWiseScreen()));
                                        }),
                                      ],
                                    ),
                                  ),
                                  _isAnimationCompleted
                                      ? Container()
                                      : AnimatedBuilder(
                                          animation: _fadeAnimationBtns,
                                          builder: (_, child) {
                                            return Positioned.fill(
                                              bottom: -20,
                                              child: Container(
                                                color: Color(0xff161616)
                                                    .withOpacity(
                                                        _fadeAnimationBtns
                                                            .value),
                                              ),
                                            );
                                          })
                                ],
                              )
                            ],
                          )
                        : AnimatedBuilder(
                            animation: _fadeAnimationHey,
                            builder: (_, child) {
                              return Text("Hey There !",
                                  style: TextStyle(
                                      color: Colors.white
                                          .withOpacity(_fadeAnimationHey.value),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w200));
                            })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
