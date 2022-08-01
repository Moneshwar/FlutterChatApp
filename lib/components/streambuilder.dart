import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'messagebubble.dart';
class StresmBuilderHere extends StatelessWidget {
   StresmBuilderHere({required this.firestore,required this.Curuser}) ;

  final firestore;
  final Curuser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').orderBy('timestamp', descending: false).snapshots(),
      builder:(context,snapshot)
      {
        if(!snapshot.hasData)
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final message=snapshot.data?.docs.reversed;
        List<MessageBubble> messagewidgets=[];
        for(var messages in message!)
        {
          final messagetext=messages.data()['text'];
          final userId=messages.data()['usedmail'];
          if(messagetext.length>0) {
            final messagewidget =
                MessageBubble(messagetext: messagetext, userId: userId,isme: (userId==Curuser.email));
            messagewidgets.add(messagewidget);
          }


        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
            children: messagewidgets,
          ),
        );
      },

    );
  }
}
