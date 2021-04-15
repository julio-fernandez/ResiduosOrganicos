import 'package:flutter/material.dart';

// import 'package:login/home_page.dart';
String grupo = "tiempo";

class AgendarRecoleccionPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _AgendarRecoleccionPageState createState() =>
      new _AgendarRecoleccionPageState();
}

class _AgendarRecoleccionPageState extends State<AgendarRecoleccionPage> {
  TextEditingController txtControlerDireccion = new TextEditingController();
  TextEditingController txtControlerFecha = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final direccion = TextFormField(
      // keyboardType: TextInputType.,
      autofocus: false,
      maxLines: 3,
      controller: txtControlerDireccion,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, ingresa tu contraseña de usuario';
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

    final fecha = TextFormField(
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, ingresa tu contraseña de usuario';
        } else {
          return null;
        }
      },
      controller: txtControlerFecha,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: '2021-01-01 13:00:00',
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
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Agendar', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

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
            SizedBox(height: 20.0),
            labelTitulo("Agendar recolección de desechos organicos"),
            SizedBox(height: 20.0),
            label("Direccion"),
            SizedBox(height: 10.0),
            direccion,
            SizedBox(height: 8.0),
            label("Fecha"),
            SizedBox(height: 10.0),
            fecha,
            SizedBox(height: 10.0),
            _radio("unaVez", "Unica vez"),
            _radio("diario", "Recolectar diariamente"),
            _radio("semanal", "Recolectar semanalmente"),
            _radio("mensual", "Recolectar Mensualmente"),
            SizedBox(height: 24.0),
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

  labelTitulo(String textoLb) {
    return Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Text(
          textoLb,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, height: 1.4),
        ));
  }

  Widget _radio(String valor, String texto) {
    return RadioListTile(
      title: Text(
        texto,
      ),
      value: valor,
      groupValue: grupo,
      onChanged: (value) {
        setState(() {
          grupo = value;
          print("valor grupo cmb agrec" + grupo);
          // mensaje = "La carrera seleccionada es: ";
        });
      },
    );
  }
}
