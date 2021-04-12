import 'package:flutter/material.dart';
// import 'package:login/home_page.dart';

class RegistroPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _RegistroPageState createState() => new _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
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
      initialValue: 'Nombre',
      decoration: InputDecoration(
        hintText: 'Nombre Usuario',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'contraseña',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final numTelefono = TextFormField(
      autofocus: false,
      initialValue: 'numTelefono',
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Telefono',
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
        onPressed: () {
          Navigator.of(context).pushNamed("selectorTipo");
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Registrarse', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            label("Usuario"),
            SizedBox(height: 10.0),
            usuario,
            SizedBox(height: 8.0),
            label("Contraseña"),
            SizedBox(height: 10.0),
            password,
            SizedBox(height: 8.0),
            label("Repite Contraseña"),
            SizedBox(height: 10.0),
            password,
            SizedBox(height: 10.0),
            label("Numero de telefono"),
            SizedBox(height: 10.0),
            numTelefono,
            SizedBox(height: 8.0),
            loginButton,
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
}
