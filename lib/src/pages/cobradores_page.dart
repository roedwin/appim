//import 'dart:js';

import 'package:appim/src/preferencias_usuarios/preferencias_usuario.dart';
import 'package:appim/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:appim/src/providers/productos_provider.dart';
import 'package:appim/src/models/Producto_model.dart';

import '../bloc/provider.dart';

class CobradoresPage extends StatelessWidget {
  //const HomePage({super.key});
  final productosProvider = ProductosProvider();
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
        backgroundColor:
            (prefs.colorSecundario) ? Colors.teal : Color(0xff9c4dd1),
      ),
      drawer: MenuWidget(),
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
            itemBuilder: (contex, i) => _crearItem(contex, productos![i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          productosProvider.borrarProducto(producto.id.toString());
        },
        child: Card(
          child: Column(
            children: [
              // (producto.fotoUrl == null)
              //     ? Image(image: AssetImage('assets/no-image.png'))
              //     : FadeInImage(
              //         image: NetworkImage(producto.fotoUrl.toString()),
              //         placeholder: AssetImage('assets/jar-loading.gif'),
              //         height: 200.0,
              //         width: double.infinity,
              //         fit: BoxFit.cover,
              //       ),
              ListTile(
                title: Text('${producto.titulo} - ${producto.valor}'),
                subtitle: Text(producto.id.toString()),
                onTap: () => Navigator.pushNamed(
                  context,
                  'producto',
                  arguments: producto,
                ),
                leading: Container(
                  width: 75,
                  height: 75,
                  child: (producto.fotoUrl == null)
                      ? Image(image: AssetImage('assets/no-image.png'))
                      : FadeInImage(
                          image: NetworkImage(producto.fotoUrl.toString()),
                          placeholder: AssetImage('assets/jar-loading.gif'),
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}
