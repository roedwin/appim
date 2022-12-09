import 'dart:convert';
import 'dart:io';
import 'package:appim/src/preferencias_usuarios/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:appim/src/models/Producto_model.dart';
import 'package:mime_type/mime_type.dart';

class ProductosProvider {
  final String _url = 'https://appim-3d535-default-rtdb.firebaseio.com';
  final _prefs = PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = Uri.parse('$_url/productos.json?auth=${_prefs.token}');
    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(json.encode(resp.body));

    print(decodedData);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url =
        Uri.parse('$_url/productos/${producto.id}.json?auth=${_prefs.token}');
    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(json.encode(resp.body));

    print(decodedData);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = Uri.parse('$_url/productos.json?auth=${_prefs.token}');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = [];

    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    print(productos);
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = Uri.parse('$_url/productos/$id.json?auth=${_prefs.token}');
    final resp = await http.delete(url);
    return 1;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dukbywfsg/image/upload?upload_preset=nqslo7iq');
    final mimeType = mime(imagen.path).toString().split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return '';
    }

    final respData = json.decode(resp.body);

    return respData['secure_url'];
  }
}
