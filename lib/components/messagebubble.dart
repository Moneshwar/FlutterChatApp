import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.messagetext,required this.userId,required this.isme});
  final  messagetext;
  final userId;
  final bool isme;
  dynamic colour;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children:[
            Text(userId,
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 12.0
              ),),
            Material(
              borderRadius:BorderRadius.only(
                topLeft:Radius.circular(isme?30.0:0.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
                topRight: Radius.circular(isme?0.0:30.0),
              ) ,
              elevation: 5.0,
              color: isme?Colors.lightBlueAccent:Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                child: Text(
                  '$messagetext',
                  style: TextStyle(
                    fontSize: 16,
                    color: isme?Colors.white:Colors.black87,
                  ),    ),
              ),
            ),]
      ),
    );
  }
}
