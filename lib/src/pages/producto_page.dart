import 'package:appim/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';

import 'package:appim/src/models/Producto_model.dart';
import 'package:appim/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  //const ProductoPage({super.key});
  final formKey = GlobalKey<FormState>();
  final productoProvider = ProductosProvider();

  ProductoModel producto = ProductoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
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
                _crearNombre(),
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
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => producto.titulo = value.toString(),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => producto.valor = double.parse(value.toString()),
      validator: (value) {
        if (value == null || utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
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
      onPressed: _submit,
    );
  }

  void _submit() {
    if (formKey.currentState?.validate() == false) return;
    formKey.currentState?.save();

    print(producto.titulo);
    print(producto.valor);
    print(producto.disponible);

    productoProvider.crearProducto(producto);
  }
}
