import 'package:flutter/material.dart';
// import 'package:login/home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          Navigator.pushNamed(context, "listaRecoleciones");
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
            SizedBox(height: 24.0),
            loginButton,
            registrarse
          ],
        ),
      ),
    );
  }
}
