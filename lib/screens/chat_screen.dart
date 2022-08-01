import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/streambuilder.dart';
class ChatScreen extends StatefulWidget {
  static String id="chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  dynamic Curuser;
  final _firestore=FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
  final msgtextcontroller=TextEditingController();
  String msgtext='';
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser()
  {
    try{
      final user=_auth.currentUser;
      Curuser=user;
    }
    catch(e)
    {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
               _auth.signOut();
               Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StresmBuilderHere(firestore: _firestore,Curuser: Curuser),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgtextcontroller,
                      onChanged: (value) {
                       msgtext=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      msgtextcontroller.clear();
                      _firestore.collection('messages').add({'text':msgtext,
                      'usedmail':Curuser.email,'timestamp':
                        DateTime.now().toUtc().millisecondsSinceEpoch,});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


