import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/supervisor/widgets/table.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/widgets/menu_supervisor_mobile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ruta_sdg/analista.dart';

class DashboardSupervisorPage extends StatefulWidget {
  const DashboardSupervisorPage({super.key});

  @override
  State<DashboardSupervisorPage> createState() =>
      _DashboardSupervisorPageState();
}

class _DashboardSupervisorPageState extends State<DashboardSupervisorPage> {
  /*final List<ChartData> chartData = [
    ChartData('Cumplidos', 10, Colors.orange),
    ChartData('Sin cumplir', 2, Colors.green),
  ];*/
  String selectedItem = '';
  String opcionFecha = '';
  DateTime day = DateTime.now();
  DateTime month = DateTime.now();
  DateTime year = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  List<Analista> Analistas = getAnalistas();
  int id = 0;
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  final List<ChartData> chartData = [
    ChartData('Promoción', 50, const Color.fromRGBO(9, 0, 136, 1)),
    ChartData('Seguimiento', 45, const Color.fromRGBO(147, 0, 119, 1)),
    ChartData('Recuperación', 34, const Color.fromRGBO(255, 189, 57, 1))
  ];
  int? selectedIndex = 0;
  List<Analista> analistas = getAnalistas();
  Set<String> selectedBars = Set<String>();
  final GlobalKey<SfCartesianChartState> _chartKey =
      GlobalKey<SfCartesianChartState>();
  @override
  void initState() {
    data = [
      _ChartData(1, 'Juan', "Suarez Perez", 24000, 14000, 25000, 10.2, 10, 6, 2,
          4, 23, 4, 7, 11, 40, "Normal"),
      _ChartData(1, 'Carlos', "Suarez Perez", 26000, 12000, 22000, 2.2, 10, 6,
          2, 4, 23, 4, 7, 4, 20, "Deficiente"),
      _ChartData(1, 'Maria', "Suarez Perez", 21000, 14000, 23000, 18.2, 10, 6,
          2, 4, 23, 4, 7, 18, 80, "Óptimo"),
      _ChartData(1, 'Salvador', "Suarez Perez", 23000, 14000, 24000, 10.8, 10,
          6, 2, 4, 23, 4, 7, 12, 50, "Normal"),
      _ChartData(1, 'Adolfo', "Suarez Perez", 25000, 16000, 24000, 11.2, 10, 6,
          2, 4, 23, 4, 7, 9, 66, "Normal"),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dropdown = Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8.0),
      width: 450,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedIndex != 0 ? selectedIndex.toString() : null,
        items: List.generate(analistas.length, (index) {
          return DropdownMenuItem<String>(
            value: analistas[index].idAnalista,
            child: Text(
              '${analistas[index].name} ${analistas[index].lastName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'HelveticaCondensed',
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedItem = value ?? '';
            print(">>>>><$value");
            selectedIndex = value == null ? 0 : int.parse(value);
          });
        },
        hint: const Text(
          'Seleccione analista',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 76, 128),
            fontSize: 15.0,
            fontFamily: 'HelveticaCondensed',
          ),
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? const MenuSupervisorMobile(name: "DASHBOARD")
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              const MenuSupervisor(name: "DASHBOARD"),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 8, top: 41, bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'DASHBOARD',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 76, 128),
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'HelveticaCondensed',
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 0, 76, 128),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = 0;
                                              print(_chartKey.currentState
                                                  ?.widget.series.length);
                                              print(_chartKey
                                                  .currentState
                                                  ?.widget
                                                  .series[0]
                                                  .dataSource![1]
                                                  .selectionBehavior!
                                                  .selectedColor = Colors.red);
                                              _chartKey
                                                          .currentState
                                                          ?.widget
                                                          .series[0]
                                                          .selectionBehavior!
                                                          .selectedColor ==
                                                      null
                                                  ? Colors.red
                                                  : null;
                                            });
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(FontAwesomeIcons.eye,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                '  Ver todo ',
                                                style: TextStyle(
                                                  fontFamily:
                                                      "HelveticaCondensed",
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SfCartesianChart(
                                    key: _chartKey,
                                    title: const ChartTitle(
                                        alignment: ChartAlignment.near,
                                        text: "Mes de Febrero",
                                        textStyle: TextStyle(
                                          fontFamily: "HelveticaCondensed",
                                          color:
                                              Color.fromARGB(255, 0, 76, 128),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        )),
                                    onSelectionChanged: (value) {
                                      //value.selectedColor = Colors.red;
                                      /*setState(() {
                                        selectedIndex = value.pointIndex + 1;
                                      });
                                      print("ddddd");*/
                                      final String barName =
                                          value.pointIndex.toString();
                                      setState(() {
                                        if (selectedBars.contains(barName)) {
                                          selectedBars.remove(barName);
                                          selectedIndex = 0;
                                        } else {
                                          selectedBars.add(barName);
                                          selectedIndex = value.pointIndex + 1;
                                        }
                                      });
                                    },
                                    primaryXAxis: const CategoryAxis(
                                      axisLine: AxisLine(
                                          color: Colors.black, width: 1),
                                    ),
                                    primaryYAxis: const NumericAxis(
                                      minimum: 0,
                                      maximum: 30,
                                      interval: 10,
                                      axisLine: AxisLine(
                                          color: Colors.black, width: 1),
                                      title: AxisTitle(
                                          text: "N° de Visitas",
                                          textStyle: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 18.0,
                                            fontFamily: 'HelveticaCondensed',
                                          )),
                                    ),
                                    tooltipBehavior: _tooltip,
                                    series: <CartesianSeries<_ChartData,
                                        String>>[
                                      BarSeries<_ChartData, String>(
                                          width: 0.4,
                                          selectionBehavior: SelectionBehavior(
                                            enable: true,
                                            selectedColor: const Color.fromARGB(
                                                255, 0, 76, 128),
                                            unselectedColor:
                                                const Color(0xFFD9DEDA),
                                          ),
                                          dataSource: data,
                                          xValueMapper: (_ChartData data, _) =>
                                              data.nombreAnalista,
                                          yValueMapper: (_ChartData data, _) =>
                                              data.numeroVisitasTotal,
                                          onPointTap: (value) {
                                            /*final String barName =
                                                value.pointIndex.toString();
                                            setState(() {
                                              if (selectedBars
                                                  .contains(barName)) {
                                                selectedBars.remove(barName);
                                                selectedIndex = 0;
                                              } else {
                                                selectedBars.add(barName);
                                                selectedIndex =
                                                    value.pointIndex! + 1;
                                              }
                                            });*/
                                          },
                                          color: const Color(0xFFD9DEDA))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        if (constraints.maxWidth > 200) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Actividad',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 76, 128),
                                                  fontSize: 19.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'HelveticaCondensed',
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      FontAwesomeIcons
                                                          .calendarDay,
                                                      color: Color.fromARGB(
                                                          255, 0, 76, 128),
                                                    ),
                                                    onPressed: () {
                                                      _selectDate(context);
                                                    },
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(_selectedDate),
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          "HelveticaCondensed",
                                                      color: Color.fromARGB(
                                                          255, 0, 76, 128),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Actividad',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 76, 128),
                                                  fontSize: 19.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'HelveticaCondensed',
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      FontAwesomeIcons
                                                          .calendarDay,
                                                      color: Color.fromARGB(
                                                          255, 0, 76, 128),
                                                    ),
                                                    onPressed: () {
                                                      _selectDate(context);
                                                    },
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(_selectedDate),
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          "HelveticaCondensed",
                                                      color: Color.fromARGB(
                                                          255, 0, 76, 128),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  const DataTableCustom(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dropdown,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Resumen de Cartera',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Saldo de Cartera (S/.)',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        Text(
                                          '${data[id].saldoCartera}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Monto Recuperado (S/.)',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        Text(
                                          '${data[id].montoRecuperado}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Saldo Vencido (S/.)',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        Text(
                                          '${data[id].saldoVencido}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Indice de Morosidad (%)',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        Text(
                                          '${data[id].indiceMorosidad}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Compromisos de Pago',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Generados',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        Text(
                                          '${data[id].compromisosGenerado}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Sin Cumplir',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        Text(
                                          '${data[id].compromisosSinCumplir}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Cumplidos',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        Text(
                                          '${data[id].compromisosCumplidos}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'N° Visitas por modalidad',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 76, 128),
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaCondensed',
                                          ),
                                        ),
                                        SfCircularChart(
                                          legend: const Legend(
                                            isVisible: true,
                                            isResponsive: true,
                                            alignment: ChartAlignment.center,
                                            position: LegendPosition.bottom,
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'HelveticaCondensed',
                                            ),
                                          ),
                                          series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                                legendIconType:
                                                    LegendIconType.rectangle,
                                                enableTooltip: true,
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                        isVisible: true,
                                                        textStyle: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'HelveticaCondensed',
                                                        ),
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        labelPosition:
                                                            ChartDataLabelPosition
                                                                .outside,
                                                        connectorLineSettings:
                                                            ConnectorLineSettings(
                                                                width: 3)),
                                                explode: true,
                                                dataSource: chartData,
                                                pointColorMapper:
                                                    (ChartData data, _) =>
                                                        data.color,
                                                xValueMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, _) =>
                                                        data.y)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext contex) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('en'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 0, 76, 128),
            hintColor: const Color.fromARGB(255, 140, 178, 210),
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 0, 76, 128),
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked!;
      });
    } else {
      picked = DateTime.now();
      setState(() {
        _selectedDate = picked!;
      });
    }
  }

  void _pickYear(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Select Year",
            style: TextStyle(
              fontFamily: "HelveticaCondensed",
            ),
          ),
          content: SizedBox(
            // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              // save the selected date to _selectedDate DateTime variable.
              // It's used to set the previous selected date when
              // re-showing the dialog.
              selectedDate: year,
              onChanged: (DateTime dateTime) {
                // close the dialog when year is selected.
                setState(() {
                  year = dateTime;
                });
                Navigator.pop(context);

                // Do something with the dateTime selected.
                // Remember that you need to use dateTime.year to get the year
              },
            ),
          ),
        );
      },
    );
  }
}

