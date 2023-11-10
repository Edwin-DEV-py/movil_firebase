// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:parcial2/models/message-model.dart';
import 'package:parcial2/viewModel/message-controller.dart';

class Profile extends StatefulWidget {
  //datos a mostrar en la lista
  final int id;
  final String name;
  final String email;
  final String tel;
  final String cargo;
  final String img;
  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.tel,
    required this.cargo,
    required this.img
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  List<MessageModel> messages = [];
  

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  void _sendController() async{
    _titleController.clear();
    _bodyController.clear();

    setState(() {});
    MessageController2.fetchMessage(widget.id);
  }

  @override
  void initState() {
    super.initState();
    fecthMessages(widget.id);
  }

  //traer los mensajes
  Future<void> fecthMessages(int id) async{
    try{
      final data = await MessageController2.fetchMessage(id);
      setState(() {
        messages = data.map((message){
          return MessageModel(
            email_addressee: message['email_addressee'],
            title: message['title'].toString(), 
            body: message['body'].toString());
        }).toList();
      });
    }catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),backgroundColor: Colors.black,),
      body:Padding(
        padding: EdgeInsets.all(0.0),
        child: SingleChildScrollView(
        child:
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 330,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 224, 22)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child:  ClipOval(
                          child: Image(image: NetworkImage('http://192.168.56.1:8000${widget.img}'), width: 200, height: 200, fit: BoxFit.cover,),
                        ),                )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "${widget.name} - ${widget.cargo}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Text(
                          "Correo: ${widget.email}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),  
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Text(
                          "+57 ${widget.tel}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),     
                ],
            ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ListTile(
                    title: message.email_addressee != widget.id ? Text(
                      message.body
                    )
                    : null,
                    trailing:  message.email_addressee == widget.id ? Text(
                      message.body
                    )
                    : null
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 236, 154)
              ),
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Titulo',
                          ),
                        ),
                        TextField(
                          controller: _bodyController,
                          decoration: InputDecoration(
                            labelText: 'mensage',
                          ),
                        ),
                      ],
                    )
                  ),
                  SizedBox(width: 20,),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          MessageController.fetchMessage(_titleController.text, _bodyController.text, widget.id);
                          _sendController();
                        }, 
                        icon: Icon(Icons.send)
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ),
      )
    );
  }
}