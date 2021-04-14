import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:residuos/src/models/usuarios.dart';

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  // ignore: unused_field
  Future<List<Usuario>> _listaUsuarios;

  Future<List<Usuario>> _getUsuarios() async {
    var url = Uri.http('192.168.0.34:3000', '/');
    // var url =
    //     Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    final response = await http.get(url);

    List<Usuario> usuarios = [];

    if (response.statusCode == 200) {
      String body = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(body);
      for (var item in jsonData) {
        int usuarioId = int.parse(item["usuario_id"].toString());
        String usrName = item["usrName"];
        String pwd = item["pwd"];
        String telefono = item["telefono"];
        int rol = int.parse(item["rol"].toString());
        Usuario usr = Usuario(usuarioId, usrName, pwd, telefono, rol);
        usuarios.add(usr);
        print(item);
      }
      return usuarios;
    } else {
      throw Exception("Fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    _listaUsuarios = _getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
        centerTitle: true,
      ),
      body: Text("API"),
    );
  }
}
