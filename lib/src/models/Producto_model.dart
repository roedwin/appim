import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  String? id;
  String titulo;
  String valor;
  String telefono;
  String correo;
  String cargo;
  bool disponible;
  String? fotoUrl;

  ProductoModel({
    this.id,
    this.titulo = '',
    this.valor = '',
    this.telefono = '',
    this.correo = '',
    this.cargo = '',
    this.disponible = true,
    this.fotoUrl,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"],
        telefono: json["telefono"],
        correo: json["correo"],
        cargo: json["cargo"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "titulo": titulo,
        "valor": valor,
        "telefono": telefono,
        "correo": correo,
        "cargo": cargo,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
      };
}
