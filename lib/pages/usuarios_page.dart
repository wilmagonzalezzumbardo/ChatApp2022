import 'package:fl_12_chatapp/services/chat_service.dart';
import 'package:fl_12_chatapp/services/socketService.dart';
import 'package:fl_12_chatapp/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/usuario.dart';
import '../services/auth_service.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarioService = new UsuariosService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Usuario> Usuarios = [];
  /*[ Usuario( uid: '1', nombre: 'Wilma', email: 'miguel_moreno20@hotmail.com',  password: '123456', online: false),
      Usuario( uid: '2', nombre: 'Miguel', email: 'miguel_moreno10@hotmail.com', password: '123456', online: true),
      Usuario( uid: '2', nombre: 'Alita', email: 'miguel_moreno30@hotmail.com', password: '123456', online: true),  ];*/

  @override
  void initState() {
    // TODO: implement initState
    this._CargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authservice.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario!.nombre,
          style: TextStyle(color: Color.fromARGB(255, 103, 60, 60)),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            authservice.logout();
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: Icon(
            Icons.start,
            color: Colors.green,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            //child: Icon (Icons.check_circle, color: Colors.blue,),
            child: socketService.cEstado == 'onLine'
                ? Icon(
                    Icons.offline_bolt,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          waterDropColor: Color.fromARGB(255, 212, 36, 159),
          complete: Icon(
            Icons.star,
            color: Colors.orange,
          ),
        ),
        //onRefresh: _CargarUsuarios(_refreshController),
        onRefresh: _CargarUsuarios,
        child: _ListViewUsuarios(Usuarios),
      ),
      //
    );
  }

  ListView _ListViewUsuarios(List<Usuario> usuarios) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuariolisttile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuariolisttile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[50],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      onTap: () {
        print("dentro del ontap");
        print(usuario.nombre);
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          //borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  _CargarUsuarios() async {
    /*
    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      refreshController.refreshCompleted();
    }
    */

    this.Usuarios = await usuarioService.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
