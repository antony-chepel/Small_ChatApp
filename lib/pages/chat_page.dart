import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firabase_chat_app/constants.dart';

User loggedinuser;
final _firestore = FirebaseFirestore.instance;

class ChatPage extends StatefulWidget {
  static const id = "chatroute";


  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _auth = FirebaseAuth.instance;
  final messagecontorller = TextEditingController();
  String message;
  User loggedinuser;

  @override
  void initState() {
    super.initState();
    getUser();
  }

   void getUser(){
     final User user = _auth.currentUser;
     try {
       if(user != null){
         loggedinuser = user;
         print(user.email);
       }
     } on Exception catch (e) {
       print(e);
     }

   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.blueGrey[600],
        title: Text('Chat Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white,),
            onPressed: (){
              _auth.signOut();
              Navigator.pop(context);
            },

          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
                  MessageStream(),
            Container(
             decoration: conteinerdecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: TextField(
                    controller: messagecontorller ,
                    onChanged: (value){
                      message = value;
                    },
                    decoration: textfielddecoration2,
                  )),
                  IconButton(onPressed: (){
                     messagecontorller.clear();
                    _firestore.collection('messages').add({
                      "sender" : loggedinuser,
                      "text" : message,
                    });
                  }, icon: Icon(Icons.send, color: Colors.indigo,),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder:(context,snapshot){
          if(!snapshot.hasData){
              return Center(
             child: CircularProgressIndicator(),
             );
           }
            final db_messages = snapshot.data.docs.reversed;
            List<BubbleMessage> bubblemessage = [];
            for(var message in db_messages){
              final messagetext = message.get('text');
              final sender = message.get('sender');
              final currentuser = loggedinuser.email;
             // if(currentuser == sender){

             // }
              final bubblemessages = BubbleMessage(sender, messagetext, currentuser == sender);
              bubblemessage.add(bubblemessages);
            }
            return Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  reverse: true,
                  children: bubblemessage,
                ),
              ),
            );
        } );
  }
}


class BubbleMessage extends StatelessWidget {
  BubbleMessage(this.sender, this.message,this.isMe);

    String sender;
    String message;

   final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start ,
        children: [
          Text("$sender"),
          Material(
            borderRadius: isMe ? BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10))
                : BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10)),
            elevation: 5,
              color:  isMe? Colors.indigo : Colors.lightBlueAccent,
              child: Padding(
                padding:  EdgeInsets.all(7.0),
                child: Text("$message from $sender",style: TextStyle(fontSize: 20,color: Colors.white),),
              )),
        ],
      ),
    );
  }



}

