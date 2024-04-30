import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
=======
import 'package:http/http.dart' as http;
import 'package:ruta_sdg/analista/views/home.dart';
>>>>>>> a328335e56f3b1e597db4fa0ed43c44c724aae05
import 'package:ruta_sdg/api.dart';
import 'package:ruta_sdg/providers/location_provider.dart';
import 'package:ruta_sdg/supervisor/views/homeSupervisor.dart';
import 'package:provider/provider.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
<<<<<<< HEAD
  //getData();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => UserData()),
      // Agrega más proveedores según sea necesario
    ],
    child: MyApp(),
  )
      /*MultiProvider(
      providers: [
        /*ChangeNotifierProvider<UserData>(
          create: (_) => UserData(),
        ),*/
        ChangeNotifierProxyProvider<UserData, LocationProvider>(
          create: (_) => LocationProvider(),
          update: (_, userData, locationProvider) =>
              LocationProvider(userData.userId),
        ),
      ],
      child: const MyApp(),
    ),*/
      );
=======
  runApp(MyApp());
>>>>>>> a328335e56f3b1e597db4fa0ed43c44c724aae05
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserData(), // Creamos una instancia de UserData
      child: MaterialApp(
        title: 'AppRutasdg',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'HelveticaCondensed',
          useMaterial3: true,
        ),
        home: SafeArea(
          child: Login(title: ''),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              _buildHeader(),
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        color: const Color.fromARGB(255, 0, 76, 128),
        width: MediaQuery.of(context).size.width,
        height: 220,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Text(
                    'RUTASDG',
                    style: TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      fontSize: 20,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.white,
                    ),
                  ),
                  const Text(
                    'RUTASDG',
                    style: TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      fontSize: 20,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topCenter,
                width: 400,
                height: 100,
                child: Image.asset(
                  'assets/NuevoLogo.png',
                  width: 200,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 175,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PhysicalModel(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            elevation: 5.0,
            shadowColor: Colors.black,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
              child: Column(
                children: [
                  const Text(
                    '¡BIENVENIDO!',
                    style: TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      fontSize: 17,
                      color: Color.fromARGB(255, 236, 130, 45),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                    height: 20.0,
                  ),
                  PhysicalModel(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    elevation: 5.0,
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: emailController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'HelveticaCondensed'),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Usuario",
                          hintText: "ejemplo@gmail.com",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "HelveticaCondensed"),
                          labelStyle: TextStyle(
                            fontFamily: "HelveticaCondensed",
                            fontWeight: FontWeight.bold,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                    height: 30.0,
                  ),
                  PhysicalModel(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    elevation: 5.0,
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Contraseña",
                          labelStyle: const TextStyle(
                            fontFamily: "HelveticaCondensed",
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye_outlined),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Usuario o contraseña incorrecta!',
                                style:
                                    TextStyle(fontFamily: "HelveticaCondensed"),
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          fontFamily: "HelveticaCondensed",
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showError)
            const Text(
              '¡Usuario o contraseña incorrectos!',
              style: TextStyle(
                  color: Colors.red, fontFamily: "HelveticaCondensed"),
              textAlign: TextAlign.center,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 220, 0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(180, 50),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  } else {
                    setState(() {
                      showError = true;
                    });
                  }
                },
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                      fontFamily: "HelveticaCondensed",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    String token = await getToken();

    var url = Uri.parse(
        "https://wsdomingo.coopsantodomingo.com/laboratorio/login.php");
    String username = emailController.text.trim();
    String password = passwordController.text.trim();
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
            {"usuario": username, "clave": password, "tipo": "CREDITOS"}),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*",
          'Authorization': 'Bearer $token',
          'Accept': '*/*'
        },
      );
      if (response.statusCode == 200) {
        String responseBody = utf8.decoder.convert(response.bodyBytes);
        var res = jsonDecode(responseBody);
        if (res == null) {
          setState(() {
            showError = true;
          });
          return;
        }
        String idusuario = res['idusuario'];
        String rol = res['rol'];
<<<<<<< HEAD
        final user = Provider.of<UserData>(context, listen: false);
=======
        final userData = Provider.of<UserData>(context,
            listen: false); // Obtenemos el estado global de UserData
        userData
            .setIdUsuario(idusuario); // Guardamos idusuario en el estado global
>>>>>>> a328335e56f3b1e597db4fa0ed43c44c724aae05
        if (rol == "ANALISTA") {
          user.setUser(idusuario, "Analista");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
        if (rol == "SUPERVISOR") {
          user.setUser(idusuario, "Supervisor");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeSupervisorPage(),
            ),
          );
        }
      } else {
        setState(() {
          showError = true;
        });
      }
    } catch (error) {
      print('Error during login: $error');
      setState(() {
        showError = true;
      });
    }
  }
}

class UserData extends ChangeNotifier {
  late String idusuario;

  void setIdUsuario(String id) {
    idusuario = id;
    notifyListeners();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
