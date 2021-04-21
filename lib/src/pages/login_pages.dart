import 'package:flutter/material.dart';
import 'package:residuos/src/models/futurosUsuarios.dart';
import 'package:residuos/src/models/shared_preferences.dart';

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
        child: Image.asset('assets/icon/logoRes.png'),
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
            var usuario = await FuturosUsr.getUsuario(
                txtControlerUsr.text, txtControlerPwd.text);

            if (usuario != null) {
              msjError = "";
              print("El usuario ${usuario.usrName}");
              await SharedPreferencesClass.setPreference(
                  "usuario", usuario.toJson());
              if (usuario.rol == 1) {
                print("se ha logeado  como usuario generador de residuos");
                await SharedPreferencesClass.setPreference("initScreen", 3);
                Navigator.pushReplacementNamed(context, "listaRecoleciones");
              } else if (usuario.rol == 2) {
                print("se ha logeado  como Recolector de residuos");
                await SharedPreferencesClass.setPreference("initScreen", 4);
                Navigator.pushReplacementNamed(context, "listaRecolectores");
              } else if (usuario.rol == 0) {
                print("se ha logeado  como sin rol");
                Navigator.pushReplacementNamed(context, "selectorTipo");
              }
            } else {
              msjError = ("Usuario y/o contraseña incorrectos");
            }
          } else {
            msjError = "Por favor llene todos los campos";
          }
          setState(() {});
          //
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
        Navigator.pushReplacementNamed(context, "registro");
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
        title: Text('Residuos Orgánicos'),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "presentacion");
              })
        ],
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 30.0),
            logo,
            SizedBox(height: 60.0),
            labelUsr,
            SizedBox(height: 10.0),
            usuario,
            SizedBox(height: 30.0),
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
}
