import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/Productos.json';
    final response = await http.post(url, body: productoModelToJson(producto));
    final decodeData = json.decode(response.body);
    print(decodeData);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/Productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic>decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];
//    print(decodeData);
    decodeData.forEach((id, prod){
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    print(productos);
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/Productos/$id.json';
    final resp = await http.delete(url);
    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/Productos/${producto.id}.json';
    final response = await http.put(url, body: productoModelToJson(producto));
    final decodeData = json.decode(response.body);
    print(decodeData);
    return true;
  }

}