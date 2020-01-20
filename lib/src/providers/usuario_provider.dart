import 'dart:convert';

import 'package:formvalidation/src/utils/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = '_firebaseToken';
  final _prefs = new PreferenciasUsuario();


  Future login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      //Salvar el token en el storage
      _prefs.token = decodeResp['idToken'];
      return { 'ok': true, 'token': decodeResp['idToken'] };
    } else {
      return { 'ok': false, 'mensaje': decodeResp['error']['message'] };
    }
  }

  Future nuevoUsuario(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      //Salvar el token en el storage
      _prefs.token = decodeResp['idToken'];
      return { 'ok': true, 'token': decodeResp['idToken'] };
    } else {
      return { 'ok': false, 'mensaje': decodeResp['error']['message'] };
    }
  }
}
