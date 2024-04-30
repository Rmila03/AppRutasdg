import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruta_sdg/api.dart';
import 'package:ruta_sdg/providers/location_provider.dart';
import 'package:ruta_sdg/supervisor/views/homeSupervisor.dart';
import 'package:ruta_sdg/analista/views/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  /*WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/CERTIFICADO-SSL-SUNAT.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());*/
  HttpOverrides.global = MyHttpOverrides();
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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppRutasdg',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'HelveticaCondensed',
        useMaterial3: true,
      ),
      home: const SafeArea(
        child: Login(
          title: '',
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Positioned(
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
                                      ..color = Colors.white),
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
                ),
                Padding(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 40),
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
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
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
                                        icon: const Icon(
                                            Icons.remove_red_eye_outlined),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Usuario o contraseña incorrecta!',
                                            style: TextStyle(
                                                fontFamily:
                                                    "HelveticaCondensed"),
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
                              color: Colors.red,
                              fontFamily: "HelveticaCondensed"),
                          textAlign: TextAlign.center,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 220, 0),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    String token = await getToken();

    var url = Uri.parse(
        "https://wsdomingo.coopsantodomingo.com/laboratorio/login.php");
    // String bearerToken ="TsJhbGviOiJIUzI1wiIsInR5cCI6IkpXVCJ9.eyJBZG1pbmlzdHJhZG9yIjoiVVNVQVJJTyBHTE9CT0tBUyIsIklkdGVyY2VybyI6bnVsbCwiZmVjaGFob3JhIjoiMjAyNFwvMDJcLzE0XC8gMDk6Mjc6NTgifQ==.sjeliJRWXNuB1DwCkM6sYSwtZz6sO61RrnlzGlZOyus=";
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
        final user = Provider.of<UserData>(context, listen: false);
        if (rol == "ANALISTA") {
          user.setUser(idusuario, "Analista");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(idusuario: idusuario)),
          );
        }
        if (rol == "SUPERVISOR") {
          user.setUser(idusuario, "Supervisor");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeSupervisorPage(idusuario: idusuario)),
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
