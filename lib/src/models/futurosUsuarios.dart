import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:residuos/src/models/usuarios.dart';
import 'package:residuos/src/variables/variables.dart';

class FuturosUsr {
  static Future<http.Response> createUser(Usuario usr) {
    return http.post(
      Uri.http(ApiEndPointData.endPoint, "/api/usuarios/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "usrName": usr.usrName,
        "pwd": usr.pwd,
        "telefono": usr.telefono,
        "rol": usr.rol.toString(),
      }),
    );
  }

  static Future<http.Response> updateUser(Usuario usr) {
    return http.put(
      // '${ApiEndPointData.usuarios}/${usr.usuarioId}'
      Uri.http(ApiEndPointData.endPoint, '/api/usuarios/${usr.usuarioId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "usrName": usr.usrName,
        "pwd": usr.pwd,
        "telefono": usr.telefono,
        "rol": usr.rol.toString(),
      }),
    );
  }

  static Future<Usuario> getUsuario(String usr, String pwd) async {
    var url =
        Uri.http(ApiEndPointData.endPoint, '/api/usuarios/validar/$usr/$pwd');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      if (body == "" || body.isEmpty) {
        print("Usr vacio");
        return null;
      }
      final jsonData = jsonDecode(body);
      int usuarioId = int.parse(jsonData["usuario_id"].toString());
      String usrName = jsonData["usrName"];
      String pwd = jsonData["pwd"];
      String telefono = jsonData["telefono"];
      int rol = int.parse(jsonData["rol"].toString());
      Usuario usr = Usuario(usuarioId, usrName, pwd, telefono, rol);
      print(jsonData);
      return usr;
    } else {
      throw Exception("Fallo la conexion");
    }
  }
}
