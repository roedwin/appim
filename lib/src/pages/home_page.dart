import 'package:appim/src/bloc/provider.dart';
import 'package:appim/src/preferencias_usuarios/preferencias_usuario.dart';
import 'package:appim/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = PreferenciasUsuario();

  String email = '';

  @override
  void initState() {
    super.initState();
    email = prefs.correo;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor:
            (prefs.colorSecundario) ? Colors.black : Color(0xff9c4dd1),
      ),
      drawer: MenuWidget(),
      body: _cuerpo(),
    );
  }

  Widget _cuerpo() {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      padding: EdgeInsets.all(4),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      children: _gridCompleta(6),
    );
  }

  List<Container> _gridCompleta(int count) => List.generate(
      count,
      (i) => Container(
              child: IconButton(
            icon: Image.asset('assets/pic${i + 1}.png'),
            iconSize: 50,
            onPressed: () {
              if (i + 1 == 1) {
                Navigator.pushReplacementNamed(context, 'cobradores');
              }
            },
          )));
}
