import 'package:fl_12_chatapp/pages/pages.dart';
import 'package:fl_12_chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLogInState(context),
        builder: (context, snapshot) {
          print("dentro de LoadingPAge");
          return Center(
            child: Text('Espere ... '),
          );
        },
      ),
    );
  }

  Future checkLogInState(BuildContext context) async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authservice.isLoggedIn();
    print("autenticado");
    print(autenticado);
    print("autenticado");
    if (autenticado == true) {
      //conectar al socket server
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
