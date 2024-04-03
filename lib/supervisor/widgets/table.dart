import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ruta_sdg/analista.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataTableCustom extends StatefulWidget {
  const DataTableCustom({super.key});

  @override
  State<DataTableCustom> createState() => _DataTableCustomState();
}

class _DataTableCustomState extends State<DataTableCustom> {
  late AnalistaDataGridSource _analistaDataGridSource;
  List<Analista> _analistas = <Analista>[];

  @override
  void initState() {
    super.initState();
    _analistas = getAnalistas();
    _analistaDataGridSource = AnalistaDataGridSource(analistas: _analistas);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: SfDataGrid(
          source: _analistaDataGridSource,
          columnWidthMode: ColumnWidthMode.auto,
          columns: [
            GridColumn(
                columnName: 'analista',
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerRight,
                    color: const Color(0xFFD9DEDA),
                    child: const Text(
                      'Analista',
                      style: TextStyle(fontFamily: "HelveticaCondensed"),
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'estado',
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    color: const Color(0xFFD9DEDA),
                    child: const Text(
                      'Estado',
                      style: TextStyle(fontFamily: "HelveticaCondensed"),
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'nrovisitas',
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    color: const Color(0xFFD9DEDA),
                    child: const Text(
                      'Nro de visitas',
                      style: TextStyle(fontFamily: "HelveticaCondensed"),
                      overflow: TextOverflow.fade,
                    ))),
            GridColumn(
                columnName: 'porcentaje',
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerRight,
                    color: const Color(0xFFD9DEDA),
                    child: const Text(
                      'Porcentaje',
                      style: TextStyle(fontFamily: "HelveticaCondensed"),
                      overflow: TextOverflow.ellipsis,
                    )))
          ]),
    );
  }
}

class AnalistaDataGridSource extends DataGridSource {
  AnalistaDataGridSource({required List<Analista> analistas}) {
    dataGridRows = analistas
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'analista',
                  value: "${dataGridRow.name} ${dataGridRow.lastName}"),
              DataGridCell<String>(
                  columnName: 'estado', value: dataGridRow.edad),
              DataGridCell<String>(
                  columnName: 'nrovisitas', value: dataGridRow.dni),
              DataGridCell<double>(
                  columnName: 'porcentaje', value: dataGridRow.longitud),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'analista' ||
                  dataGridCell.columnName == 'porcentaje')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.visible,
          ));
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  int id;
  String name;
  String designation;
  int salary;
}

List<Employee> getEmployeeData() {
  return [
    Employee(10001, 'James', 'Project Lead', 20000),
    Employee(10002, 'Kathryn', 'Manager', 30000),
    Employee(10003, 'Lara', 'Developer', 15000),
    Employee(10004, 'Michael', 'Designer', 10000),
    Employee(10005, 'Martin', 'Developer', 20000),
    Employee(10006, 'Newberry', 'Manager', 25000),
    Employee(10007, 'Balnc', 'Developer', 35000),
    Employee(10008, 'Perry', 'Designer', 45000),
    Employee(10009, 'Gable', 'Developer', 10000),
    Employee(10010, 'Grimes', 'Developer', 30000),
    Employee(10011, 'Grimes', 'Project Lead', 20000),
    Employee(10012, 'Gable', 'Manager', 30000),
    Employee(10013, 'Perry', 'Developer', 15000),
    Employee(10014, 'Balnc', 'Designer', 10000),
    Employee(10015, 'Newberry', 'Developer', 20000),
    Employee(10016, 'Martin', 'Developer', 25000),
    Employee(10017, 'Michael', 'Manager', 35000),
    Employee(10018, 'Lara', 'Developer', 45000),
    Employee(10019, 'Kathryn', 'Designer', 10000),
    Employee(10020, 'James', 'Lead', 30000)
  ];
}
