import 'package:flutter/material.dart';
// import 'package:login/home_page.dart';
import 'package:residuos/src/models/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:residuos/src/models/usuarios.dart';
import 'package:residuos/src/variables/variables.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final _formKey = GlobalKey<FormState>();
  TextEditingController txtControlerPwd = new TextEditingController();
  TextEditingController txtControlerUsr = new TextEditingController();
  // Future<Usuario> _usr;
  String msjError = "";

  Future<Usuario> _getUsuario(String usr, String pwd) async {
    var url = Uri.http(ApiEndPointData.endPoint,
        '${ApiEndPointData.validarUsuario}/$usr/$pwd');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String body = convert.utf8.decode(response.bodyBytes);
      if (body == "" || body.isEmpty) {
        print("Usr vacio");
        return null;
      }
      final jsonData = convert.jsonDecode(body);
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/img/planet-earth-green.png'),
      ),
    );

    final usuario = TextFormField(
      // keyboardType: TextInputType.,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, ingresa tu nombre de usuario';
        } else {
          return null;
        }
      },
      // initialValue: 'Nombre',
      controller: txtControlerUsr,
      decoration: InputDecoration(
        hintText: 'Nombre Usuario',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: txtControlerPwd,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, ingresa tu nombre de usuario';
        } else {
          return null;
        }
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlueAccent,
          onPrimary: Colors.lightBlueAccent[700],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
        ),
        onPressed: () async {
          if (_validarTextField(txtControlerPwd.text) &&
              _validarTextField(txtControlerUsr.text)) {
            var usuario =
                await _getUsuario(txtControlerUsr.text, txtControlerPwd.text);

            if (usuario != null) {
              msjError = "";
              print("El usuario ${usuario.usrName} se ha logeado");
              SharedPreferencesClass.setPreference("usuario", usuario);
            } else {
              msjError = ("Usuario y/o contraseña incorrectos");
            }
          } else {
            msjError = "Por favor llene todos los campos";
          }
          setState(() {});
          // Navigator.pushNamed(context, "selectorTipo");
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final registrarse = TextButton(
      child: Text(
        'Registrarse',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "registro");
      },
    );

    final labelUsr = Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          "Usuario",
          style: TextStyle(
            fontSize: 17,
          ),
        ));
    final labelcontra = Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          "Contraseña",
          style: TextStyle(
            fontSize: 17,
          ),
        ));
    final labelMensajeError = Container(
        padding: EdgeInsets.only(top: 14.0, bottom: 14),
        decoration: (() {
          if (msjError == "" || msjError.isEmpty) {
            return BoxDecoration();
          } else {
            return BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            );
          }
        }()),
        child: Text(
          msjError,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Desechos organicos'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            labelUsr,
            SizedBox(height: 10.0),
            usuario,
            SizedBox(height: 8.0),
            labelcontra,
            SizedBox(height: 10.0),
            password,
            SizedBox(height: 10.0),
            labelMensajeError,
            SizedBox(height: 10.0),
            loginButton,
            registrarse
          ],
        ),
      ),
    );
  }

  bool _validarTextField(String texto) {
    if (texto.isEmpty) return false;
    if (texto.trim().length == 0) return false;
    // final numero = num.tryParse(texto);

    return true;
  }

  // bool _verificarCredenciales(BuildContext context, String usr, String pwd) {
  //   _usr = _getUsuario(usr, pwd);
  //   print("Future inicio");
  //   FutureBuilder(
  //       future: _usr,
  //       builder: (context, AsyncSnapshot<Usuario> snapshot) {
  //         print("Algo paso");
  //         if (snapshot.hasData) {
  //           print("Funciona :) Bienvenido: ${snapshot.data.usrName}");
  //         }
  //         print("Error usr nulo");
  //         return;
  //       });

  //   return false;
  // }
}
