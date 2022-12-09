import 'dart:ffi';

import 'package:appim/src/bloc/provider.dart';
import 'package:appim/src/preferencias_usuarios/preferencias_usuario.dart';
import 'package:appim/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario = true;
  int? _genero = 1;
  String _nombre = '';

  TextEditingController _textController = TextEditingController();

  final prefs = PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textController = TextEditingController(text: prefs.nombre);
  }

  void _setSelectedRadio(int? valor) {
    prefs.genero = valor!;
    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor:
            (prefs.colorSecundario) ? Colors.teal : Color(0xff9c4dd1),
      ),
      drawer: MenuWidget(),
      body: _cuerpo(),
    );
  }

  Widget _cuerpo() {
    return ListView(
      children: [
        Container(
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(5.0),
        ),
        Divider(),
        SwitchListTile(
          value: _colorSecundario,
          title: Text('Color secundario'),
          onChanged: (value) {
            setState(() {
              _colorSecundario = value;
              prefs.colorSecundario = value;
            });
          },
        ),
        RadioListTile(
          value: 1,
          title: Text('Masculino'),
          groupValue: _genero,
          onChanged: _setSelectedRadio,
        ),
        RadioListTile(
          value: 2,
          title: Text('Femenino'),
          groupValue: _genero,
          onChanged: _setSelectedRadio,
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Nombre',
              helperText: 'Nombre de la persona usando el telefono',
            ),
            onChanged: (value) {
              prefs.nombre = value;
            },
          ),
        )
      ],
    );
  }
}
