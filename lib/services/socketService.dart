import 'package:fl_12_chatapp/globals/environment.dart';
import 'package:fl_12_chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { onLine, offLine, connecting, wilma, nuevoMensaje }

class SocketService extends ChangeNotifier {
  ServerStatus serverStatus = ServerStatus.onLine;
  late IO.Socket socket;
  String cMensaje = '';
  String cNombre = '';
  String cMensaje2 = '';
  String cEstado = '';

  /*
  //constructor, es el inicio de la clase y se va a ejecutar apenas se llame
  SocketService() {
    this.initConfig();
  }
  */

  ServerStatus get serverStatus1 => this.serverStatus;

  IO.Socket get socket1 => this.socket;

  void connect() async {
    //this.socket = IO.io('http://192.168.1.80:3001', {
    //this.socket = IO.io('https://fl11bandnameserver02.herokuapp.com', {
    final token = await AuthService.getToken();
    this.socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true, //consume mas recursos, cada vez que entra un usuario crea una instancia,
      'extraHeaders': 
      {
        'x-token': token
      }
    });
    this.socket.on('connect', (_) {
      socket.emit('mensaje', 'test desde el connect.... del init config');
      this.serverStatus = ServerStatus.onLine;
      this.cEstado = 'onLine';
      notifyListeners();
    });
    this.socket.on('disconnect', (_) {
      this.serverStatus = ServerStatus.offLine;
      this.cEstado = 'offLine';
      notifyListeners();
    });

    this.socket.on('emitir-nuevo-mensaje', (payload) {
      this.serverStatus = ServerStatus.nuevoMensaje;
      this.cMensaje = payload['mensaje'];
      this.cNombre = payload['nombre'];
      if (payload.containsKey('mensaje2')) {
        this.cMensaje2 = payload['mensaje2'];
      } else {
        this.cMensaje2 = "No vino el mensaje2";
      }
      notifyListeners();
    });

    this.socket.on('active-bands', (payload) {});
  }

  void disconnect() {
    this.socket.disconnect();
  }
}
