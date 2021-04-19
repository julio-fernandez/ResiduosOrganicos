import 'package:flutter/material.dart';
import 'package:residuos/src/models/futurosUsuarios.dart';
import 'package:residuos/src/models/shared_preferences.dart';
import 'package:residuos/src/models/usuarios.dart';

class RegistroPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _RegistroPageState createState() => new _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  TextEditingController txtControlerUsr = new TextEditingController();
  TextEditingController txtControlerPwd1 = new TextEditingController();
  TextEditingController txtControlerPwd2 = new TextEditingController();
  TextEditingController txtControlerTelefono = new TextEditingController();
  static String msjError = '';

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final usuario = TextFormField(
      // keyboardType: TextInputType.,
      autofocus: false,
      controller: txtControlerUsr,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, ingresa tu nombre de usuario';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Nombre Usuario',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password1 = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, ingresa tu contraseña de usuario';
        } else {
          return null;
        }
      },
      controller: txtControlerPwd1,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password2 = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, ingresa tu contraseña de usuario';
        } else {
          return null;
        }
      },
      controller: txtControlerPwd2,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final numTelefono = TextFormField(
      autofocus: false,
      controller: txtControlerTelefono,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, ingresa tu telefono de usuario';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Telefono',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final registrarButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlueAccent,
          onPrimary: Colors.lightBlueAccent[700],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
        ),
        onPressed: () async {
          bool camposVacios = !(_validarTextField(txtControlerPwd1.text) &&
              _validarTextField(txtControlerPwd2.text) &&
              _validarTextField(txtControlerUsr.text) &&
              _validarTextField(txtControlerTelefono.text));
          if (camposVacios) {
            msjError = "Por favor llene todos los campos";
          } else if (txtControlerPwd1.text != txtControlerPwd2.text) {
            msjError = "Las contraseñas no coinciden";
          } else {
            String pwd = txtControlerPwd1.text;
            String usrName = txtControlerUsr.text;
            String telefono = txtControlerTelefono.text;
            int rol = 0;
            Usuario usr = Usuario(0, usrName, pwd, telefono, rol, 0, 0);
            var httpResponse = await FuturosUsr.createUser(usr);
            print("httpResponse.statusCode  = ${httpResponse.statusCode}");
            if (httpResponse.statusCode == 200) {
              print(
                  "Usuario registrdo form usr:$usrName contra:$pwd telefono: $telefono rol: $rol");
              msjError = "";
              await SharedPreferencesClass.setPreference(
                  "usuario", usr.toJson());
              print("Usuario creado :)");
              print(usr);
              Navigator.of(context).pushReplacementNamed("selectorTipo");
            } else if (httpResponse.statusCode == 466) {
              msjError = "El usuario ya existe";
            } else {
              print(
                  "El status del registrar usuario = ${httpResponse.statusCode}");
              msjError = "Error al registrar usuario";
            }
          }

          setState(() {});
          //Navigator.of(context).pushNamed("selectorTipo");
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Registrarse', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "login");
            }),
        title: Text('Registro'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 30.0),
            label("Usuario"),
            SizedBox(height: 10.0),
            usuario,
            SizedBox(height: 8.0),
            label("Contraseña"),
            SizedBox(height: 10.0),
            password1,
            SizedBox(height: 8.0),
            label("Repite Contraseña"),
            SizedBox(height: 10.0),
            password2,
            SizedBox(height: 10.0),
            label("Numero de telefono"),
            SizedBox(height: 10.0),
            numTelefono,
            SizedBox(height: 10.0),
            labelMensajeError,
            SizedBox(height: 8.0),
            registrarButton,
          ],
        ),
      ),
    );
  }

  label(String textoLb) {
    return Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          textoLb,
          style: TextStyle(
            fontSize: 17,
          ),
        ));
  }

  bool _validarTextField(String texto) {
    if (texto.isEmpty) return false;
    if (texto.trim().length == 0) return false;
    return true;
  }
}
