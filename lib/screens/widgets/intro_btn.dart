import 'package:flutter/material.dart';

class WhiteBtn extends StatelessWidget {
  final String _title;
  final Function _function;
  WhiteBtn(this._title, this._function);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: _function,
        child: Container(
          decoration: BoxDecoration(
              color: _title == "Random"
                  ? Colors.deepPurple
                  : _title == "Day wise" ? Colors.orange : Colors.deepOrange,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: _title == "Random"
                        ? Colors.deepPurple
                        : _title == "Day wise" ? Colors.orange : Colors.deepOrange,
                    blurRadius: 5)
              ]),
          height: 50,
          child: Center(
            child: Text("$_title",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                )),
          ),
        ),
      ),
    );
  }
}