class Pie extends StatelessWidget {
  const Pie({
    super.key,
    required this.chartData,
  });

  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SfCircularChart(
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              radius: '60%',
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: const Text(
                'COMPROMISOS DE PAGO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 76, 127),
                  fontSize: 18.0,
                  fontFamily: 'HelveticaCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Colors.grey[300],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: chartData[0].color,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Text(
                        '${chartData[0].x}:',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'HelveticaCondensed',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "${chartData[0].y.toInt()}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: 'HelveticaCondensed',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Colors.grey[300],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: chartData[1].color,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Text(
                        '${chartData[1].x}:',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'HelveticaCondensed',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "${chartData[1].y.toInt()}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: 'HelveticaCondensed',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BarGraph extends StatelessWidget {
  final int cantidadPromocion;
  final int cantidadSeguimiento;
  final int cantidadRecuperacion;
  const BarGraph({
    super.key,
    required this.cantidadPromocion,
    required this.cantidadSeguimiento,
    required this.cantidadRecuperacion,
  });

  @override
  Widget build(BuildContext context) {
    int maximo =
        max(cantidadPromocion, max(cantidadSeguimiento, cantidadRecuperacion));
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              constraints: const BoxConstraints(maxWidth: 200),
              child: const Text(
                'NEGOCIACIÓN DE CARTERA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 76, 127),
                  fontSize: 18.0,
                  fontFamily: 'HelveticaCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Colors.grey[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bar(
                    name: "PROMOCIÓN",
                    color: Colors.orange,
                    amount: 15,
                    percentage: cantidadPromocion / maximo,
                  ),
                  const SizedBox(height: 10),
                  Bar(
                    name: "SEGUIMIENTO",
                    color: const Color.fromARGB(255, 14, 129, 60),
                    amount: 40,
                    percentage: cantidadSeguimiento / maximo,
                  ),
                  const SizedBox(height: 10),
                  Bar(
                    name: "RECUPERACIÓN",
                    color: Colors.green,
                    amount: 50,
                    percentage: cantidadRecuperacion / maximo,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String name;
  final Color color;
  final int amount;
  final double percentage;
  const Bar({
    super.key,
    required this.name,
    required this.color,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 140),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: color,
              fontFamily: 'HelveticaCondensed',
            ),
          ),
        ),
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 20),
            child: LinearProgressIndicator(
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              value: percentage,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(minWidth: 50),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "$amount",
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'HelveticaCondensed',
            ),
          ),
        ),
      ],
    );
  }
}

class CardDinero extends StatelessWidget {
  final String name;
  final int monto;
  final Color color;

  const CardDinero({
    super.key,
    required this.name,
    required this.monto,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'HelveticaCondensed',
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "S/. $monto",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontFamily: 'HelveticaCondensed',
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

class _ChartData {
  _ChartData(
      this.idAnalista,
      this.nombreAnalista,
      this.apellidosAnalista,
      this.saldoCartera,
      this.montoRecuperado,
      this.saldoVencido,
      this.indiceMorosidad,
      this.compromisosGenerado,
      this.compromisosSinCumplir,
      this.compromisosCumplidos,
      this.numeroVisitasPromocion,
      this.numeroVisitasSeguimiento,
      this.numeroVisitasRecuperacion,
      this.numeroVisitasAmpliacion,
      this.numeroVisitasTotal,
      this.porcentajeVisitasRealizadas,
      this.estado);

  final int idAnalista;
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
}
