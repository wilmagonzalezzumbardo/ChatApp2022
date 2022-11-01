import 'package:flutter/material.dart';
import '../pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = 
{
  'usuarios': (_) => UsuariosPage(),
  'chat':     (_) => ChatPage(),
  'login':    (_) => LoginPage(),
  'loading':  (_) => LoadingPage(),
  'register': (_) => RegisterPage()
};
