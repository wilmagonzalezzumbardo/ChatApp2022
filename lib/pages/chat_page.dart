import 'dart:io';
import 'package:fl_12_chatapp/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:fl_12_chatapp/models/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  List<ChatMessage> _messages = [
    /*
    ChatMessage(
        animationController: ,
        uid: '123',
        texto:
            'en la actualidad, el predominio de la población urbana sobre la rural es muy fuerte, pero ello no es óbice para que existan núcleos rurales más o menos importantes'),
    ChatMessage(
        uid: 'a123',
        texto:
            'en la actualidad, el predominio de la población urbana sobre la rural es muy fuerte, pero ello no es óbice para que existan núcleos rurales más o menos importantes'),
    ChatMessage(uid: 'a123', texto: 'Hola Mundo2'),
    ChatMessage(uid: '123', texto: 'Hola Mundo3'),
    ChatMessage(uid: 'a123', texto: 'Hola Mundo4'),
    */
  ];
  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    final provider1 = Provider.of<ClassProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              child: Text("Wi"),
              backgroundColor: Colors.blueAccent[100],
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Wilma Gonzalez',
              style: TextStyle(color: Colors.pink, fontSize: 10),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => /*Text('$i')*/ _messages[i],
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(color: Colors.white),
              child: InputChat1(),
              /*
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _textController,
                          onSubmitted: (_) {
                            _textController.clear();
                            _focusNode.requestFocus();
                          },
                          onChanged: (value) {
                            setState(() {
                              if (value.trim().isNotEmpty) {
                                provider1.estaEscribiendo1 = true;
                              } else {
                                provider1.estaEscribiendo1 = false;
                              }
                            });
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: 'Enviar mensaje',
                          ),
                          focusNode: _focusNode,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: Platform.isIOS
                            ? CupertinoButton(
                                child: Text('Enviar'),
                                onPressed: () {},
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                child: IconTheme(
                                  data: IconThemeData(color: Colors.blue[400]),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                    ),
                                    onPressed:
                                        provider1.estaEscribiendo1 == true
                                            ? () {
                                                print("dentro del onpressed del boton");
                                              }
                                            : null,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              */
            ),
          ],
        ),
      ),
    );
  }

  Widget InputChat1() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (_) {
                  /*
                  _textController.clear();
                  _focusNode.requestFocus();
                  */
                  _handleSubmit();
                },
                onChanged: (String text) {
                  setState(() {
                    if (text.trim().isNotEmpty) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS == false
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _estaEscribiendo == true
                          ? () {
                              _handleSubmit();
                            }
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: _estaEscribiendo == true
                              ? () {
                                  print("dentro del else");
                                  print("on pressed");
                                  _handleSubmit();
                                }
                              : null,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit() {
    if (_textController.text.trim().length == 0) {
      return;
    }
    final newMessage = new ChatMessage(
      uid: '123zzz',
      texto: _textController.text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 2000)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    print("en el handle submit");
    /*
    ChatMessage(texto: _textController.text, uid: '123');
    */
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // finalizar la escucha de los sockets
    for (ChatMessage message in _messages)
    {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

 