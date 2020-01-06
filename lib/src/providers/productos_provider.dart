import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-curso-47a1c.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/Productos.json';
    final response = await http.post(url, body: productoModelToJson(producto));
    final decodeData = json.decode(response.body);
    print(decodeData);
    return true;
  }

}