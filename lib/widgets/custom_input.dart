import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const BotonAzul({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      /*
      onPressed: () {
        print(emailCtrl.text);
        print(passwordCtrl.text);
      },
      */
      onPressed: this.onPressed,
      child: Container(
        width: 300,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Center(
            child: Text(
          this.text,
          style: TextStyle(color: Colors.white, fontSize: 17),
        )),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  final String mensaje;

  const Logo({Key? key, required this.mensaje}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Center(
            child: Image(
          image: AssetImage("assets/tag-logo.png"),
          height: 130,
        )),
        SizedBox(
          height: 25,
        ),
        Text(
          this.mensaje,
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 45,
        ),
      ],
    );
  }
}

class PiePagina extends StatelessWidget {
  final String ruta;
  final String cLineaSuperior;
  final String cLineaInferior;

  const PiePagina({Key? key, required this.ruta, required this.cLineaSuperior, required this.cLineaInferior})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          this.cLineaSuperior,
          style: TextStyle(
              fontSize: 13, color: Color.fromARGB(255, 102, 104, 105)),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            print("en el gesture detector");
            print(this.ruta);
            Navigator.pushReplacementNamed(context, this.ruta);
          },
          child: Text(
            this.cLineaInferior,
            style: TextStyle(
                fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "Términos y condiciones de uso",
          style: TextStyle(
              fontSize: 13, color: Color.fromARGB(255, 143, 150, 153)),
        ),
      ],
    );
  }
}

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput(
      {Key? key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.pink.withOpacity(.05),
                offset: Offset(0, 5),
                blurRadius: 1)
          ]),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: (isPassword == true) ? true : false,
        decoration: InputDecoration(
          hintText: placeholder,
          prefixIcon: Icon(icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          //icon: Icon(Icons.email),
          //helperText: "Correo2",
          //suffixIcon: Icon(Icons.email_outlined),
        ),
      ),
    );
  }
}
