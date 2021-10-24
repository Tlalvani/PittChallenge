import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitt_challenge/services/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:pitt_challenge/services/db.dart';
import 'package:intl/intl.dart';
class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({@required this.messageContent, @required this.messageType});
}



class Chat extends StatefulWidget {

  @override
  const Chat({Key key}) : super(key: key);

  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  List<ChatMessage> messages = [];
  final fieldText = TextEditingController();
  final DbService repo = DbService();
  final CloudFunction cloud = CloudFunction();
  @override
  Widget build(BuildContext context) {
    String input = "";

    void submit(){
      print(input);
      repo.inputChatbot(input);

      setState(() { messages.add(ChatMessage(messageContent: input, messageType: "sender"));
      input = input.toLowerCase();
      if(input.contains("hello") || input.contains("hi")){
        messages.add(ChatMessage(messageContent: "Hello, I am Doogle!", messageType: "receiver"));
      }
      else if(input.contains("goodbye") || input.contains("bye")){
        messages.add(ChatMessage(messageContent: "Goodbye!", messageType: "receiver"));
      }
      else if(input.contains("appointment")){
        messages.add(ChatMessage(messageContent: "No appointments for today!", messageType: "receiver"));
      }
      else if(input.contains("time")){
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
        messages.add(ChatMessage(messageContent: "It is " + formattedDate, messageType: "receiver"));
      }
      else if(input.contains("support")){
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
        messages.add(ChatMessage(messageContent: "I can modify information on your current patients, access them for you, search by a parameter like blood pressure, provide information on nearby hospitals and pharmacies,\n"
            +"and provide summary statistics on your patients", messageType: "receiver"));
      }
      else{
        messages.add(ChatMessage(messageContent: "Sorry, I do not understand!", messageType: "receiver"));
      }

      });
      cloud.sendUID(repo.getUID());
      input = null;
      fieldText.clear();
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  CircleAvatar(
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Doogle",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        Text("Personal Assistant",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                      ],
                    ),
                  ),
                  Icon(Icons.settings,color: Colors.black54,),
                ],
              ),

            ),
          ),
        ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                      onChanged: (text) {
                        input = text;
                      },
                      onFieldSubmitted: (text) {
                        submit();
                      },
                      controller: fieldText,
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      submit();
                    },

                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }

}

