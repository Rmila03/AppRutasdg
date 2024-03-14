import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/widgets/menu_supervisor_mobile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/custom_dropdown.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ruta_sdg/analista.dart';

class DashboardSupervisorPage extends StatefulWidget {
  const DashboardSupervisorPage({super.key});

  @override
  State<DashboardSupervisorPage> createState() =>
      _DashboardSupervisorPageState();
}

class _DashboardSupervisorPageState extends State<DashboardSupervisorPage> {
  final List<ChartData> chartData = [
    ChartData('Cumplidos', 10, Colors.orange),
    ChartData('Sin cumplir', 2, Colors.green),
  ];
  String selectedItem = '';
  String opcionFecha = '';
  DateTime day = DateTime.now();
  DateTime month = DateTime.now();
  DateTime year = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      const Center(
                        child: Text(
                          'DASHBOARD',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 76, 128),
                            fontSize: 20.0,
                            fontFamily: 'Unna-Bold',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          SizedBox(
                            width: 300,
                            child: CustomDropdown(
                              items: getAnalistas()
                                  .map((objeto) =>
                                      '${objeto.name} ${objeto.lastName}')
                                  .toList(),
                              borderColor:
                                  const Color.fromARGB(255, 0, 76, 128),
                              lenItem: 15,
                              onChanged: (String? nuevoItem) {
                                setState(() {
                                  selectedItem = nuevoItem ?? '';
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 250,
                            child: CustomDropdown(
                              items: const [
                                'Dia',
                                'Mes',
                                'Año',
                              ],
                              borderColor: Colors.green,
                              lenItem: 15,
                              hint: 'Seleccione el tipo de fecha',
                              onChanged: (String? Item) {
                                setState(() {
                                  opcionFecha = Item ?? '';
                                });
                              },
                            ),
                          ),

                          if (opcionFecha == 'Año')
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.calendarDay,
                                color: Color.fromARGB(255, 0, 76, 128),
                              ),
                              onPressed: () {
                                _pickYear(context);
                              },
                            ),
                          if (opcionFecha == 'Mes')
                            IconButton(
                              onPressed: () {
                                showMonthPicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        locale: const Locale('es'),
                                        headerColor: const Color.fromARGB(
                                            255, 4, 56, 99),
                                        selectedMonthTextColor: Colors.white,
                                        unselectedMonthTextColor: Colors.black,
                                        selectedMonthBackgroundColor:
                                            const Color.fromARGB(
                                                255, 4, 56, 99))
                                    .then((date) {
                                  if (date != null) {
                                    setState(() {
                                      month = date;
                                    });
                                  }
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.calendarDay,
                                color: Color.fromARGB(255, 0, 76, 128),
                              ),
                            ),
                          if (opcionFecha == 'Dia')
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.calendarDay,
                                color: Color.fromARGB(255, 0, 76, 128),
                              ),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.fallback(),
                                      child: child!,
                                    );
                                  },
                                  //locale: const Locale("es"),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1920),
                                  lastDate: DateTime(2100),
                                ).then((date) {
                                  setState(() {
                                    day = date!;
                                  });
                                });
                                //_selectDate(context);
                              },
                            ),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('dd/MM/yyyy').format(_selectedDate),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 76, 128),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          //DatePicker(initialMode: DatePickerMode.year),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        width: double.infinity,
                        color: Colors.green, // Color de fondo del Container
                        padding: const EdgeInsets.all(
                            20.0), // Padding alrededor del texto
                        child: Text(
                          selectedItem.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white, // Color del texto
                            fontSize: 16.0,
                            fontFamily: 'Unna-Bold',
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Expanded(
                                  child: CardDinero(
                                    name: "SALDO DE CARTERA",
                                    monto: 24000,
                                    color: Colors.orange,
                                  ),
                                ),
                                Expanded(
                                  child: CardDinero(
                                    name: "MONTO RECUPERADO",
                                    monto: 14000,
                                    color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  child: CardDinero(
                                    name: "SALDO VENCIDO",
                                    monto: 24000,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                            const BarGraph(
                              cantidadPromocion: 15,
                              cantidadSeguimiento: 40,
                              cantidadRecuperacion: 50,
                            ),
                            Pie(chartData: chartData),
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
    );
  }

  Future<void> _selectDate(BuildContext contex) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('es'),
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
          title: const Text("Select Year"),
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
                  fontFamily: 'Unna-Bold',
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
                          fontFamily: 'Unna-Bold',
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
                            fontFamily: 'Unna-Bold',
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
                          fontFamily: 'Unna-Bold',
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
                            fontFamily: 'Unna-Bold',
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
                  fontFamily: 'Unna-Bold',
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
            style: const TextStyle(fontSize: 15),
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
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "S/. $monto",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
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
  final double y;
  final Color color;
}
