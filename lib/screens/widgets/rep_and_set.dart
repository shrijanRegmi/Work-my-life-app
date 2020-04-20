import 'package:flutter/material.dart';
import 'package:workmylife/screens/widgets/intro_btn.dart';

class RepAndSet extends StatefulWidget {
  final Function _function;
  RepAndSet(this._function);
  @override
  _RepAndSetState createState() => _RepAndSetState();
}

class _RepAndSetState extends State<RepAndSet> {
  TextEditingController _controller = TextEditingController();
  String _reps = "auto";
  int _sets = 3;

  Future<void> _showEditDialog(final String _source) async {
    return await showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      StatefulBuilder(builder: (context, setState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: _controller,
                                autofocus: true,
                                cursorColor: Colors.black,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: WhiteBtn("Done", () {
                          Navigator.pop(context);
                          setState(() {
                            if (_source == "reps") {
                              _reps = _controller.text;
                            } else {
                              _sets = int.parse(_controller.text);
                            }
                            _controller.clear();
                          });
                          return widget._function(_reps, _sets);
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              return _showEditDialog("reps");
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 3,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFF4313),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffFF4313),
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("$_reps reps",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _showEditDialog("sets");
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 3,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFF4313),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffFF4313),
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("$_sets sets",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//  Row(
//             children: <Widget>[
//               Container(
//                 width: 3,
//                 height: 50,
//                 decoration: BoxDecoration(
//                     color: Color(0xffFF4313),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xffFF4313),
//                         blurRadius: 10,
//                       )
//                     ],
//                     borderRadius: BorderRadius.circular(20)),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("3 sets",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w300)),
//             ],
//           )
