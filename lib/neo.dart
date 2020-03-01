import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color neoback = Color(0xFFF6F6F6);
Color neoacc = Color(0xC104583E);

BoxDecoration neodec = BoxDecoration(
    color: Color.fromRGBO(246, 246, 246, 1),
    boxShadow: [
      BoxShadow(color: Colors.black12, offset: Offset(10, 10), blurRadius: 10),
      BoxShadow(color: Colors.white, offset: Offset(-10, -10), blurRadius: 10)
    ],
    borderRadius: BorderRadius.all(Radius.circular(20)));

BoxDecoration neodecaccent = BoxDecoration(
    color: Color(0xC104583E),
    boxShadow: [
      BoxShadow(color: Colors.black12, offset: Offset(6, 6), blurRadius: 6),
      BoxShadow(color: Colors.white, offset: Offset(-6, -6), blurRadius: 6)
    ],
    borderRadius: BorderRadius.all(Radius.circular(20)));

class NeoButton extends StatelessWidget {
  NeoButton({@required this.onPressed, this.child});
  final Widget child;
  final GestureTapCallback onPressed;
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: CircleBorder(),
      child: this.child,
      textColor: Colors.black,
    );
  }
}
