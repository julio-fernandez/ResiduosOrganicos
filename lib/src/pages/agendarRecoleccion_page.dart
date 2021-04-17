import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:residuos/main.dart';

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
  String msjError = "";
  String msjFecha = "Seleccionar fecha";
  @override
  void initState() {
    super.initState();
  }

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

    final fecha = OutlinedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              theme: DatePickerTheme(
                  headerColor: Colors.green,
                  // backgroundColor: Colors.black,
                  itemStyle: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
              onChanged: (date) {
            String dfecha = 'change $date in time zone ' +
                date.timeZoneOffset.inHours.toString();
            print(dfecha);
          }, onConfirm: (date) {
            setState(() {});
            int anio = date.year;
            int mes = date.month;
            int dia = date.day;
            int hora = date.hour;
            int minutos = date.minute;
            msjFecha = ('$anio-$mes-$dia $hora:$minutos');
            print(msjFecha);
          }, currentTime: DateTime.now(), locale: LocaleType.es);
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          side: BorderSide(color: Colors.grey),
        ),
        child: Text(
          msjFecha,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ));

    final agendarButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlueAccent,
          onPrimary: Colors.lightBlueAccent[700],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
        ),
        onPressed: () {
          bool camposVacios = !(_validarTextField(txtControlerDireccion.text));
          if (camposVacios) {
            msjError = "Por favor llene todos los campos";
          } else {
            msjError = "Validacion pendiente";
          }
          setState(() {});
          // Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Agendar', style: TextStyle(color: Colors.white)),
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
            labelMensajeError,
            SizedBox(height: 0.0),
            agendarButton,
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

bool _validarTextField(String texto) {
  if (texto.isEmpty) return false;
  if (texto.trim().length == 0) return false;
  return true;
}
