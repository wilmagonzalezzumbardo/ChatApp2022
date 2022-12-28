import 'package:fl_12_chatapp/pages/pages.dart';
import 'package:fl_12_chatapp/services/auth_service.dart';
import 'package:fl_12_chatapp/services/socketService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/socketService.dart';
import '../services/socketService.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLogInState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere ... '),
          );
        },
      ),
    );
  }

  Future checkLogInState(BuildContext context) async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);
    final autenticado = await authservice.isLoggedIn();

    if (autenticado == true) {
      //conectar al socket server
      socketService.connect();
      //Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UsuariosPage(),
              transitionDuration: Duration(milliseconds: 8)));
    } else {

      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
