import 'package:fl_12_chatapp/services/auth_service.dart';
import 'package:fl_12_chatapp/services/socketService.dart';
import 'package:fl_12_chatapp/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/mostrar_alerta.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // como que rebota
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Logo(
                  mensaje: 'Messenger',
                ),
                _Form(),
                PiePagina(
                  ruta: 'register',
                  cLineaInferior: 'Crea una ahora!!!',
                  cLineaSuperior: '¿No tienes cuenta?',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();

  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Column(
      children: [
        CustomInput(
            icon: Icons.mail_outlined,
            placeholder: 'Email',
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress),
        CustomInput(
          icon: Icons.lock,
          placeholder: 'Password1',
          textController: passwordCtrl,
          isPassword: true,
        ),
        SizedBox(
          height: 25,
        ),
        BotonAzul(
          onPressed: authService.autenticando == false
              ? () async {
                  FocusScope.of(context).unfocus();
                  final loginOk = await authService.login(
                      emailCtrl.text.trim(), passwordCtrl.text.trim());
                  if (loginOk) {
                    //conectar al socket server
                    socketService.connect();
                    Navigator.pushReplacementNamed(context, 'usuarios');
                  } else {
                    mostrarAlerta(context, "Error", "Revise las credenciales");
                  }
                }
              : () {
                  null;
                },
          text: 'Ingrese',
        ),
        /*
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 150,
            height: 40,
            child: RaisedButton(
              elevation: 2,
              highlightElevation: 5,
              color: Colors.blue,
              shape: StadiumBorder(),
              child: Text("Ingresar"),
              onPressed: () {
              },
            ),
          ),
        ),
        */
      ],
    );
  }
}
