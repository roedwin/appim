import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  String get token {
    return _prefs?.getString('token') ?? '';
  }

  set token(String value) {
    _prefs?.setString('token', value);
  }

  // GET y SET del correo
  String get correo {
    return _prefs?.getString('correo') ?? '';
  }

  set correo(String value) {
    _prefs?.setString('correo', value);
  }

  // GET y SET del nombre
  String get nombre {
    return _prefs?.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs?.setString('nombre', value);
  }

  // GET y SET del genero
  int get genero {
    return _prefs?.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs?.setInt('genero', value);
  }

  // GET y SET del color
  bool get colorSecundario {
    return _prefs?.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs?.setBool('colorSecundario', value);
  }

  // GET y SET de la última página
  String get ultimaPagina {
    return _prefs?.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs?.setString('ultimaPagina', value);
  }
}
