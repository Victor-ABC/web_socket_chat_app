import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  String content;
  MaterialAccentColor color;
  Message(this.content, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Text(this.content),
      color: this.color,
    );
  }
}
