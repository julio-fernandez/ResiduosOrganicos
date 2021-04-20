import 'package:flutter/material.dart';
import 'package:residuos/src/models/futurosUsuarios.dart';
import 'package:residuos/src/models/recolecciones.dart';
import 'package:residuos/src/models/shared_preferences.dart';

class RecolectoresLista extends StatefulWidget {
  @override
  _RecolectoresListaState createState() => _RecolectoresListaState();
}

class _RecolectoresListaState extends State<RecolectoresLista> {
  Future<List<Recolecciones>> _futuroListaRecol;
  List<Recolecciones> _listaRecol = [];

  @override
  void initState() {
    super.initState();
    _futuroListaRecol = FuturosRecolec.getRecoleccionesByrecolector();
  }

  Widget btnEliminar(int idRecoleccion) {
    return ElevatedButton(
      onPressed: () async {
        print("Boton eliminado con id=$idRecoleccion");
        for (Recolecciones item in _listaRecol) {
          if (item.recoleccionid == idRecoleccion) {
            item.fechade = Recolecciones.fechaFormatoCorrector(item.fechade);
            item.fechahasta =
                Recolecciones.fechaFormatoCorrector(item.fechahasta);
            item.recolectorid = 1;
            var httpResponse = await FuturosRecolec.updateRecol(item);
            if (httpResponse.statusCode == 200) {
              Navigator.pushReplacementNamed(context, "listaRecolectores");
            } else {
              print("Error eliminando(actualizando) usuario o recolectar");
            }
            break;
          }
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
        title: Text('Desechos organicos'),
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
              future: _futuroListaRecol,
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
                      _listaRecol.add(item);
                      rows.add(_Row(
                          item.direccion,
                          item.fechade,
                          item.fechahasta,
                          item.cantidad,
                          item.descripcion,
                          item.repetir,
                          btnEliminar(item.recoleccionid)));
                    }

                    return PaginatedDataTable(
                      header: Text('Lista de usuarios que se recolectaran '),
                      rowsPerPage: 7,
                      columnSpacing: 40,
                      columns: [
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
                Navigator.pushReplacementNamed(
                        context, "agendarRecolectoresPage")
                    .then((value) => setState(() {}));
              },
              child: Text("Agendar Recolección")),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
    this.valueF,
    this.valueG,
  );

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
