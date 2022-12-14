import 'package:fl_12_chatapp/routes/routes.dart';
import 'package:fl_12_chatapp/services/auth_service.dart';
import 'package:fl_12_chatapp/services/chat_service.dart';
import 'package:fl_12_chatapp/services/socketService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/provider.dart';

//void main() => runApp(MyApp());

void main()   async
{
  runApp(ManejadorEstado());
} 

class ManejadorEstado extends StatelessWidget {
  //const ManejadorEstado({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) 
  {
    return MultiProvider
    (
      providers: 
      [
        ChangeNotifierProvider
        (
          create: (_) => new ClassProvider()
        ),
        ChangeNotifierProvider
        (
          create: (_) => new AuthService()
        ),
        ChangeNotifierProvider
        (
          create: (_) => new SocketService()
        ),
        ChangeNotifierProvider
        (
          create: (_) => new ChatService()
        ),
      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider1 = Provider.of<ClassProvider>(context);
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'loading',
      routes: appRoutes,
    );
  }
}
