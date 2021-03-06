import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:residuos/src/models/recolecciones.dart';
import 'package:residuos/src/models/shared_preferences.dart';
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
        "puntuacionUsr": usr.puntuacionUsr.toString(),
        "puntuacionRec": usr.puntuacionRec.toString(),
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
        "puntuacionUsr": usr.puntuacionUsr.toString(),
        "puntuacionRec": usr.puntuacionRec.toString(),
      }),
    );
  }

  static Future<Usuario> getUsuario(String usr, String pwd) async {
    var response;
    var url =
        Uri.http(ApiEndPointData.endPoint, '/api/usuarios/validar/$usr/$pwd');

    response = await http.get(url);

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
      int puntuacionUsr = int.parse(jsonData["puntuacionUsr"].toString());
      int puntuacionRec = int.parse(jsonData["puntuacionRec"].toString());
      Usuario usr = Usuario(
          usuarioId, usrName, pwd, telefono, rol, puntuacionUsr, puntuacionRec);
      print("Rol del usuario logado = $rol");
      print(jsonData);
      return usr;
    } else {
      throw Exception("Fallo la conexion");
    }
  }
}

class FuturosRecolec {
  static Future<http.Response> createRecol(Recolecciones rec) {
    return http.post(
      Uri.http(ApiEndPointData.endPoint, "/api/recolecciones/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "direccion": rec.direccion,
        "fechade": rec.fechade,
        "fechahasta": rec.fechahasta,
        "cantidad": rec.cantidad,
        "descripcion": rec.descripcion,
        "repetir": rec.repetir,
        "usuarioid": rec.usuarioid.toString(),
        "recolectorid": rec.recolectorid.toString(),
      }),
    );
  }

  static Future<http.Response> updateRecol(Recolecciones rec) {
    return http.put(
      // '${ApiEndPointData.usuarios}/${rec.usuarioId}'
      //
      Uri.http(
          ApiEndPointData.endPoint, '/api/recolecciones/${rec.recoleccionid}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "recoleccionid": rec.recoleccionid.toString(),
        "direccion": rec.direccion,
        "fechade": rec.fechade,
        "fechahasta": rec.fechahasta,
        "cantidad": rec.cantidad,
        "descripcion": rec.descripcion,
        "repetir": rec.repetir,
        "usuarioid": rec.usuarioid.toString(),
        "recolectorid": rec.recolectorid.toString(),
      }),
    );
  }

  static Future<http.Response> deleteRecolecionById(int id) async {
    var url = Uri.http(ApiEndPointData.endPoint, '/api/recolecciones/$id');
    return await http.delete(url);

    // if (response.statusCode == 200) {
    //   String body = utf8.decode(response.bodyBytes);
    //   print("Recoleccion eliminada $body");

    //   return usr;
    // } else {
    //   throw Exception("Fallo la conexion");
    // }
  }

  static Future<List<Recolecciones>> getRecolecciones() async {
    print("Inicio futuro");
    var url = Uri.http(ApiEndPointData.endPoint, '/api/recolecciones');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("Estado 200 get recolecciones");
      String body = utf8.decode(response.bodyBytes);
      if (body == "" || body.isEmpty) {
        print("No existen recoleciones");
        return null;
      }
      final jsonData = jsonDecode(body);
      // print(jsonData);
      List<Recolecciones> listRecol = [];
      for (var item in jsonData) {
        int recoleccionid = int.parse(item["recoleccion_id"]);
        String direccion = item["direccion"];
        String fechade = item["fechade"];
        String fechahasta = item["fechahasta"];
        String cantidad = item["cantidad"];
        String descripcion = item["descripcion"];
        String repetir = item["repetir"];
        int usuarioid = int.parse(item["usuario_id"]);
        int recolectorid = int.parse(item["recolector_id"]);

        Recolecciones recol = Recolecciones(
            recoleccionid,
            direccion,
            fechade,
            fechahasta,
            cantidad,
            descripcion,
            repetir,
            usuarioid,
            recolectorid);
        print(jsonData);
        listRecol.add(recol);
      }
      return listRecol;
    } else {
      print("Error de conexion");
      throw Exception("Fallo la conexion");
    }
  }

  static Future<List<Recolecciones>> getRecoleccionesByusuario() async {
    print("Inicio futuro");
    Usuario usr = Usuario.fromJson(
        await SharedPreferencesClass.getPreferenceJsonOf("usuario"));
    print("El nombre del usuario en el Future getRecoleccionesByusuario es");
    print(usr.usrName);

    var url = Uri.http(ApiEndPointData.endPoint,
        '/api/recolecciones/usuario/${usr.usuarioId}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("Estado 200-getRecoleccionesByusuario");
      String body = utf8.decode(response.bodyBytes);
      if (body == "" || body.isEmpty) {
        print("No existen recoleciones by usuario-getRecoleccionesByusuario");
        return null;
      }
      print("Valor del body ---------");
      print(body);
      //return null;
      final jsonData = jsonDecode(body);
      print("Valor usuario en data del Future");
      print(jsonData);
      List<Recolecciones> listRec = [];

      for (var item in jsonData) {
        int recoleccionid = int.parse(item["recoleccion_id"]);
        String direccion = item["direccion"];
        String fechade = item["fechade"];
        String fechahasta = item["fechahasta"];
        String cantidad = item["cantidad"];
        String descripcion = item["descripcion"];
        String repetir = item["repetir"];
        int usuarioid = int.parse(item["usuario_id"]);
        int recolectorid = int.parse(item["recolector_id"]);
        Recolecciones recol = Recolecciones(
            recoleccionid,
            direccion,
            fechade,
            fechahasta,
            cantidad,
            descripcion,
            repetir,
            usuarioid,
            recolectorid);
        print(item);
        listRec.add(recol);
      }
      return listRec;
    } else {
      print("Error de conexion");
      throw Exception("Fallo la conexion");
    }
  }

  static Future<List<Recolecciones>> getRecoleccionesByrecolector() async {
    print("Inicio futuro");
    Usuario usr = Usuario.fromJson(
        await SharedPreferencesClass.getPreferenceJsonOf("usuario"));
    print("El nombre del usuario en el Future getRecoleccionesByrecolector es");
    print(usr.usrName);

    var url = Uri.http(ApiEndPointData.endPoint,
        '/api/recoleccionesporrecolector/${usr.usuarioId}');
    print(url.path);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("Estado 200-getRecoleccionesByusuario");
      String body = utf8.decode(response.bodyBytes);
      if (body == "" || body.isEmpty) {
        print(
            "No existen recoleciones by usuario-getRecoleccionesByrecolector");
        return null;
      }
      print("Valor del body ---------");
      print(body);
      //return null;
      final jsonData = jsonDecode(body);
      print("Valor usuario en data del Future");
      print(jsonData);
      List<Recolecciones> listRec = [];

      for (var item in jsonData) {
        int recoleccionid = int.parse(item["recoleccion_id"]);
        String direccion = item["direccion"];
        String fechade = item["fechade"];
        String fechahasta = item["fechahasta"];
        String cantidad = item["cantidad"];
        String descripcion = item["descripcion"];
        String repetir = item["repetir"];
        int usuarioid = int.parse(item["usuario_id"]);
        int recolectorid = int.parse(item["recolector_id"]);
        Recolecciones recol = Recolecciones(
            recoleccionid,
            direccion,
            fechade,
            fechahasta,
            cantidad,
            descripcion,
            repetir,
            usuarioid,
            recolectorid);
        print(item);
        listRec.add(recol);
      }
      return listRec;
    } else {
      print("Error de conexion");
      throw Exception("Fallo la conexion");
    }
  }

  static Future<List<Recolecciones>> getRecoleccionesByrecolectornulo() async {
    print("Inicio futuro");
    var url = Uri.http(ApiEndPointData.endPoint, '/api/recolectornulo');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("Estado 200-getRecoleccionesByrecolectores nulo");
      String body = utf8.decode(response.bodyBytes);
      if (body == "" || body.isEmpty) {
        print("No existen recoleciones getRecoleccionesByrecolectornulo");
        return null;
      }
      print("Valor del body ---------");
      print(body);
      //return null;
      final jsonData = jsonDecode(body);
      print("Valor usuario en data del Future");
      print(jsonData);
      List<Recolecciones> listRec = [];

      for (var item in jsonData) {
        int recoleccionid = int.parse(item["recoleccion_id"]);
        String direccion = item["direccion"];
        String fechade = item["fechade"];
        String fechahasta = item["fechahasta"];
        String cantidad = item["cantidad"];
        String descripcion = item["descripcion"];
        String repetir = item["repetir"];
        int usuarioid = int.parse(item["usuario_id"]);
        int recolectorid = int.parse(item["recolector_id"]);
        Recolecciones recol = Recolecciones(
            recoleccionid,
            direccion,
            fechade,
            fechahasta,
            cantidad,
            descripcion,
            repetir,
            usuarioid,
            recolectorid);
        print(item);
        listRec.add(recol);
      }
      return listRec;
    } else {
      print("Error de conexion");
      throw Exception("Fallo la conexion");
    }
  }
}
