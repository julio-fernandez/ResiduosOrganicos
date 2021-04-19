import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:residuos/src/models/DateVar.dart';
import 'package:residuos/src/models/futurosUsuarios.dart';
import 'package:residuos/src/models/recolecciones.dart';
import 'package:residuos/src/models/shared_preferences.dart';
import 'package:residuos/src/models/usuarios.dart';
// import 'package:residuos/main.dart';

// import 'package:login/home_page.dart';
String grupo = "ninguno";

class AgendarRecoleccionPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _AgendarRecoleccionPageState createState() =>
      new _AgendarRecoleccionPageState();
}

class _AgendarRecoleccionPageState extends State<AgendarRecoleccionPage> {
  TextEditingController txtControlerDireccion = new TextEditingController();
  TextEditingController txtControlerCantidad = new TextEditingController();
  TextEditingController txtControlerDescripcion = new TextEditingController();

  String msjError = "";
  String msjFechade = "Seleccionar fecha";
  String msjFechahasta = "Seleccionar fecha de";
  DateVar datede = new DateVar.vacio();
  DateVar datehasta = new DateVar.vacio();
  bool isbtnHastaEnabled = false;
  @override
  Widget build(BuildContext context) {
    final direccion = TextFormField(
      maxLines: 3,
      controller: txtControlerDireccion,
      decoration: InputDecoration(
        hintText: 'Nombre Usuario',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final cantidad = TextFormField(
      controller: txtControlerCantidad,
      decoration: InputDecoration(
        hintText: 'Cantidad aproximada de residuos',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final descripcion = TextFormField(
      maxLines: 3,
      controller: txtControlerDescripcion,
      decoration: InputDecoration(
        hintText: 'Descripcion (opcional)',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final fechade = OutlinedButton(
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
            isbtnHastaEnabled = false;
            msjFechahasta = "Seleccionar fecha de";
          }, onConfirm: (date) {
            isbtnHastaEnabled = true;
            msjFechahasta = "Seleccionar fecha";

            msjFechade =
                ('${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}');
            print(msjFechade);
            datede = DateVar(
                date.year, date.month, date.day, date.hour, date.minute);
            setState(() {});
          }, currentTime: DateTime.now(), locale: LocaleType.es);
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          side: BorderSide(color: Colors.grey),
        ),
        child: Text(
          msjFechade,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ));

    final fechahasta = OutlinedButton(
        onPressed: isbtnHastaEnabled
            ? () {
                print(
                    'Tiempo limite = ${datede.anio}-${datede.mes}-${datede.dia} ${datede.hora}:${datede.minuto}');
                DatePicker.showDateTimePicker(context,
                    minTime: DateTime(datede.anio, datede.mes, datede.dia,
                        datede.hora, datede.minuto),
                    maxTime:
                        DateTime(datede.anio, datede.mes, datede.dia, 23, 59),
                    showTitleActions: true,
                    theme: DatePickerTheme(
                        headerColor: Colors.green,
                        // backgroundColor: Colors.black,
                        itemStyle: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                    onChanged: (date) {
                  String dfecha = 'change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString();
                  print(dfecha);
                }, onConfirm: (date) {
                  setState(() {});
                  msjFechahasta =
                      ('${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}');
                  print(msjFechahasta);
                  datehasta = DateVar(
                      date.year, date.month, date.day, date.hour, date.minute);
                }, locale: LocaleType.es);
              }
            : () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          side: BorderSide(color: Colors.grey),
        ),
        child: Text(
          msjFechahasta,
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
        onPressed: () async {
          bool camposVacios = !(_validarTextField(txtControlerDireccion.text) &&
              _validarTextField(txtControlerCantidad.text) &&
              msjFechade != "Seleccionar fecha" &&
              msjFechahasta != "Seleccionar fecha de" &&
              grupo != "ninguno");

          if (camposVacios) {
            msjError = "Por favor llene todos los campos";
          } else {
            Usuario usr = Usuario.fromJson(
                await SharedPreferencesClass.getPreferenceJsonOf("usuario"));

            print("el usruid en agendarReclocionpage es " +
                usr.usuarioId.toString());
            String fechaderectxt =
                '${datede.anio}-${datede.mes}-${datede.dia} ${datede.hora}:${datede.minuto}:00';
            String fechahastarectxt =
                '${datehasta.anio}-${datehasta.mes}-${datehasta.dia} ${datehasta.hora}:${datehasta.minuto}:00';
            Recolecciones rec = Recolecciones(
                0,
                txtControlerDireccion.text,
                fechaderectxt,
                fechahastarectxt,
                txtControlerCantidad.text,
                txtControlerDescripcion.text,
                grupo,
                usr.usuarioId,
                1);
            print("Momento antes de futuro recolecion");
            var httpResponse = await FuturosRecolec.createRecol(rec);
            print("httpResponse.statusCode  = ${httpResponse.statusCode}");
            if (httpResponse.statusCode == 200) {
              print("Recoleccion agendada correctamente");
              Navigator.pushReplacementNamed(context, "listaRecoleciones");
            } else {
              print("Error estatus no 200");
              msjError = "Error";
            }
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
        actions: [
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "listaRecoleciones");
              })
        ],
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
            label("Fecha de"),
            SizedBox(height: 10.0),
            fechade,
            SizedBox(height: 10.0),
            label("Fecha hasta"),
            SizedBox(height: 10.0),
            fechahasta,
            SizedBox(height: 8.0),
            label("Cantidad aproximada"),
            SizedBox(height: 10.0),
            cantidad,
            SizedBox(height: 10.0),
            label("Descripcion"),
            SizedBox(height: 10.0),
            descripcion,
            SizedBox(height: 10.0),
            _radio("unaVez", "Unica vez"),
            _radio("diario", "Recolectar diariamente"),
            _radio("semanal", "Recolectar semanalmente"),
            _radio("mensual", "Recolectar Mensualmente"),
            labelMensajeError,
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
