import 'package:flutter/material.dart';

class LetsGoBtn extends StatelessWidget {

  final Color _color;
  final Function _function;
  LetsGoBtn(this._color, this._function);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        color: _color,
        splashColor: _color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: _function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: Text("<Let's do it/>",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
