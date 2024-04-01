import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/widgets/cartera_form.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/supervisor/widgets/mora_form.dart';
import 'package:ruta_sdg/supervisor/widgets/plan_dia_form.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/widgets/menu_supervisor_mobile.dart';

class ListaSupervisor extends StatefulWidget {
  final Socio? socio;
  final String tabName;

  const ListaSupervisor({
    super.key,
    required this.tabName,
    this.socio,
  });

  @override
  ListaSupervisorState createState() => ListaSupervisorState();
}

class ListaSupervisorState extends State<ListaSupervisor> {
  late Widget CasoFormWidget; // Declara la variable para la redirección
  late Widget MenuWidget;
  @override
  void initState() {
    super.initState();
    // Asigna la redirección según el valor de tabName
    if (widget.tabName == 'CARTERA') {
      CasoFormWidget = CarteraForm(
        socio: widget.socio!,
      );

      MenuWidget = const MenuSupervisor(name: "CARTERA");
    } else if (widget.tabName == 'PLAN DEL DÍA') {
      CasoFormWidget = PlanDiaSupervisor(
        socio: widget.socio!,
      );
      MenuWidget = const MenuSupervisor(name: "PLAN DEL DÍA");
    } else if (widget.tabName == 'MORA') {
      CasoFormWidget = MoraForm(
        socio: widget.socio!,
      );
      MenuWidget = const MenuSupervisor(name: "MORA");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? const MenuSupervisorMobile(name: "CARTERA")
          : null,
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640) MenuWidget,
          Expanded(
            child: CasoFormWidget,
          ),
        ],
      ),
    );
  }
}
