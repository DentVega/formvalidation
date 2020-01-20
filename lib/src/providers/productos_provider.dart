import 'dart:convert';
import 'dart:io';

import 'package:formvalidation/src/utils/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {
  final _prefs = new PreferenciasUsuario();

  final String _url = 'https://';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/Productos.json?auth=${_prefs.token}';
    final response = await http.post(url, body: productoModelToJson(producto));
    final decodeData = json.decode(response.body);
    print(decodeData);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/Productos.json?auth=${_prefs.token}';
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
    final url = '$_url/Productos/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/Productos/${producto.id}.json?auth=${_prefs.token}';
    final response = await http.put(url, body: productoModelToJson(producto));
    final decodeData = json.decode(response.body);
    print(decodeData);
    return true;
  }

  Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/demo/image/upload?upload_preset=');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
        'POST',
        url
    );

    final file = await http.MultipartFile.fromPath(
        'file',
        imagen.path,
        contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];


  }

}