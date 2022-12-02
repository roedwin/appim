import 'dart:js';

import 'package:flutter/material.dart';
import 'package:appim/src/providers/productos_provider.dart';
import 'package:appim/src/models/Producto_model.dart';

import '../bloc/provider.dart';

class HomePage extends StatelessWidget {
  //const HomePage({super.key});
  final productosProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos?.length,
            itemBuilder: (contex, i) => _crearItem(productos![i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(ProductoModel producto) {
    return ListTile(
      title: Text('${producto.titulo} - ${producto.valor}'),
      subtitle: Text(producto.id.toString()),
      //onTap: () => Navigator.pushNamed(context, 'producto'),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}
