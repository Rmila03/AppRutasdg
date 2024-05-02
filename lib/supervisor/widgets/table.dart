import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ruta_sdg/api.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;

class DataTableCustom extends StatefulWidget {
  const DataTableCustom({super.key});

  @override
  State<DataTableCustom> createState() => _DataTableCustomState();
}

class _DataTableCustomState extends State<DataTableCustom> {
  late AnalistaDataGridSource _analistaDataGridSource;
  List<Analista> analistas = [];
  bool loading = false;
  @override
  void initState() {
    _fetchData();
    super.initState();
    _analistaDataGridSource = AnalistaDataGridSource(analistas: analistas);
  }

  @override
  Widget build(BuildContext context) {
    _analistaDataGridSource = AnalistaDataGridSource(analistas: analistas);
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: loading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 0, 74, 125)),
            )
          : SfDataGrid(
              source: _analistaDataGridSource,
              columnWidthMode: ColumnWidthMode.auto,
              columns: [
                  GridColumn(
                      columnName: 'analista',
                      label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.center,
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
                          alignment: Alignment.center,
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
                          alignment: Alignment.center,
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
                          alignment: Alignment.center,
                          color: const Color(0xFFD9DEDA),
                          child: const Text(
                            'Porcentaje',
                            style: TextStyle(fontFamily: "HelveticaCondensed"),
                            overflow: TextOverflow.ellipsis,
                          )))
                ]),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontFamily: 'HelveticaCondensed',
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0, 74, 125),
                  fontFamily: 'HelveticaCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchAnalistas() async {
    String token = await getToken();

    final url = Uri.parse(
        'https://wsdomingo.coopsantodomingo.com/laboratorio/creditos.php?codServicio=04');

    final headers = {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer $token',
      'Accept': '*/*'
    };

    final body = {
      'idusuario': '12279',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final List<dynamic>? jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        analistas =
            jsonResponse.map((json) => Analista.fromJson(json)).toList();
      } else {
        //print('La respuesta de la API fue nula.');
        _showErrorDialog('La respuesta de la API fue nula.');
      }
    } else {
      //print('La respuesta de la API fue nula.');
      _showErrorDialog(
          'Error al obtener los analistas. Código de estado: ${response.statusCode}');
    }
  }

  Future<void> _fetchData() async {
    setState(() {
      loading = true;
    });
    try {
      await _fetchAnalistas();
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}

class AnalistaDataGridSource extends DataGridSource {
  AnalistaDataGridSource({required List<Analista> analistas}) {
    dataGridRows = analistas
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'analista', value: dataGridRow.apellidosAnalista),
              DataGridCell<String>(
                  columnName: 'estado', value: dataGridRow.estado),
              DataGridCell<double>(
                  columnName: 'nrovisitas',
                  value: dataGridRow.numeroVisitasTotal),
              DataGridCell<double>(
                  columnName: 'porcentaje',
                  value: dataGridRow.numeroVisitasTotal),
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
              ? Alignment.centerLeft
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.visible,
          ));
    }).toList());
  }
}

class Analista {
  Analista(
      {required this.idAnalista,
      required this.nombreAnalista,
      required this.apellidosAnalista,
      required this.saldoCartera,
      required this.montoRecuperado,
      required this.saldoVencido,
      required this.indiceMorosidad,
      required this.compromisosGenerado,
      required this.compromisosSinCumplir,
      required this.compromisosCumplidos,
      required this.numeroVisitasPromocion,
      required this.numeroVisitasSeguimiento,
      required this.numeroVisitasRecuperacion,
      required this.numeroVisitasAmpliacion,
      required this.numeroVisitasTotal,
      required this.porcentajeVisitasRealizadas,
      required this.estado,
      required this.nombrePromocion,
      required this.nombreSeguimiento,
      required this.nombreRecuperacion,
      required this.cantidadPromocion,
      required this.cantidadSeguimiento,
      required this.cantidadRecuperacion,
      required this.colorPromocion,
      required this.colorSeguimiento,
      required this.colorRecuperacion});

  final String idAnalista;
  final String nombreAnalista;
  final String apellidosAnalista;
  final double saldoCartera;
  final double montoRecuperado;
  final double saldoVencido;
  final double indiceMorosidad;
  final int compromisosGenerado;
  final int compromisosSinCumplir;
  final int compromisosCumplidos;
  final int numeroVisitasPromocion;
  final int numeroVisitasSeguimiento;
  final int numeroVisitasRecuperacion;
  final int numeroVisitasAmpliacion;
  final double numeroVisitasTotal;
  final double porcentajeVisitasRealizadas;
  final String estado;
  final String nombrePromocion;
  final String nombreSeguimiento;
  final String nombreRecuperacion;
  final int cantidadPromocion;
  final int cantidadSeguimiento;
  final int cantidadRecuperacion;
  final Color colorPromocion;
  final Color colorSeguimiento;
  final Color colorRecuperacion;
  factory Analista.fromJson(Map<String, dynamic> json) {
    return Analista(
        idAnalista: json['idusuario'],
        nombreAnalista: json['analista'],
        apellidosAnalista: json['analista'],
        saldoCartera: 0,
        montoRecuperado: 0,
        saldoVencido: 0,
        indiceMorosidad: 0,
        compromisosGenerado: 0,
        compromisosSinCumplir: 0,
        compromisosCumplidos: 0,
        numeroVisitasPromocion: 0,
        numeroVisitasSeguimiento: 0,
        numeroVisitasRecuperacion: 0,
        numeroVisitasAmpliacion: 0,
        numeroVisitasTotal: 0,
        porcentajeVisitasRealizadas: 0,
        estado: "Normal",
        nombrePromocion: "Promocion",
        nombreSeguimiento: "Seguimiento",
        nombreRecuperacion: "Recuperacion",
        cantidadPromocion: 50,
        cantidadSeguimiento: 45,
        cantidadRecuperacion: 34,
        colorPromocion: const Color.fromRGBO(9, 0, 136, 1),
        colorSeguimiento: const Color.fromRGBO(147, 0, 119, 1),
        colorRecuperacion: const Color.fromRGBO(255, 189, 57, 1));
  }
}
