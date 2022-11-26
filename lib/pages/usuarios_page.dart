import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/usuario.dart';
import '../services/auth_service.dart';

class UsuariosPage extends StatelessWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    final usuarios = [
      Usuario(
          uid: '1',
          nombre: 'Wilma',
          email: 'miguel_moreno20@hotmail.com',
          password: '123456',
          online: false),
      Usuario(
          uid: '2',
          nombre: 'Miguel',
          email: 'miguel_moreno10@hotmail.com',
          password: '123456',
          online: true),
      Usuario(
          uid: '2',
          nombre: 'Alita',
          email: 'miguel_moreno30@hotmail.com',
          password: '123456',
          online: true),
    ];
    final authservice = Provider.of<AuthService>(context, listen: false);
    final usuario = authservice.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario!
          .nombre,
          style: TextStyle(color: Colors.redAccent),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            print("antes de salir...");
            authservice.logout();
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
            child: Icon(
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
        onRefresh: _CargarUsuarios(_refreshController),
        child: _ListViewUsuarios(usuarios),
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

  _CargarUsuarios(RefreshController refreshController) {
    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      refreshController.refreshCompleted();
    }
  }
}
