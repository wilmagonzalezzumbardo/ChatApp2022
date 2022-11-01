import 'package:fl_12_chatapp/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // como que rebota
          child: Container(
            height: MediaQuery.of(context).size.height ,
            child: Column(
              children: [
                Logo(mensaje: 'Messenger',),
                _Form(),
                PiePagina(ruta: 'register', cLineaInferior: 'Crea una ahora!!!', cLineaSuperior: '¿No tienes cuenta?',),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            print(emailCtrl.text);
            print(passwordCtrl.text);
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
                print(emailCtrl.text);
                print(passwordCtrl.text);
              },
            ),
          ),
        ),
        */
      ],
    );
  }
}
