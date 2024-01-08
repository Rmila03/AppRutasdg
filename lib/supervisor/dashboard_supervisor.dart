import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/custom_dropdown.dart';

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
  //final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
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
                          color: Colors.green,
                          fontSize: 20.0,
                          fontFamily: 'Unna-Bold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const SizedBox(
                      width: 300,
                      child: CustomDropdown(
                        items: [
                          'Juan Perez Garcia',
                          'Ruth Milagros Arce Quispe',
                          'Stiward Maldonado',
                          'Justino Ferro'
                        ],
                        borderColor: Colors.green,
                        lenItem: 15,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      color: Colors.green, // Color de fondo del Container
                      padding: const EdgeInsets.all(
                          20.0), // Padding alrededor del texto
                      child: const Text(
                        'ARCE, ARLED',
                        style: TextStyle(
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
                          "${chartData[0].y}",
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
                          "${chartData[1].y}",
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
