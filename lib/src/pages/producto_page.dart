import 'dart:io';
import 'package:appim/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';

import 'package:appim/src/models/Producto_model.dart';
import 'package:appim/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  //const ProductoPage({super.key});
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = ProductosProvider();

  final ImagePicker _picker = ImagePicker();
  File? foto;

  ProductoModel producto = ProductoModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final prodData =
        ModalRoute.of(context)!.settings.arguments as ProductoModel?;
    if (prodData != null) {
      producto = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Nuevo Usuario'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearTelefono(),
                _crearCorreo(),
                _crearCargo(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
                Text('Guardar')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Usuario'),
      onSaved: (value) => producto.titulo = value.toString(),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 3) {
          return 'Ingrese el nombre de usuario';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      initialValue: producto.telefono,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Telefono'),
      onSaved: (value) => producto.telefono = value.toString(),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 3) {
          return 'Ingrese el telefono';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCorreo() {
    return TextFormField(
      initialValue: producto.correo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Correo'),
      onSaved: (value) => producto.correo = value.toString(),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 3) {
          return 'Ingrese el correo';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCargo() {
    return TextFormField(
      initialValue: producto.cargo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Cargo'),
      onSaved: (value) => producto.cargo = value.toString(),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 3) {
          return 'Ingrese el cargo';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Contraseña'),
      onSaved: (value) => producto.valor = value.toString(),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 3) {
          return 'Ingrese la contraseña';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton() {
    return IconButton(
      color: Colors.deepPurple,
      splashColor: Colors.deepPurple,
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (formKey.currentState?.validate() == false) return;
    formKey.currentState?.save();

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      producto.fotoUrl = await productoProvider.subirImagen(foto!);
    }

    if (producto.id == null) {
      productoProvider.crearProducto(producto);
    } else {
      productoProvider.editarProducto(producto);
    }

    mostrarSnackbar(context, 'Registro Guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(BuildContext context, String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl.toString()),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 200.0,
        fit: BoxFit.fill,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto!,
          fit: BoxFit.fill,
          height: 200.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _seleccionarFoto() async {
    _procesarImage(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImage(ImageSource.camera);
  }

  _procesarImage(ImageSource origen) async {
    XFile pathFoto = await _picker.pickImage(source: origen) as XFile;
    foto = File(pathFoto.path);
    if (foto != null) {
      producto.fotoUrl = null;
    }
    setState(() {});
  }
}
