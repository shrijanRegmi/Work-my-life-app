import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {

  final Color _color;
  Header(this._color);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: _color,
        boxShadow: [
          BoxShadow(
              color:  _color,
              blurRadius: 5)
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 27,
          ),
          Expanded(child: SvgPicture.asset('images/workout.svg')),
          SizedBox(
            height: 20,
          ),
          Text("Yeyy !",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w200)),
          SizedBox(
            height: 5,
          ),
          Text("We are good to go now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w200)),
          SizedBox(
            height: 27,
          ),
        ],
      ),
    );
  }
}
