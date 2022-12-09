import 'package:appim/src/bloc/provider.dart';
import 'package:appim/src/pages/cobradores_page.dart';
import 'package:appim/src/pages/settings_page.dart';
import 'package:flutter/material.dart';

import 'package:appim/src/pages/home_page.dart';
import 'package:appim/src/pages/login_page.dart';
import 'package:appim/src/pages/producto_page.dart';
import 'package:appim/src/pages/registro_page.dart';
import 'package:appim/src/preferencias_usuarios/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = PreferenciasUsuario();
    print(_prefs.correo);
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'settings': (BuildContext context) => SettingsPage(),
        'cobradores': (BuildContext context) => CobradoresPage(),
        'producto': (BuildContext context) => ProductoPage(),
        'registro': (BuildContext context) => RegistroPage(),
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    ));
  }
}
