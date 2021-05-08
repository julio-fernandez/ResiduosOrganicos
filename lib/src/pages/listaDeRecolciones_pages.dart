import 'package:flutter/material.dart';
import 'package:residuos/src/models/futurosUsuarios.dart';
import 'package:residuos/src/models/recolecciones.dart';
import 'package:residuos/src/models/shared_preferences.dart';

class RecolecionesLista extends StatefulWidget {
  @override
  _RecolecionesListaState createState() => _RecolecionesListaState();
}

class _RecolecionesListaState extends State<RecolecionesLista> {
  Future<List<Recolecciones>> _listaRecol;

  @override
  void initState() {
    super.initState();
    _listaRecol = FuturosRecolec.getRecoleccionesByusuario();
  }

  Widget btnEliminar(int idRecoleccion) {
    return ElevatedButton(
      onPressed: () async {
        print("Boton eliminado con id=$idRecoleccion");
        var httpResponse =
            await FuturosRecolec.deleteRecolecionById(idRecoleccion);
        if (httpResponse.statusCode == 200) {
          print("Eliminado correctamente en lista de recoleciones");
          Navigator.pushReplacementNamed(context, "listaRecoleciones");
        } else {
          print("Error eliminar recolecion en lista");
        }
      },
      child: Text("Eliminar"),
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // background
        onPrimary: Colors.white, // foreground
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Residuos Orgánicos'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await SharedPreferencesClass.setPreference("initScreen", 2);
                Navigator.pushReplacementNamed(context, "login");
              })
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FutureBuilder(
              future: _listaRecol,
              builder: (context, snapshot) {
                print("Valor del future builder");
                print(snapshot.data);
                List<Recolecciones> reco = (snapshot.data);
                print("¿Es nulo?");
                bool isnullRec = reco == null ? true : false;
                print(isnullRec);
                if (!isnullRec) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    List<_Row> rows = [];

                    for (var item in snapshot.data) {
                      rows.add(_Row(
                          _getEstado(
                              item.recolectorid,
                              Recolecciones.fechaFormatoCorrector(
                                  item.fechahasta)),
                          item.direccion,
                          Recolecciones.fechaFormatoCorrector(item.fechade),
                          Recolecciones.fechaFormatoCorrector(
                                      item.fechahasta) ==
                                  "2000-00-00 00:00:00"
                              ? "Completado"
                              : Recolecciones.fechaFormatoCorrector(
                                  item.fechahasta),
                          item.cantidad,
                          item.descripcion,
                          item.repetir,
                          btnEliminar(item.recoleccionid)));
                    }

                    return PaginatedDataTable(
                      header: Text('Recoleciones programadas'),
                      rowsPerPage: 7,
                      columnSpacing: 40,
                      columns: [
                        DataColumn(label: Text('Estado')),
                        DataColumn(label: Text('Dirección')),
                        DataColumn(label: Text('Fecha de')),
                        DataColumn(label: Text('limite')),
                        DataColumn(label: Text('cantidad')),
                        DataColumn(label: Text('descripción')),
                        DataColumn(label: Text('Repetición')),
                        DataColumn(label: Text('')),
                      ],
                      source: _DataSource(context, rows),
                    );
                  } else {
                    return Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 100, bottom: 200),
                            height: 200.0,
                            width: 200.0,
                            child: CircularProgressIndicator()));
                  }
                } else {
                  return Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 100),
                          height: 200.0,
                          width: 200.0,
                          child: CircularProgressIndicator()));
                }
              }),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "agendarRecoleccionPage");
            },
            child: Text("Agendar Recolección"),
          ),
        ],
      ),
    );
  }
}

Widget _getEstado(int recolectorid, String fecha) {
  String estadoRec = "";
  Color colormsj;
  Color colortext;

  int anio = int.parse(fecha.substring(0, 4));
  int mes = int.parse(fecha.substring(5, 7));
  int dia = int.parse(fecha.substring(8, 10));
  var fechahoy = DateTime.now();
  var fechaRecoleccion = DateTime(anio, mes, dia);

  if (!fecha.contains("2000-00-00 00:00:00"))
    print(
        "Fecha rec = $anio, $mes, $dia,  fecha actual: ${fechahoy.year}-${fechahoy.month}-${fechahoy.day} recolectorid= $recolectorid");

  if (fecha.contains("2000-00-00 00:00:00")) {
    estadoRec = "Completa";
    colormsj = Colors.green;
    colortext = Colors.white;
  } else if (fechahoy.isAfter(fechaRecoleccion)) {
    estadoRec = "No asignada a tiempo";
    colormsj = Colors.red;
    colortext = Colors.black;
  } else if (recolectorid == 1) {
    estadoRec = "En asignación";
    colormsj = Colors.grey;
    colortext = Colors.white;
  } else {
    estadoRec = "Asignado";
    colormsj = Colors.yellow;
    colortext = Colors.black87;
  }

  return Container(
    decoration: BoxDecoration(
      color: colormsj,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
    child: Text(
      estadoRec,
      style: TextStyle(color: colortext),
    ),
  );
}

class _Row {
  _Row(
    this.valueAA,
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
    this.valueF,
    this.valueG,
  );
  final Widget valueAA;
  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;
  final String valueF;
  final Widget valueG;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, List<_Row> datos) {
    _rows = datos;
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     notifyListeners();
      //   }
      // },
      cells: [
        DataCell(row.valueAA),
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD)),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
        DataCell(row.valueG),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
