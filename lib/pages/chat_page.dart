import 'dart:io';
import 'package:fl_12_chatapp/models/mensajes_response.dart';
import 'package:fl_12_chatapp/services/auth_service.dart';
import 'package:fl_12_chatapp/services/socketService.dart';
import 'package:fl_12_chatapp/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:fl_12_chatapp/models/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;
  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;

  List<ChatMessage> _messages = [];


  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this!.socketService!.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(this!.chatService!.usuarioPara!.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await this.chatService!.getChat(usuarioID);
    final history = chat.map((m) => new ChatMessage(
        texto: m.mensaje!,
        uid: m.de!,
        animationController: new AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward()));
    print(chat);
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic data) {
    print("tengo mensaje");
    ChatMessage chatMessage = new ChatMessage(
        texto: data['mensaje'],
        uid: data['de'],
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)));
    setState(() {
      _messages.insert(0, chatMessage);
    });

    chatMessage.animationController.forward();
  }

/*  List<ChatMessage> _messages = [
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
  ];*/
 

  @override
  Widget build(BuildContext context) {
    final provider1 = Provider.of<ClassProvider>(context);
    //final chatService = Provider.of<ChatService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(chatService!.usuarioPara!.nombre.substring(0, 2)),
              backgroundColor: Colors.blueAccent[100],
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              chatService!.usuarioPara!.nombre,
              style: TextStyle(color: Colors.pink, fontSize: 10),
            ),
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
                itemBuilder: (_, i) => /*Text('$i') */ _messages[i] ,
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
    final valorTexto = _textController.text;
    final newMessage = new ChatMessage(
      uid: authService!.usuario!.uid,
      texto: _textController.text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 2000)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    /*
    ChatMessage(texto: _textController.text, uid: '123');
    */
    print("en el envio del mensaje");
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _estaEscribiendo = false;
    });

    this.socketService!.socket.emit('mensaje-personal', {
      'de': this.authService!.usuario!.uid,
      'para': this.chatService!.usuarioPara!.uid,
      'mensaje': valorTexto
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // finalizar la escucha de los sockets
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    this!.socketService!.socket.off('mensaje-personal');
    super.dispose();
  }
}
